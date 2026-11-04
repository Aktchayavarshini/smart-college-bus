package com.collegebus.config;

import com.collegebus.entity.Student;
import com.collegebus.entity.Teacher;
import com.collegebus.entity.User;
import com.collegebus.repository.StudentRepository;
import com.collegebus.repository.TeacherRepository;
import com.collegebus.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Locale;

/**
 * Opt-in production evaluator accounts. Disabled by default.
 * Existing account passwords are never overwritten.
 */
@Component
@Profile("prod")
@ConditionalOnProperty(name = "app.demo-accounts.enabled", havingValue = "true")
public class ProductionDemoAccountInitializer implements CommandLineRunner {
    private final UserRepository users;
    private final StudentRepository students;
    private final TeacherRepository teachers;
    private final PasswordEncoder encoder;

    @Value("${app.demo-accounts.admin-password}")
    private String adminPassword;
    @Value("${app.demo-accounts.student-password}")
    private String studentPassword;
    @Value("${app.demo-accounts.teacher-password}")
    private String teacherPassword;

    public ProductionDemoAccountInitializer(UserRepository users, StudentRepository students,
            TeacherRepository teachers, PasswordEncoder encoder) {
        this.users = users;
        this.students = students;
        this.teachers = teachers;
        this.encoder = encoder;
    }

    @Override
    @Transactional
    public void run(String... args) {
        User admin = ensureUser("Transport Administrator", "admin@collegebus.edu",
                adminPassword, "9876543210", "ADMIN");
        User student = ensureUser("Mukesh K", "student@collegebus.edu",
                studentPassword, "9876543211", "STUDENT");
        User teacher = ensureUser("Dr. Arulmozhi Varman", "teacher@collegebus.edu",
                teacherPassword, "9876543213", "TEACHER");

        if (!students.findByUser(student).isPresent()
                && !students.existsByRollNumber("2025IT0101")) {
            students.save(new Student(student, "2025IT0101", "Information Technology",
                    3, 5, "DAY_SCHOLAR", null));
        }
        if (!teachers.findByUser(teacher).isPresent()
                && !teachers.existsByEmployeeId("EMP-CSE-402")) {
            teachers.save(new Teacher(teacher, "EMP-CSE-402", "Computer Science",
                    "Associate Professor"));
        }
        System.out.println("[DEMO-ACCOUNTS] Evaluator accounts verified/created; existing passwords preserved.");
    }

    private User ensureUser(String name, String email, String rawPassword, String phone, String role) {
        if (rawPassword == null || rawPassword.isBlank()) {
            throw new IllegalStateException("Demo account passwords must be configured before enabling demo accounts.");
        }
        String normalizedEmail = email.toLowerCase(Locale.ROOT);
        User user = users.findByEmail(normalizedEmail).orElseGet(() ->
                users.save(new User(name, normalizedEmail, encoder.encode(rawPassword), phone, role)));
        if (!role.equalsIgnoreCase(user.getRole())) {
            throw new IllegalStateException("Existing evaluator account has an unexpected role: " + normalizedEmail);
        }
        return user;
    }
}
