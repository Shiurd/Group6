<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="/admin/dashboard">
            <i class="fas fa-user-shield me-2"></i>Admin Panel
        </a>

        <div class="d-flex">
            <a class=" btn btn-outline-light" href="/admin/logout">
                <i class="fas fa-sign-out-alt me-1">LogoutS</i>
            </a>

        </div>
    </div>
</nav>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    .navbar {
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 0.5rem 1rem;
    }

    .btn-outline-light:hover {
        color: var(--bs-primary) !important;
    }
</style>