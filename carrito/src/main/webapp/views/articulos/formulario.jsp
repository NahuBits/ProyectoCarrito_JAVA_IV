<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.Articulo"%>
<%
Articulo art = (Articulo) request.getAttribute("articulo");
boolean esEditar = (art != null);
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title><%=esEditar ? "Editar Artículo" : "Nuevo Artículo"%></title>
<link href="<%= ctx %>/css/estilos.css" rel="stylesheet">

</head>
<body class="bg-light">
    <div class="container mt-5">
        <h1 class="mb-4"><%=esEditar ? "Editar Artículo" : "Nuevo Artículo"%></h1>

        <form action="<%=ctx%>/articulos<%=esEditar ? "/editar" : "/nuevo"%>" method="post" class="card p-4 shadow-sm">

            <% if (esEditar) { %>
                <input type="hidden" name="codigo" value="<%=art.getCodigo()%>">
            <% } %>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <input type="text" class="form-control" id="descripcion" name="descripcion"
                       value="<%=esEditar ? art.getDescripcion() : ""%>" required>
            </div>

            <div class="mb-3">
                <label for="precio" class="form-label">Precio</label>
                <input type="text" class="form-control" id="precio" name="precio"
                       value="<%=esEditar ? art.getPrecio() : ""%>" required>
            </div>

            <div class="mb-3">
                <label for="stock" class="form-label">Stock</label>
                <input type="text" class="form-control" id="stock" name="stock"
                       value="<%=esEditar ? art.getStock() : ""%>" required>
            </div>

            <button type="submit" class="btn btn-primary">
                <%=esEditar ? "Actualizar" : "Guardar"%>
            </button>
        </form>

        <div class="mt-3">
            <form action="<%=request.getContextPath()%>/articulos" method="get">
                <button type="submit" class="btn btn-secondary">⬅ Volver al Listado</button>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
