package com.example.group6.dao;

import com.example.group6.model.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EnrollmentDAO extends JpaRepository<Enrollment, Integer> {

    @Query("SELECT e FROM Enrollment e JOIN FETCH e.courses WHERE e.student.id = :studentId")
    List<Enrollment> findByStudentId(@Param("studentId") int studentId);

    @Query("SELECT e FROM Enrollment e JOIN FETCH e.student JOIN FETCH e.courses")
    List<Enrollment> findAllWithDetails();

    @Query("SELECT e FROM Enrollment e JOIN FETCH e.student JOIN FETCH e.courses WHERE e.id = :id")
    Enrollment findByIdWithDetails(@Param("id") int id);

    List<Enrollment> findByStudentId(Integer studentId);

    List<Enrollment> findByCoursesId(Integer courseId);

}
