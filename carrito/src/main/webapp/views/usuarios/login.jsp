<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Iniciar sesión</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
</head>
<body>
	<div class="login-container">
		<h3 class="text-center mb-4">Iniciar sesión</h3>
		<form action="login" method="post">
			<div class="mb-3">
				<label for="usuario" class="form-label">Usuario</label> <input
					type="text" name="usuario" id="usuario" class="form-control"
					required>
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">Contraseña</label> <input
					type="password" name="password" id="password" class="form-control"
					required>
			</div>

			<button type="submit" class="btn btn-primary w-100">Ingresar</button>
		</form>
		<%
		if (request.getAttribute("error") != null) {
		%>
		<div class="alert alert-danger mt-3 text-center">
			<%=request.getAttribute("error")%>
		</div>
		<%
		}
		%>

	</div>
	<!-- Bootstrap JS (opcional, para alertas u otros componentes interactivos) -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>