<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.Articulo"%>
<%
Articulo art = (Articulo) request.getAttribute("articulo");
boolean esEditar = (art != null);
String ctx = request.getContextPath();
%>

<html>
<head>
<title><%=esEditar ? "Editar Artículo" : "Nuevo Artículo"%></title>
</head>
<body>
	<h1><%=esEditar ? "Editar Artículo" : "Nuevo Artículo"%></h1>
	<form action="<%=ctx%>/articulos<%=esEditar ? "/editar" : "/nuevo"%>"
		method="post">
		<%
		if (esEditar) {
		%>
		<input type="hidden" name="codigo" value="<%=art.getCodigo()%>">
		<%
		}
		%>
		Descripción: <input type="text" name="descripcion"
			value="<%=esEditar ? art.getDescripcion() : ""%>"><br>
		Precio: <input type="text" name="precio"
			value="<%=esEditar ? art.getPrecio() : ""%>"><br> Stock:
		<input type="text" name="stock"
			value="<%=esEditar ? art.getStock() : ""%>"><br> <input
			type="submit" value="<%=esEditar ? "Actualizar" : "Guardar"%>">
	</form>

	<div style="margin-top: 20px;">
		<form action="<%=request.getContextPath()%>/articulos" method="get">
			<button type="submit">⬅ Volver al Listado</button>
		</form>
	</div>

</body>
</html>