<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Student Portal</a>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text me-3">Welcome, ${student.name}</span>
            <a class="nav-link" href="/student/dashboard">Dashboard</a>
            <a class="nav-link" href="/student/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4>Edit Profile</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form action="/student/update-profile" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="${student.name}" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email"
                                   value="${student.email}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   value="${student.phone}">
                        </div>

                        <div class="mb-3">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="dob" name="dob"
                                   value="${student.dob}">
                        </div>

                        <div class="mb-3">
                            <label for="studentClass" class="form-label">Class</label>
                            <input type="text" class="form-control" id="studentClass" name="classField"
                                   value="${student.classField}">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                            <a href="/student/dashboard" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>