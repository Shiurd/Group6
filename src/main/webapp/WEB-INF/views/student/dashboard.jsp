<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Student Portal</a>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text me-3">Welcome, ${student.name}</span>
            <a class="nav-link" href="/student/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5>Student Information</h5>
                </div>
                <div class="card-body">
                    <p><strong>Name:</strong> ${student.name}</p>
                    <p><strong>Email:</strong> ${student.email}</p>
                    <p><strong>Phone:</strong> ${student.phone}</p>
                    <p><strong>Date of birth:</strong> ${student.dob}</p>
                    <p><strong>Class:</strong> ${student.classField}</p>
                </div>
                <div class="card-footer">
                    <a href="/student/profile" class="btn btn-sm btn-outline-primary">Edit Profile</a>
                </div>
            </div>

        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5>My Enrolled Courses</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty enrollments}">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Course Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${enrollments}" var="enrollment">
                                    <tr>
                                        <td>${enrollment.courses.name}</td>
                                        <td>${enrollment.courses.description}</td>
                                        <td>
                                                    <span class="badge ${enrollment.status == 'ACTIVE' ? 'bg-success' : 'bg-warning'}">
                                                            ${enrollment.status}
                                                    </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">You are not enrolled in any courses yet.</div>
                            <%--                            <a href="/student/courses" class="btn btn-primary">Browse Available Courses</a>--%>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>