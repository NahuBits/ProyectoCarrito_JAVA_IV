<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Usuario" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || usuario.getTipo() == null) {
        response.sendRedirect("../../login");
        return;
    }


    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Saldo</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= ctx %>/css/estilos.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">💰 Gestión de Saldo</h2>

                <p><strong>Usuario:</strong> <%= usuario.getNombreUsuario() %></p>
                <p><strong>Saldo actual:</strong> $<%= String.format("%.2f", usuario.getSaldo()) %></p>

                <% if (mensaje != null) { %>
                    <div class="alert alert-success" role="alert"><%= mensaje %></div>
                <% } %>

                <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert"><%= error %></div>
                <% } %>

                <hr>

                <h4 class="mb-3">Agregar Saldo</h4>
                <form method="post" action="<%= ctx %>/saldo/agregar" class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label for="montoCargar" class="form-label">Monto a cargar:</label>
                        <input type="number" id="montoCargar" name="monto" step="0.01" min="0.01" class="form-control" required>
                    </div>
                    <div class="col-md-6 align-self-end">
                        <button type="submit" class="btn btn-primary w-100">Cargar</button>
                    </div>
                </form>

                <hr>

                <h4 class="mb-3">Transferir Saldo</h4>
                <form method="post" action="<%= ctx %>/saldo/transferir" class="row g-3">
                    <div class="col-md-6">
                        <label for="destino" class="form-label">Usuario destino:</label>
                        <input type="text" id="destino" name="destino" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label for="montoTransferir" class="form-label">Monto a transferir:</label>
                        <input type="number" id="montoTransferir" name="monto" step="0.01" min="0.01" class="form-control" required>
                    </div>
                    <div class="col-md-2 align-self-end">
                        <button type="submit" class="btn btn-success w-100">Transferir</button>
                    </div>
                </form>

                <div class="mt-4">
                    <form action="<%= ctx %>/menu" method="get">
                        <button type="submit" class="btn btn-outline-secondary">⬅ Volver al Menú</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

