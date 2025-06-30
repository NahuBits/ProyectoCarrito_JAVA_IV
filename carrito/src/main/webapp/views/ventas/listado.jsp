<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, models.Compra, models.DetalleCompra, models.Usuario, enums.TipoUsuario" %>
<%
List<Compra> compras = (List<Compra>) request.getAttribute("compras");
Usuario usuario = (Usuario) session.getAttribute("usuario");
String filtroAplicado = (String) request.getAttribute("filtroAplicado");
String ctx = request.getContextPath();
%>
<%
String rol = (String) session.getAttribute("rol");
String destino = "CLIENTE".equals(rol) ? "/menu" : "/menu";
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">


<div class="container my-5">

<!-- Botón Volver -->
<div class="mb-3">
    <form action="<%= request.getContextPath() + destino %>" method="get" class="d-inline">
        <button type="submit" class="btn btn-secondary">⬅ Volver al Menú</button>
    </form>
</div>
<h2 class="mb-4 text-primary">🧾 Historial de Compras</h2>

<% if (usuario != null && usuario.getTipo() == TipoUsuario.EMPLEADO) { %>
    <form method="get" action="<%= ctx %>/compras/historial" class="row g-2 align-items-center mb-4">
        <div class="col-auto">
            <label class="form-label mb-0">Buscar por nombre de usuario:</label>
        </div>
        <div class="col-auto">
            <input type="text" class="form-control" name="usuario" value="<%= filtroAplicado != null ? filtroAplicado : "" %>" />
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Buscar</button>
            <% if (filtroAplicado != null) { %>
                <a href="<%= ctx %>/compras/historial" class="btn btn-secondary">Limpiar filtro</a>
            <% } %>
        </div>
    </form>
<% } %>

<% if (compras != null && !compras.isEmpty()) { %>
    <% for (Compra c : compras) { %>
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <h5 class="card-title"> Factura #<%= c.getId() %></h5>
                <h6 class="card-subtitle text-muted mb-2"> Fecha: <%= c.getFecha() %></h6>
                <p class="mb-1"> Cliente: <strong><%= c.getCliente().getNombreUsuario() %></strong></p>
                <ul class="list-group mb-3">
                    <% for (DetalleCompra d : c.getDetalles()) { %>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><%= d.getCantidad() %> x <%= d.getArticulo().getDescripcion() %></span>
                            <span class="badge bg-secondary">$<%= d.getSubtotal() %></span>
                        </li>
                    <% } %>
                </ul>
                <p class="fw-bold"> Total: $<%= c.getTotal() %></p>

                <form method="get" action="<%= ctx %>/compras/detalle">
                    <input type="hidden" name="id" value="<%= c.getId() %>" />
                    <button type="submit" class="btn btn-outline-primary">📄 Ver Detalle</button>
                </form>
            </div>
        </div>
    <% } %>
<% } else { %>
    <div class="alert alert-warning">No hay compras registradas.</div>
<% } %>

</div>