package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import services.CarritoService;
import services.ProveedorServicios;


@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false); // no crear nueva si no existe
        if (session != null) {
        	CarritoService carritoService = ProveedorServicios.getInstance().getCarritoService();
        	carritoService.restaurarStockCarrito(); // Restaurar stock antes de cerrar sesi�n
            session.invalidate(); // Cierra la sesión actual
        }

        // Evita que el navegador use caché después del logout
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        response.sendRedirect("login"); // Redirige al login
    }

    // Opción: manejar también el POST si hacés logout desde un formulario
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response); // Reutiliza la lógica
    }
}