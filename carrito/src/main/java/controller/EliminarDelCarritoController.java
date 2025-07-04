package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.CarritoService;
import services.ProveedorServicios;


@WebServlet("/carrito/eliminar")
public class EliminarDelCarritoController extends HttpServlet {
private CarritoService carritoService = ProveedorServicios.getInstance().getCarritoService();
	
       
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    String codigoStr = req.getParameter("codigo");

    try {
        long codigo = Long.parseLong(codigoStr);
        carritoService.eliminarDelCarrito(codigo);
        resp.sendRedirect(req.getContextPath() + "/carrito/ver"); 
    } catch (Exception e) {
        resp.sendRedirect(req.getContextPath() + "/carrito/ver?error=Error+al+eliminar");
    }
}
}
