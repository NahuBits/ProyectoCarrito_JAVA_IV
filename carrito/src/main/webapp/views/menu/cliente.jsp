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
</head>
<body>
	<h1>Bienvenido Cliente <%= usuario.getNombreUsuario() %></h1>
	<ul>
		<li><a href="<%= ctx %>/carrito/articulos">Ver Artículos</a></li>
		<li><a href="<%= ctx %>/carrito/ver">Ver Carrito</a></li>
		<li><a href="<%= ctx %>/compras/historial">Historial de Compras</a></li>
		<li><a href="<%= request.getContextPath() %>/saldo/gestionar">Gestionar Saldo</a></li>
		<li><a href="<%= ctx %>/logout">Cerrar Sesión</a></li>
	</ul>
</body>
</html>

