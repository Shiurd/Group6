<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enrollment Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .badge-active {
            background-color: #28a745;
        }

        .badge-completed {
            background-color: #17a2b8;
        }

        .badge-dropped {
            background-color: #dc3545;
        }

        .filter-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/fragments/navbar.jsp" %>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <!-- Sidebar -->
            <%@ include file="../sidebar.jsp" %>
        </div>

        <div class="col-md-9">
            <div class="card">
                <div class="card-header">
                    <h4>Enrollment Management</h4>
                </div>

                <div class="card-body">
                    <!-- Filter Section -->
                    <div class="filter-section">
                        <form method="get" class="row g-3">
                            <div class="col-md-5">
                                <select class="form-select" name="studentId">
                                    <option value="">Filter by Student</option>
                                    <c:forEach items="${students}" var="student">
                                        <option value="${student.id}" ${studentFilter != null && studentFilter.id == student.id ? 'selected' : ''}>
                                                ${student.name} (${student.classField})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-5">
                                <select class="form-select" name="courseId">
                                    <option value="">Filter by Course</option>
                                    <c:forEach items="${courses}" var="course">
                                        <option value="${course.id}" ${courseFilter != null && courseFilter.id == course.id ? 'selected' : ''}>
                                                ${course.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">Filter</button>
                            </div>
                        </form>
                    </div>

                    <!-- Add Enrollment Form -->
                    <div class="mb-4 p-3 border rounded">
                        <h5>Add New Enrollment</h5>
                        <form action="/admin/enrollments/add" method="post" class="row g-3">
                            <div class="col-md-4">
                                <select class="form-select" name="studentId" required>
                                    <option value="">Select Student</option>
                                    <c:forEach items="${students}" var="student">
                                        <option value="${student.id}">${student.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select" name="courseId" required>
                                    <option value="">Select Course</option>
                                    <c:forEach items="${courses}" var="course">
                                        <option value="${course.id}">${course.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="status" required>
                                    <option value="ACTIVE">Active</option>
                                    <option value="COMPLETED">Completed</option>
                                    <option value="DROPPED">Dropped</option>
                                </select>
                            </div>
                            <div class="col-md-1">
                                <button type="submit" class="btn btn-success w-100">Add</button>
                            </div>
                        </form>
                    </div>

                    <!-- Enrollments Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th>Student</th>
                                <th>Course</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <tr>
                                    <td>${enrollment.student.name}</td>
                                    <td>${enrollment.courses.name}</td>
                                    <td>
                                                <span class="badge ${enrollment.status == 'ACTIVE' ? 'badge-active' :
                                                                 enrollment.status == 'COMPLETED' ? 'badge-completed' : 'badge-dropped'}">
                                                        ${enrollment.status}
                                                </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary"
                                                data-bs-toggle="modal"
                                                data-bs-target="#editModal${enrollment.id}">
                                            Edit
                                        </button>
                                        <a href="/admin/enrollments/delete/${enrollment.id}"
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Are you sure you want to delete this enrollment?')">
                                            Delete
                                        </a>
                                    </td>
                                </tr>

                                <!-- Edit Modal for each enrollment -->
                                <div class="modal fade" id="editModal${enrollment.id}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit Enrollment</h5>
                                                <button type="button" class="btn-close"
                                                        data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="/admin/enrollments/update/${enrollment.id}" method="post">
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label class="form-label">Status</label>
                                                        <select class="form-select" name="status">
                                                            <option value="ACTIVE" ${enrollment.status == 'ACTIVE' ? 'selected' : ''}>
                                                                Active
                                                            </option>
                                                            <option value="COMPLETED" ${enrollment.status == 'COMPLETED' ? 'selected' : ''}>
                                                                Completed
                                                            </option>
                                                            <option value="DROPPED" ${enrollment.status == 'DROPPED' ? 'selected' : ''}>
                                                                Dropped
                                                            </option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-bs-dismiss="modal">Cancel
                                                    </button>
                                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
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