package com.collegebus.service;

import com.collegebus.dto.UserRegistrationDto;
import com.collegebus.entity.Student;
import com.collegebus.entity.Teacher;
import com.collegebus.entity.User;

import java.util.Optional;

public interface UserService {

    User registerUser(UserRegistrationDto registrationDto);

    Optional<User> findByEmail(String email);

    User getByEmail(String email);

    User getAuthenticatedUser();

    Optional<Student> getStudentByUser(User user);

    Optional<Teacher> getTeacherByUser(User user);

    void updateUserProfile(String email, String fullName, String phoneNumber);

    long countStudents();

    long countTeachers();

    long countAdmins();

    long countTotalUsers();
}
