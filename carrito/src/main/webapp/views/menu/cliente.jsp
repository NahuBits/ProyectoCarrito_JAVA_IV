<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="models.Usuario"%>
<%
// Evita que el navegador muestre esta vista desde caché
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

Usuario usuario = (Usuario) session.getAttribute("usuario");
if (usuario == null || usuario.getTipo() == null || !usuario.getTipo().name().equals("CLIENTE")) {
    response.sendRedirect("../../login");
    return;
}
String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Panel del Cliente</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- CSS personalizado -->
<link href="<%= ctx %>/css/estilos.css" rel="stylesheet">

</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow mx-auto" style="max-width: 500px;">
            <div class="card-body text-center">
                <h3 class="card-title">Bienvenido, <%= usuario.getNombreUsuario() %> 🛍️</h3>
                <p class="text-muted">Panel de control del cliente</p>

                <div class="d-grid gap-3 mt-4">
                    <a href="<%= ctx %>/carrito/articulos" class="btn btn-primary">Ver Artículos</a>
                    <a href="<%= ctx %>/carrito/ver" class="btn btn-info">Ver Carrito</a>
                    <a href="<%= ctx %>/compras/historial" class="btn btn-secondary">Historial de Compras</a>
                    <a href="<%= ctx %>/saldo/gestionar" class="btn btn-success">Gestionar Saldo</a>
                    <a href="<%= ctx %>/logout" class="btn btn-outline-danger">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
    

