package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Articulo;
import services.ArticuloService;

@WebServlet("/articulos/*")
public class ArticuloController extends HttpServlet {
    private ArticuloService articuloService = ArticuloService.getInstance();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String path = request.getPathInfo(); // obtiene lo que viene después de /articulos
    	
    	if (path == null || "/".equals(path) || path.equals("/listar")) {
    	    // Listar artículos
    	    request.setAttribute("articulos", articuloService.obtenerTodos());
    	    request.getRequestDispatcher("/views/articulos/listar.jsp").forward(request, response);
    	} else if (path.equals("/nuevo")) {
    	    // Formulario vacío para agregar
    	    request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	} else if (path.equals("/editar")) {
    	    try {
    	        long codigo = Long.parseLong(request.getParameter("codigo"));
    	        Articulo art = articuloService.buscarPorCodigo(codigo);
    	        if (art == null) {
    	            response.sendRedirect("listar");
    	            return;
    	        }
    	        request.setAttribute("articulo", art);
    	        request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	    } catch (NumberFormatException e) {
    	        response.sendRedirect("listar");
    	    }
    	} else if (path.equals("/eliminar")) {
    	    try {
    	        long codigo = Long.parseLong(request.getParameter("codigo"));
    	        articuloService.eliminar(codigo);
    	    } catch (NumberFormatException e) {
    	        // manejar error si querés
    	    }
    	    response.sendRedirect(request.getContextPath() + "/articulos");
    	} else {
    	    response.sendError(HttpServletResponse.SC_NOT_FOUND);
    	}
    }
    
    private boolean camposValidos(HttpServletRequest request) {
    	String path = request.getPathInfo();
    	return request.getParameter("descripcion") != null &&
    	request.getParameter("precio") != null &&
    	request.getParameter("stock") != null &&
    	(!"/editar".equals(path) || request.getParameter("codigo") != null);
    	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String path = request.getPathInfo();
    	
    	if (path == null) {
    	    response.sendRedirect("listar");
    	    return;
    	}

    	if (!camposValidos(request)) {
    	    request.setAttribute("error", "Campos inválidos");
    	    request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	    return;
    	}

    	try {
    	    Articulo articulo = construirArticuloDesdeRequest(request);
    	    if (path.equals("/editar")) {
    	        articuloService.actualizar(articulo);
    	    } else if (path.equals("/nuevo")) {
    	        articuloService.agregar(articulo);
    	    }
    	} catch (NumberFormatException e) {
    	    request.setAttribute("error", "Datos numéricos inválidos");
    	    request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	    return;
    	}

    	response.sendRedirect(request.getContextPath() + "/articulos");
    }

    private Articulo construirArticuloDesdeRequest(HttpServletRequest request) throws NumberFormatException {
    	String codigoStr = request.getParameter("codigo");
    	long codigo = 0;
    	
    	if (codigoStr != null && !codigoStr.isEmpty()) {
    		codigo = Long.parseLong(codigoStr);
    	}
    	
    	String descripcion = request.getParameter("descripcion");
    	double precio = Double.parseDouble(request.getParameter("precio"));
    	int stock = Integer.parseInt(request.getParameter("stock"));
    	return new Articulo(codigo, descripcion, precio, stock);
    }
}
