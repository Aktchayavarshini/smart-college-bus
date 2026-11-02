package com.collegebus.service.impl;

import com.collegebus.dto.UserRegistrationDto;
import com.collegebus.entity.Student;
import com.collegebus.entity.Teacher;
import com.collegebus.entity.User;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.StudentRepository;
import com.collegebus.repository.TeacherRepository;
import com.collegebus.repository.UserRepository;
import com.collegebus.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final StudentRepository studentRepository;
    private final TeacherRepository teacherRepository;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository,
                           StudentRepository studentRepository,
                           TeacherRepository teacherRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.studentRepository = studentRepository;
        this.teacherRepository = teacherRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User registerUser(UserRegistrationDto dto) {
        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new IllegalArgumentException("An account with email " + dto.getEmail() + " already exists.");
        }

        String role = dto.getRole().toUpperCase();
        if ("ADMIN".equals(role)) {
            throw new IllegalArgumentException("Direct registration for Administrator role is not permitted.");
        }

        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail().toLowerCase().trim());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setPhoneNumber(dto.getPhoneNumber());
        user.setRole(role);
        user.setAccountStatus("ACTIVE");

        User savedUser = userRepository.save(user);

        if ("STUDENT".equals(role)) {
            if (studentRepository.existsByRollNumber(dto.getRollNumber())) {
                throw new IllegalArgumentException("Roll number " + dto.getRollNumber() + " is already registered.");
            }
            Student student = new Student();
            student.setUser(savedUser);
            student.setRollNumber(dto.getRollNumber());
            student.setDepartment(dto.getStudentDepartment());
            student.setAcademicYear(dto.getAcademicYear() != null ? dto.getAcademicYear() : 1);
            student.setSemester(dto.getSemester() != null ? dto.getSemester() : 1);
            student.setStudentType(dto.getStudentType() != null ? dto.getStudentType() : "DAY_SCHOLAR");
            student.setHostelName(dto.getHostelName());
            studentRepository.save(student);
        } else if ("TEACHER".equals(role)) {
            if (teacherRepository.existsByEmployeeId(dto.getEmployeeId())) {
                throw new IllegalArgumentException("Employee ID " + dto.getEmployeeId() + " is already registered.");
            }
            Teacher teacher = new Teacher();
            teacher.setUser(savedUser);
            teacher.setEmployeeId(dto.getEmployeeId());
            teacher.setDepartment(dto.getTeacherDepartment());
            teacher.setDesignation(dto.getDesignation());
            teacherRepository.save(teacher);
        }

        return savedUser;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public User getByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + email));
    }

    @Override
    @Transactional(readOnly = true)
    public User getAuthenticatedUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            return null;
        }
        return getByEmail(auth.getName());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Student> getStudentByUser(User user) {
        return studentRepository.findByUser(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Teacher> getTeacherByUser(User user) {
        return teacherRepository.findByUser(user);
    }

    @Override
    public void updateUserProfile(String email, String fullName, String phoneNumber) {
        User user = getByEmail(email);
        user.setFullName(fullName);
        user.setPhoneNumber(phoneNumber);
        userRepository.save(user);
    }

    @Override
    @Transactional(readOnly = true)
    public long countStudents() {
        return userRepository.countByRole("STUDENT");
    }

    @Override
    @Transactional(readOnly = true)
    public long countTeachers() {
        return userRepository.countByRole("TEACHER");
    }

    @Override
    @Transactional(readOnly = true)
    public long countAdmins() {
        return userRepository.countByRole("ADMIN");
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalUsers() {
        return userRepository.count();
    }
}
