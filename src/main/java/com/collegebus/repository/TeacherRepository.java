package com.collegebus.repository;

import com.collegebus.entity.Teacher;
import com.collegebus.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {

    Optional<Teacher> findByUser(User user);

    Optional<Teacher> findByEmployeeId(String employeeId);

    boolean existsByEmployeeId(String employeeId);

    List<Teacher> findByDepartment(String department);
}
