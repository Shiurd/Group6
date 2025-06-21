package com.example.group6.service;

import com.example.group6.dao.AdminDAO;
import com.example.group6.model.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    private AdminDAO adminDAO;

    public Admin authenticate(String email, String password) {
        return adminDAO.findByEmailAndPassword(email, password);
    }
}
