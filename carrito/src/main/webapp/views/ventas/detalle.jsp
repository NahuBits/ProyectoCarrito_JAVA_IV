<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="models.Compra, models.DetalleCompra, java.time.format.DateTimeFormatter"%>
<%
Compra compra = (Compra) request.getAttribute("compra");
if (compra == null) {
	response.sendRedirect(request.getContextPath() + "/compras"); // Redirige si no hay compra
	return;
}
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Factura - Compra #<%=compra.getId()%></title>
<style>
body {
	font-family: Arial;
	margin: 40px;
}

h1, h2 {
	color: #333;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

th, td {
	border: 1px solid #aaa;
	padding: 10px;
	text-align: left;
}

.total {
	text-align: right;
	font-weight: bold;
}

.acciones {
	margin-top: 30px;
}
@media print {
  .no-print {
    display: none;
  }
}
</style>
</head>
<body>

	<h1>Factura de Compra </h1>
	<p>
		<strong>Número de factura:</strong>
		<%=compra.getId()%></p>
	<p>
		<strong>Cliente:</strong>
		<%=compra.getCliente().getNombreUsuario()%></p>
	<p>
		<strong>Fecha:</strong>
		<%=compra.getFecha().format(formatter)%></p>

	<h2>Detalle</h2>
	<table>
		<tr>
			<th>Artículo</th>
			<th>Cantidad</th>
			<th>Precio Unitario</th>
			<th>Subtotal</th>
		</tr>
		<%
		for (DetalleCompra d : compra.getDetalles()) {
		%>
		<tr>
			<td><%=d.getArticulo().getDescripcion()%></td>
			<td><%=d.getCantidad()%></td>
			<td>$<%=d.getArticulo().getPrecio()%></td>
			<td>$<%=d.getSubtotal()%></td>
		</tr>
		<%
		}
		%>
		<tr>
			<td colspan="3" class="total">Total:</td>
			<td>$<%=compra.getTotal()%></td>
		</tr>
	</table>

	<div class="acciones no-print">
		<button onclick="window.print()">🖨 Imprimir / Guardar PDF</button>
	</div>
	<div class="acciones no-print">
		<a href="<%=request.getContextPath()%>/compras">⬅ Volver al
			Historial</a>
	</div>
</body>
</html>

