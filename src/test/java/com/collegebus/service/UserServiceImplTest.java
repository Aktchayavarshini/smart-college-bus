package com.collegebus.service;

import com.collegebus.dto.UserRegistrationDto;
import com.collegebus.repository.StudentRepository;
import com.collegebus.repository.TeacherRepository;
import com.collegebus.repository.UserRepository;
import com.collegebus.service.impl.UserServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class UserServiceImplTest {
    @Mock private UserRepository userRepository;
    @Mock private StudentRepository studentRepository;
    @Mock private TeacherRepository teacherRepository;
    @Mock private PasswordEncoder passwordEncoder;
    @InjectMocks private UserServiceImpl userService;

    @Test
    void selfRegistrationRejectsAdminAndUnknownRolesBeforePersistence() {
        UserRegistrationDto dto = new UserRegistrationDto();
        dto.setEmail("attacker@example.com");
        dto.setRole("ADMIN");

        assertThrows(IllegalArgumentException.class, () -> userService.registerUser(dto));
        verify(userRepository, never()).save(org.mockito.ArgumentMatchers.any());
    }

    @Test
    void selfRegistrationRejectsUnknownRolesBeforePersistence() {
        UserRegistrationDto dto = new UserRegistrationDto();
        dto.setEmail("attacker@example.com");
        dto.setRole("SUPERUSER");

        assertThrows(IllegalArgumentException.class, () -> userService.registerUser(dto));
        verify(userRepository, never()).save(org.mockito.ArgumentMatchers.any());
    }
}
