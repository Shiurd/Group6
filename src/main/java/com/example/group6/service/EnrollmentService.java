package com.example.group6.service;

import com.example.group6.dao.EnrollmentDAO;
import com.example.group6.model.Enrollment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnrollmentService {

    @Autowired
    private EnrollmentDAO enrollmentDAO;

    public List<Enrollment> getEnrollmentsByStudentId(int studentId) {
        return enrollmentDAO.findByStudentId(studentId);
    }
}
