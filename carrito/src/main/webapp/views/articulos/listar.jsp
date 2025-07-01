<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, models.Articulo"%>
<%
    List<Articulo> articulos = (List<Articulo>) request.getAttribute("articulos");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de Artículos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= ctx %>/css/estilos.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h1 class="mb-4">Lista de Artículos</h1>

        <div class="mb-3">
            <a href="<%=ctx%>/articulos/nuevo" class="btn btn-success">➕ Nuevo Artículo</a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover bg-white shadow-sm">
                <thead class="table-light">
                    <tr>
                        <th>Código</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Articulo art : articulos) { %>
                        <tr>
                            <td><%=art.getCodigo()%></td>
                            <td><%=art.getDescripcion()%></td>
                            <td>$<%=art.getPrecio()%></td>
                            <td><%=art.getStock()%></td>
                            <td>
                                <a href="<%=ctx%>/articulos/editar?codigo=<%=art.getCodigo()%>" class="btn btn-primary btn-sm">Editar</a>
                                <a href="<%=ctx%>/articulos/eliminar?codigo=<%=art.getCodigo()%>" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('¿Estás seguro de eliminar este artículo?')">Eliminar</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <%
            String rol = (String) session.getAttribute("rol");
            String destino = "CLIENTE".equals(rol) ? "/menu" : "/menu";
        %>

        <div class="mt-4">
            <form action="<%=request.getContextPath() + destino%>" method="get">
                <button type="submit" class="btn btn-secondary">⬅ Volver al Menú</button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
