package com.example.group6.controller;


import com.example.group6.dao.CourseDAO;
import com.example.group6.dao.EnrollmentDAO;
import com.example.group6.dao.StudentDAO;
import com.example.group6.model.Admin;
import com.example.group6.model.Enrollment;
import com.example.group6.model.Student;
import com.example.group6.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    @Autowired
    private StudentDAO studentDAO;
    @Autowired
    private EnrollmentDAO enrollmentDAO;
    @Autowired
    private CourseDAO courseDAO;


    @GetMapping("/login")
    public String showAdminLoginPage() {
        return "admin/login";
    }

    @GetMapping("/dashboard")
    public String showAdminDashboard(HttpSession session, @RequestParam(required = false) String search,
                                     @RequestParam(required = false) String action,
                                     @RequestParam(required = false) Integer studentId,
                                     Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        // Handle actions
        if ("edit".equals(action) && studentId != null) {
            Student student = studentDAO.findById(studentId)
                    .orElse(new Student());
            model.addAttribute("editStudent", student);
        }

        // Search or list all students
        if (search != null && !search.isEmpty()) {
            model.addAttribute("students", studentDAO.searchStudents(search));
        } else {
            model.addAttribute("students", studentDAO.findAll());
        }

        model.addAttribute("newStudent", new Student());
        return "admin/dashboard";
    }

    @PostMapping("/login")
    public String adminLogin(@RequestParam String email,
                             @RequestParam String password,
                             HttpSession session,
                             Model model) {
        Admin admin = adminService.authenticate(email, password);
        if (admin != null) {
            session.setAttribute("admin", admin);
            return "redirect:/admin/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "admin/login";
        }
    }


    @GetMapping("/logout")
    public String adminLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }


    // Add Student
    @PostMapping("/add-student")
    public String addStudent(@ModelAttribute Student newStudent) {
        newStudent.setPassword("1");
        studentDAO.save(newStudent);
        return "redirect:/admin/dashboard";
    }

    // Update Student
    @PostMapping("/update-student")
    public String updateStudent(@ModelAttribute Student editStudent) {
        studentDAO.save(editStudent);
        return "redirect:/admin/dashboard";
    }

    // Delete Student
    @GetMapping("/delete-student/{id}")
    public String deleteStudent(@PathVariable Integer id) {
        studentDAO.deleteById(id);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/enrollments")
    public String viewEnrollments(
            @RequestParam(required = false) Integer studentId,
            @RequestParam(required = false) Integer courseId,
            Model model) {

        List<Enrollment> enrollments;
        if (studentId != null) {
            enrollments = enrollmentDAO.findByStudentId(studentId);
            model.addAttribute("studentFilter", studentDAO.findById(studentId).orElse(null));
        } else if (courseId != null) {
            enrollments = enrollmentDAO.findByCoursesId(courseId);
            model.addAttribute("courseFilter", courseDAO.findById(courseId).orElse(null));
        } else {
            enrollments = enrollmentDAO.findAllWithDetails();
        }

        model.addAttribute("enrollments", enrollments);
        model.addAttribute("students", studentDAO.findAll());
        model.addAttribute("courses", courseDAO.findAll());
        model.addAttribute("newEnrollment", new Enrollment());
        return "admin/enrollments";
    }

    @PostMapping("/enrollments/add")
    public String addEnrollment(
            @RequestParam Integer studentId,
            @RequestParam Integer courseId,
            @RequestParam String status) {

        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(studentDAO.findById(studentId).orElseThrow());
        enrollment.setCourses(courseDAO.findById(courseId).orElseThrow());
        enrollment.setStatus(status);
        enrollmentDAO.save(enrollment);

        return "redirect:/admin/enrollments";
    }

    @PostMapping("/enrollments/update/{id}")
    public String updateEnrollment(
            @PathVariable Integer id,
            @RequestParam String status,
            @RequestParam(required = false) Double grade,
            @RequestParam(required = false) String comments) {

        Enrollment enrollment = enrollmentDAO.findById(id).orElseThrow();
        enrollment.setStatus(status);
        enrollmentDAO.save(enrollment);

        return "redirect:/admin/enrollments";
    }

    @GetMapping("/enrollments/delete/{id}")
    public String deleteEnrollment(@PathVariable Integer id) {
        enrollmentDAO.deleteById(id);
        return "redirect:/admin/enrollments";
    }
}
