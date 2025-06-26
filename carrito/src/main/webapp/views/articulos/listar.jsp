<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, models.Articulo"%>
<%
List<Articulo> articulos = (List<Articulo>) request.getAttribute("articulos");
String ctx = request.getContextPath();
%>

<html>
<head>
<title>Listado de Artículos</title>
</head>
<body>
	<h1>Lista de Artículos</h1>
	<a href="<%=ctx%>/articulos/nuevo">Nuevo Artículo</a>
	<table border="1">
		<tr>
			<th>Código</th>
			<th>Descripción</th>
			<th>Precio</th>
			<th>Stock</th>
			<th>Acciones</th>
		</tr>
		<%
		for (Articulo art : articulos) {
		%>
		<tr>
			<td><%=art.getCodigo()%></td>
			<td><%=art.getDescripcion()%></td>
			<td><%=art.getPrecio()%></td>
			<td><%=art.getStock()%></td>
			<td><a
				href="<%=ctx%>/articulos/editar?codigo=<%=art.getCodigo()%>">Editar</a>
				| <a href="<%=ctx%>/articulos/eliminar?codigo=<%=art.getCodigo()%>"
				onclick="return confirm('¿Estás seguro?')">Eliminar</a></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	String rol = (String) session.getAttribute("rol");
	String destino = "CLIENTE".equals(rol) ? "/menu" : "/menu";
	%>

	<div style="margin-top: 20px;">
		<form action="<%=request.getContextPath() + destino%>" method="get">
			<button type="submit">⬅ Volver al Menú</button>
		</form>
	</div>
</body>
</html>