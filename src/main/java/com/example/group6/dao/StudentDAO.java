package com.example.group6.dao;

import com.example.group6.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentDAO extends JpaRepository<Student, Integer> {
    Student findByEmailAndPassword(String email, String password);

    Student findByEmail(String email);

    @Query("SELECT s FROM Student s WHERE " +
            "LOWER(s.name) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
            "LOWER(s.email) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
            "LOWER(s.classField) LIKE LOWER(CONCAT('%', :search, '%'))")
    List<Student> searchStudents(@Param("search") String search);
}
