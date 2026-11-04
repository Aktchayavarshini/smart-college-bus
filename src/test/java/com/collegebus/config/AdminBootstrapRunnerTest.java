package com.collegebus.config;

import com.collegebus.entity.User;
import com.collegebus.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AdminBootstrapRunnerTest {
    @Mock private UserRepository userRepository;
    @Mock private PasswordEncoder passwordEncoder;

    @Test
    void createsHashedAdminOnlyWhenNoAdminExists() throws Exception {
        when(userRepository.findAll()).thenReturn(List.of());
        when(passwordEncoder.encode("StrongPass123!")).thenReturn("bcrypt-hash");
        AdminBootstrapRunner runner = new AdminBootstrapRunner(userRepository, passwordEncoder,
                "Initial Admin", "ADMIN@EXAMPLE.COM", "StrongPass123!", "+911234567890");

        runner.run(null);

        ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);
        verify(userRepository).save(captor.capture());
        User saved = captor.getValue();
        assertEquals("admin@example.com", saved.getEmail());
        assertEquals("ADMIN", saved.getRole());
        assertEquals("ACTIVE", saved.getAccountStatus());
        assertEquals("bcrypt-hash", saved.getPassword());
    }

    @Test
    void skipsBootstrapWhenAnAdminAlreadyExists() throws Exception {
        User existing = new User();
        existing.setRole("ADMIN");
        when(userRepository.findAll()).thenReturn(List.of(existing));
        AdminBootstrapRunner runner = new AdminBootstrapRunner(userRepository, passwordEncoder,
                "Initial Admin", "admin@example.com", "StrongPass123!", "+911234567890");

        runner.run(null);

        verify(userRepository, never()).save(any(User.class));
        verifyNoInteractions(passwordEncoder);
    }

    @Test
    void failsClosedWhenBootstrapCredentialsAreIncomplete() {
        when(userRepository.findAll()).thenReturn(List.of());
        AdminBootstrapRunner runner = new AdminBootstrapRunner(userRepository, passwordEncoder,
                "Initial Admin", "admin@example.com", "short", "+911234567890");

        assertThrows(IllegalStateException.class, () -> runner.run(null));
        verify(userRepository, never()).save(any(User.class));
    }
}
