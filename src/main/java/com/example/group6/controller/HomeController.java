package com.example.group6.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    public String home() {
        return "redirect:/student/login"; // Redirect to student login by default
        // or return "login"; // If you have a general login page
    }
}
