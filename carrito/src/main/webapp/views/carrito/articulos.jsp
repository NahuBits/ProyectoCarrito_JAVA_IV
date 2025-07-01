<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, models.Articulo, models.Usuario" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || usuario.getTipo() == null || !usuario.getTipo().name().equals("CLIENTE")) {
        response.sendRedirect("../../login");
        return;
    }

    List<Articulo> articulos = (List<Articulo>) request.getAttribute("articulos");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Artículos disponibles</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= ctx %>/css/estilos.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">🛒 Artículos Disponibles</h2>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (Articulo art : articulos) { %>
                            <tr>
                                <td><%= art.getDescripcion() %></td>
                                <td>$<%= art.getPrecio() %></td>
                                <td><%= art.getStock() %></td>
                                <td>
                                    <form action="<%= ctx %>/carrito/agregar" method="post" class="d-flex align-items-center">
                                        <input type="hidden" name="codigo" value="<%= art.getCodigo() %>">
                                        <input type="number" name="cantidad" min="1" max="<%= art.getStock() %>" value="1" required class="form-control me-2" style="width: 100px;">
                                        <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="<%= ctx %>/carrito/ver" class="btn btn-primary">Ver Carrito 🛒</a>
                    <a href="<%= ctx %>/menu" class="btn btn-outline-secondary">⬅ Volver al Menú</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
