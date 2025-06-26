package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import models.Articulo;
import models.Usuario;
import services.ArticuloService;
import services.CarritoService;
import services.ProveedorServicios;

@WebServlet("/carrito/*")
public class CarritoController extends HttpServlet {
    private ArticuloService articuloService = ProveedorServicios.getInstance().getArticuloService();
    private CarritoService carritoService = ProveedorServicios.getInstance().getCarritoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || path.equals("/") || path.equals("/ver")) {
            req.setAttribute("carrito", carritoService.getCarrito());
            req.setAttribute("total", carritoService.getTotal());

            String error = req.getParameter("error");
            String mensaje = req.getParameter("mensaje");
            if (error != null) req.setAttribute("error", error);
            if (mensaje != null) req.setAttribute("mensaje", mensaje);

            req.getRequestDispatcher("/views/carrito/ver.jsp").forward(req, resp);
        } else if (path.equals("/articulos")) {
            req.setAttribute("articulos", articuloService.obtenerTodos());
            req.getRequestDispatcher("/views/carrito/articulos.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        switch (path) {
            case "/agregar":
                agregarArticulo(req, resp);
                break;
            case "/eliminar":
                eliminarArticulo(req, resp);
                break;
            case "/finalizar":
                finalizarCompra(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void agregarArticulo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        long codigo = Long.parseLong(req.getParameter("codigo"));
        int cantidad = Integer.parseInt(req.getParameter("cantidad"));
        Articulo articulo = articuloService.buscarPorCodigo(codigo);

        if (articulo != null && cantidad <= articulo.getStock()) {
            carritoService.agregarArticulo(articulo, cantidad);
        }

        resp.sendRedirect(req.getContextPath() + "/carrito/articulos");
    }

    private void eliminarArticulo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            long codigo = Long.parseLong(req.getParameter("codigo"));
            carritoService.eliminarDelCarrito(codigo);
            resp.sendRedirect(req.getContextPath() + "/carrito/ver?mensaje=Articulo+eliminado");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/carrito/ver?error=No+se+pudo+eliminar");
        }
    }

    private void finalizarCompra(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");

        if (carritoService.getCarrito().isEmpty()) {
            // carrito vacio, no permitir compra
            resp.sendRedirect(req.getContextPath() + "/carrito/ver?error=El+carrito+esta+vacio.+Agregue+articulos+antes+de+comprar");
            return;
        }

        try {
            carritoService.finalizarCompra(usuario);
            req.setAttribute("mensaje", "Compra realizada con Exito!");
        } catch (RuntimeException e) {
            req.setAttribute("error", e.getMessage());
        }

        req.setAttribute("carrito", carritoService.getCarrito());
        req.setAttribute("total", carritoService.getTotal());
        req.getRequestDispatcher("/views/carrito/ver.jsp").forward(req, resp);
    }

}


