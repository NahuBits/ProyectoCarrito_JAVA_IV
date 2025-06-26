<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, models.Compra, models.DetalleCompra, models.Usuario, enums.TipoUsuario" %>
<%
List<Compra> compras = (List<Compra>) request.getAttribute("compras");
Usuario usuario = (Usuario) session.getAttribute("usuario");
String filtroAplicado = (String) request.getAttribute("filtroAplicado");
String ctx = request.getContextPath();
%>

<h2>Historial de Compras</h2>

<% if (usuario != null && usuario.getTipo() == TipoUsuario.EMPLEADO) { %>
    <form method="get" action="<%= ctx %>/compras/historial">
        <label>Buscar por nombre de usuario:</label>
        <input type="text" name="usuario" value="<%= filtroAplicado != null ? filtroAplicado : "" %>" />
        <button type="submit">Buscar</button>
        <% if (filtroAplicado != null) { %>
            <a href="<%= ctx %>/compras/historial">(Limpiar filtro)</a>
        <% } %>
    </form>
<% } %>

<% if (compras != null && !compras.isEmpty()) { %>
    <% for (Compra c : compras) { %>
        <div style="border:1px solid black; padding:10px; margin:10px;">
            <strong>Factura #<%= c.getId() %></strong> - Fecha: <%= c.getFecha() %><br>
            Cliente: <%= c.getCliente().getNombreUsuario() %><br>
            <ul>
                <% for (DetalleCompra d : c.getDetalles()) { %>
                    <li><%= d.getCantidad() %> x <%= d.getArticulo().getDescripcion() %> = $<%= d.getSubtotal() %></li>
                <% } %>
            </ul>
            <strong>Total: $<%= c.getTotal() %></strong>

            <form method="get" action="<%= ctx %>/compras/detalle" style="margin-top:10px;">
                <input type="hidden" name="id" value="<%= c.getId() %>" />
                <button type="submit">Ver Detalle</button>
            </form>
        </div>
    <% } %>
<% } else { %>
    <p>No hay compras registradas.</p>
<% } %>
<%
	String rol = (String) session.getAttribute("rol");
	String destino = "CLIENTE".equals(rol) ? "/menu" : "/menu";
	%>

	<div style="margin-top: 20px;">
		<form action="<%=request.getContextPath() + destino%>" method="get">
			<button type="submit">⬅ Volver al Menú</button>
		</form>
	</div>