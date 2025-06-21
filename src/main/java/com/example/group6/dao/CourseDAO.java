package com.example.group6.dao;

import com.example.group6.model.Cours;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseDAO extends JpaRepository<Cours, Integer> {

}
