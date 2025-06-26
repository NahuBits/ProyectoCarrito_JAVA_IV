<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    String ctx = request.getContextPath();
%>

<h2>Gestión de Saldo</h2>

<p><strong>Usuario:</strong> <%= usuario.getNombreUsuario() %></p>
<p><strong>Saldo actual:</strong> $<%= String.format("%.2f", usuario.getSaldo()) %></p>

<% if (mensaje != null) { %>
    <div style="color: green; margin: 10px 0; font-weight: bold;"><%= mensaje %></div>
<% } %>

<% if (error != null) { %>
    <div style="color: red; margin: 10px 0; font-weight: bold;"><%= error %></div>
<% } %>

<hr>

<h3>Agregar Saldo</h3>
<form method="post" action="<%= ctx %>/saldo/agregar">
    <label>Monto a cargar:</label>
    <input type="number" name="monto" step="0.01" min="0.01" required>
    <button type="submit">Cargar</button>
</form>

<hr>

<h3>Transferir Saldo</h3>
<form method="post" action="<%= ctx %>/saldo/transferir">
    <label>Usuario destino:</label>
    <input type="text" name="destino" required><br>
    <label>Monto a transferir:</label>
    <input type="number" name="monto" step="0.01" min="0.01" required>
    <button type="submit">Transferir</button>
</form>

<hr>

<form action="<%= ctx %>/menu" method="get">
    <button type="submit">⬅ Volver al Menú</button>
</form>
