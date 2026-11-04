package com.collegebus.config;

import com.collegebus.entity.User;
import com.collegebus.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Locale;

/**
 * Optional, one-time production administrator bootstrap.
 * Disabled by default and must be disabled again after the first admin is created.
 */
@Component
@Profile("prod")
@ConditionalOnProperty(prefix = "app.admin", name = "bootstrap-enabled", havingValue = "true")
public class AdminBootstrapRunner implements ApplicationRunner {
    private static final Logger log = LoggerFactory.getLogger(AdminBootstrapRunner.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final String fullName;
    private final String email;
    private final String password;
    private final String phoneNumber;

    public AdminBootstrapRunner(
            UserRepository userRepository,
            PasswordEncoder passwordEncoder,
            @Value("${INITIAL_ADMIN_NAME:}") String fullName,
            @Value("${INITIAL_ADMIN_EMAIL:}") String email,
            @Value("${INITIAL_ADMIN_PASSWORD:}") String password,
            @Value("${INITIAL_ADMIN_PHONE:}") String phoneNumber) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
    }

    @Override
    public void run(ApplicationArguments args) {
        boolean adminExists = userRepository.findAll().stream()
                .anyMatch(user -> "ADMIN".equalsIgnoreCase(user.getRole()));
        if (adminExists) {
            log.info("Production administrator already exists; bootstrap skipped.");
            return;
        }

        String normalizedEmail = email == null ? "" : email.trim().toLowerCase(Locale.ROOT);
        if (fullName == null || fullName.isBlank() || normalizedEmail.isBlank()
                || password == null || password.length() < 8 || password.length() > 72
                || phoneNumber == null || phoneNumber.isBlank()) {
            throw new IllegalStateException("Admin bootstrap is enabled but INITIAL_ADMIN_NAME, INITIAL_ADMIN_EMAIL, INITIAL_ADMIN_PASSWORD (8-72 chars), and INITIAL_ADMIN_PHONE are not all configured.");
        }

        User admin = new User();
        admin.setFullName(fullName.trim());
        admin.setEmail(normalizedEmail);
        admin.setPassword(passwordEncoder.encode(password));
        admin.setPhoneNumber(phoneNumber.trim());
        admin.setRole("ADMIN");
        admin.setAccountStatus("ACTIVE");
        userRepository.save(admin);
        log.warn("Initial production administrator {} was created. Disable ADMIN_BOOTSTRAP_ENABLED and remove the bootstrap credentials now.", normalizedEmail);
    }
}
