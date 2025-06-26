<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, models.Articulo" %>
<%
    List<Articulo> articulos = (List<Articulo>) request.getAttribute("articulos");
    String ctx = request.getContextPath();
%>
<h2>Artículos disponibles</h2>
<table border="1">
    <tr>
        <th>Descripción</th><th>Precio</th><th>Stock</th><th>Acción</th>
    </tr>
    <% for (Articulo art : articulos) { %>
    <tr>
        <td><%= art.getDescripcion() %></td>
        <td>$<%= art.getPrecio() %></td>
        <td><%= art.getStock() %></td>
        <td>
            <form action="<%= ctx %>/carrito/agregar" method="post">
                <input type="hidden" name="codigo" value="<%= art.getCodigo() %>">
                <input type="number" name="cantidad" min="1" max="<%= art.getStock() %>" value="1" required>
                <input type="submit" value="Agregar">
            </form>
        </td>
    </tr>
    <% } %>
</table>

<a href="<%= ctx %>/carrito/ver">Ver Carrito</a>
<%
	String rol = (String) session.getAttribute("rol");
	String destino = "CLIENTE".equals(rol) ? "/menu" : "/menu";
	%>

	<div style="margin-top: 20px;">
		<form action="<%=request.getContextPath() + destino%>" method="get">
			<button type="submit">⬅ Volver al Menú</button>
		</form>
	</div>