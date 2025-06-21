package com.example.group6.dao;

import com.example.group6.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminDAO extends JpaRepository<Admin, Integer> {
    Admin findByEmailAndPassword(String email, String password);
}

