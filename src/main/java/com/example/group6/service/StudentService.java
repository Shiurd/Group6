package com.example.group6.service;

import com.example.group6.dao.StudentDAO;
import com.example.group6.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {
    @Autowired
    private StudentDAO studentDAO;

    public Student authenticate(String email, String password) {
        return studentDAO.findByEmailAndPassword(email, password);
    }

    public Student getStudentByEmail(String email) {
        return studentDAO.findByEmail(email);
    }

    public void updateStudent(Student student) {
        studentDAO.save(student);
    }
}
