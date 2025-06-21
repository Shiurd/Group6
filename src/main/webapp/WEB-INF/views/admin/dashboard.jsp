<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .student-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }

        .action-btns {
            white-space: nowrap;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/fragments/navbar.jsp" %>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group list-group-flush">
                <a href="/admin/dashboard" class="list-group-item list-group-item-action active">Students</a>
                <a href="/admin/enrollments" class="list-group-item list-group-item-action">Enrollments</a>
                <!-- Other menu items -->
            </div>
        </div>

        <div class="col-md-9">
            <!-- Student Management Section -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>Student Management</h4>
                    <form class="d-flex" method="get" action="/admin/dashboard">
                        <input class="form-control me-2" type="search" name="search"
                               placeholder="Search students..." value="${param.search}">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                </div>

                <div class="card-body">
                    <!-- Add/Edit Student Form -->
                    <div class="student-form mb-4">
                        <h5>${editStudent == null ? 'Add New' : 'Edit'} Student</h5>
                        <form action="/admin/${editStudent == null ? 'add' : 'update'}-student" method="post">
                            <c:if test="${editStudent != null}">
                                <input type="hidden" name="id" value="${editStudent.id}">
                            </c:if>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" name="name"
                                           value="${editStudent.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email"
                                           value="${editStudent.email}" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Phone</label>
                                    <input type="tel" class="form-control" name="phone"
                                           value="${editStudent.phone}">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Date of birth</label>
                                    <input type="text" class="form-control" name="dob"
                                           value="${editStudent.dob}" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Class</label>
                                    <input type="text" class="form-control" name="classField"
                                           value="${editStudent.classField}" required>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">
                                        ${editStudent == null ? 'Add' : 'Update'} Student
                                    </button>
                                    <c:if test="${editStudent != null}">
                                        <a href="/admin/dashboard" class="btn btn-secondary">Cancel</a>
                                    </c:if>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Students Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Date of birth</th>
                                <th>Class</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${students}" var="student">
                                <tr>
                                    <td>${student.name}</td>
                                    <td>${student.email}</td>
                                    <td>${student.phone}</td>
                                    <td>${student.dob}</td>

                                    <td>${student.classField}</td>
                                    <td class="action-btns">
                                        <a href="/admin/dashboard?action=edit&studentId=${student.id}"
                                           class="btn btn-sm btn-outline-primary">Edit</a>
                                        <a href="/admin/delete-student/${student.id}"
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Delete this student?')">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>