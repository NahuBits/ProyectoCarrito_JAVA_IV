package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Compra;
import models.Usuario;
import services.CarritoService;
import services.ProveedorServicios;

/**
 * Servlet implementation class CompraController
 */
@WebServlet("/compras/*")
public class CompraController extends HttpServlet {
private CarritoService carritoService = ProveedorServicios.getInstance().getCarritoService();


@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String path = req.getPathInfo();
    Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");

    if (usuario == null) {
        resp.sendRedirect(req.getContextPath() + "/login");
        return;
    }

    if (path == null || path.equals("/") || path.equals("/historial")) {
        if (usuario.getTipo().name().equals("EMPLEADO")) {
            String filtro = req.getParameter("usuario");
            List<Compra> compras;
            if (filtro != null && !filtro.trim().isEmpty()) {
                compras = carritoService.getHistorialFiltradoPorUsuario(filtro.trim());
                req.setAttribute("filtroAplicado", filtro);
            } else {
                compras = carritoService.getHistorialCompleto();
            }
            req.setAttribute("compras", compras);
        } else {
            req.setAttribute("compras", carritoService.getHistorial(usuario));
        }

        req.getRequestDispatcher("/views/ventas/listado.jsp").forward(req, resp);

    } else if (path.equals("/detalle")) {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            try {
                long id = Long.parseLong(idParam);
                Compra compra = carritoService.getCompraPorId(id);

                if (compra == null || (!usuario.getTipo().name().equals("EMPLEADO") &&
                        !compra.getCliente().getNombreUsuario().equals(usuario.getNombreUsuario()))) {
                    resp.sendRedirect(req.getContextPath() + "/compras/historial?error=No+autorizado");
                    return;
                }

                req.setAttribute("compra", compra);
                req.getRequestDispatcher("/views/ventas/detalle.jsp").forward(req, resp);

            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/compras/historial?error=ID+inv%C3%A1lido");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/compras/historial");
        }

    } else {
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}

}