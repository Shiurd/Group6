package com.example.group6.controller;

import com.example.group6.model.Enrollment;
import com.example.group6.model.Student;
import com.example.group6.service.EnrollmentService;
import com.example.group6.service.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class StudentController {
    @Autowired
    private StudentService studentService;

    @Autowired
    private EnrollmentService enrollmentService;

    @GetMapping("/student/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/student/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        Student student = studentService.authenticate(email, password);
        if (student != null) {
            session.setAttribute("student", student);
            return "redirect:/student/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
    }

    @GetMapping("/student/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) {
            return "redirect:/student/login";
        }
        List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudentId(student.getId());

        model.addAttribute("student", student);
        model.addAttribute("enrollments", enrollments);
        return "student/dashboard";
    }

    @GetMapping("/student/profile")
    public String showProfileForm(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) {
            return "redirect:/student/login";
        }
        model.addAttribute("student", student);
        return "student/profile";
    }

    @PostMapping("/student/update-profile")
    public String updateProfile(
            @ModelAttribute Student updatedStudent,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Student currentStudent = (Student) session.getAttribute("student");
        if (currentStudent == null) {
            return "redirect:/student/login";
        }

        // Update only allowed fields (don't allow changing email or ID)
        currentStudent.setName(updatedStudent.getName());
        currentStudent.setPhone(updatedStudent.getPhone());
        currentStudent.setDob(updatedStudent.getDob());
        currentStudent.setClassField(updatedStudent.getClassField());

        studentService.updateStudent(currentStudent);

        // Update session with new data
        session.setAttribute("student", currentStudent);

        redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/student/profile";
    }

    @GetMapping("/student/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/student/login";
    }
}
