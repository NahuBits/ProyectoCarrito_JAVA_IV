<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, models.DetalleCompra"%>
<%@ page import="models.Usuario"%>
<%
List<DetalleCompra> carrito = (List<DetalleCompra>) request.getAttribute("carrito");
Double total = (Double) request.getAttribute("total");
Usuario usuario = (Usuario) session.getAttribute("usuario");
String ctx = request.getContextPath();
String error = (String) request.getAttribute("error");
String mensaje = (String) request.getAttribute("mensaje");
%>

<h2>Carrito de Compra</h2>
<p><strong>Saldo actual:</strong> $<%= String.format("%.2f", usuario.getSaldo()) %></p>

<%
if (error != null) {
%>
<div style="color: red;"><%=error%></div>
<%
}
%>
<%
if (mensaje != null) {
%>
<div style="color: green;"><%=mensaje%></div>
<%
}
%>

<table border="1">
	<tr>
		<th>Artículo</th>
		<th>Cantidad</th>
		<th>Subtotal</th>
		<th>Acciones</th>
	</tr>
	<%
	for (DetalleCompra d : carrito) {
	%>
	<tr>
		<td><%=d.getArticulo().getDescripcion()%></td>
		<td><%=d.getCantidad()%></td>
		<td>$<%=d.getSubtotal()%></td>
		<td>
			<form method="post" action="<%=ctx%>/carrito/eliminar"
				style="display: inline;">
				<input type="hidden" name="codigo"
					value="<%=d.getArticulo().getCodigo()%>" />
				<button type="submit">Eliminar</button>
			</form>
		</td>
	</tr>
	<%
	}
	%>
</table>
<h3>
	Total: $<%=total%></h3>

<form action="<%=ctx%>/carrito/finalizar" method="post">
	<input type="submit" value="Finalizar Compra">
</form>

<a href="<%=ctx%>/carrito/articulos">⬅ Seguir Comprando</a>
