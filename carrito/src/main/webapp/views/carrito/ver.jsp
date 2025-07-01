<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, models.DetalleCompra, models.Usuario" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || usuario.getTipo() == null || !usuario.getTipo().name().equals("CLIENTE")) {
        response.sendRedirect("../../login");
        return;
    }

    List<DetalleCompra> carrito = (List<DetalleCompra>) request.getAttribute("carrito");
    Double total = (Double) request.getAttribute("total");
    String ctx = request.getContextPath();
    String error = (String) request.getAttribute("error");
    String mensaje = (String) request.getAttribute("mensaje");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= ctx %>/css/estilos.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">🛍️ Carrito de Compra</h2>

                <p><strong>Saldo actual:</strong> $<%= String.format("%.2f", usuario.getSaldo()) %></p>

                <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert"><%= error %></div>
                <% } %>

                <% if (mensaje != null) { %>
                    <div class="alert alert-success" role="alert"><%= mensaje %></div>
                <% } %>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Artículo</th>
                                <th>Cantidad</th>
                                <th>Subtotal</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (DetalleCompra d : carrito) { %>
                            <tr>
                                <td><%= d.getArticulo().getDescripcion() %></td>
                                <td><%= d.getCantidad() %></td>
                                <td>$<%= d.getSubtotal() %></td>
                                <td>
                                    <form method="post" action="<%= ctx %>/carrito/eliminar" class="d-inline">
                                        <input type="hidden" name="codigo" value="<%= d.getArticulo().getCodigo() %>" />
                                        <button type="submit" class="btn btn-sm btn-danger">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <h4 class="text-end mt-4">Total: $<%= String.format("%.2f", total) %></h4>

                <div class="d-flex justify-content-between mt-4">
                    <a href="<%= ctx %>/carrito/articulos" class="btn btn-outline-secondary">⬅ Seguir Comprando</a>
                    <form action="<%= ctx %>/carrito/finalizar" method="post">
                        <button type="submit" class="btn btn-success">Finalizar Compra</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

