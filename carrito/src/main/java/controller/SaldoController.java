package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Usuario;
import services.ProveedorServicios;
import services.SaldoService;
import services.UsuarioService;

/**
 * Servlet implementation class SaldoController
 */
@WebServlet("/saldo/*")
public class SaldoController extends HttpServlet {
private SaldoService saldoService = ProveedorServicios.getInstance().getSaldoService();

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	String path = req.getPathInfo();
	if (path == null || path.equals("/") || path.equals("")) {
	    resp.sendRedirect(req.getContextPath() + "/saldo/gestionar");
	    return;
	}
	if (path.equals("/gestionar")) {
	    req.getRequestDispatcher("/views/saldo/gestionar.jsp").forward(req, resp);
	} else {
	    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
}

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	String path = req.getPathInfo();
	Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");

	if (usuario == null) {
	     resp.sendRedirect(req.getContextPath() + "/login");
	     return;
	 }

	 switch (path) {
	     case "/agregar":
	         agregarSaldo(req, resp, usuario);
	         break;
	     case "/transferir":
	         transferirSaldo(req, resp, usuario);
	         break;
	     default:
	         resp.sendError(HttpServletResponse.SC_NOT_FOUND);
	 }
}

private void agregarSaldo(HttpServletRequest req, HttpServletResponse resp, Usuario usuario) throws IOException, ServletException {
	try {
		double monto = Double.parseDouble(req.getParameter("monto"));
		if (monto <= 0) {
		req.setAttribute("error", "El monto debe ser mayor a 0.");
		} else {
		saldoService.agregarSaldo(usuario, monto);
		req.setAttribute("mensaje", "Se cargaron $" + monto + " correctamente.");
		}
		} catch (NumberFormatException e) {
		req.setAttribute("error", "Monto inválido.");
		}

		 req.getRequestDispatcher("/views/saldo/gestionar.jsp").forward(req, resp);
}

private void transferirSaldo(HttpServletRequest req, HttpServletResponse resp, Usuario origen) throws IOException, ServletException {
    String destinoNombre = req.getParameter("destino");

     try {
         double monto = Double.parseDouble(req.getParameter("monto"));
         if (monto <= 0) {
             req.setAttribute("error", "El monto debe ser mayor a 0.");
         } else if (origen.getNombreUsuario().equals(destinoNombre)) {
             req.setAttribute("error", "No puede transferirse saldo a sí mismo.");
         } else {
             boolean exito = saldoService.transferir(origen.getNombreUsuario(), destinoNombre, monto);
             if (exito) {
                 req.setAttribute("mensaje", "Transferencia exitosa de $" + monto + " a " + destinoNombre);
             } else {
                 req.setAttribute("error", "Transferencia fallida: usuario destino no existe o saldo insuficiente.");
             }
         }
     } catch (NumberFormatException e) {
         req.setAttribute("error", "Monto inválido.");
     }

     req.getRequestDispatcher("/views/saldo/gestionar.jsp").forward(req, resp);
    }
}
