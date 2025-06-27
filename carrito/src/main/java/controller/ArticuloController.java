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
//    	para el ABM de articulo, dependiendo de la ruta (/listar, /nuevo, /editar, /eliminar)
    	String req = request.getPathInfo(); 
    	
//    	vista para verlos articulos
    	if (req == null || "/".equals(req) || req.equals("/listar")) {
    	    
    	    request.setAttribute("articulos", articuloService.obtenerTodos());
    	    request.getRequestDispatcher("/views/articulos/listar.jsp").forward(request, response);
//    	   vista para el alta de articulos
    	} else if (req.equals("/nuevo")) {

    	    request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	    
//    	   vista para editar los articulos
    	} else if (req.equals("/editar")) {
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
//    	   vista para eliminar articulos
    	} else if (req.equals("/eliminar")) {
    	    try {
    	        long codigo = Long.parseLong(request.getParameter("codigo"));
    	        articuloService.eliminar(codigo);
    	    } catch (NumberFormatException e) {
    	    	
    	    }
    	    response.sendRedirect(request.getContextPath() + "/articulos");
    	} else {
    	    response.sendError(HttpServletResponse.SC_NOT_FOUND);
    	}
    }
    
    private boolean camposValidos(HttpServletRequest request) {
    	String req = request.getPathInfo();
    	return request.getParameter("descripcion") != null &&
    	request.getParameter("precio") != null &&
    	request.getParameter("stock") != null &&
    	(!"/editar".equals(req) || request.getParameter("codigo") != null);
    	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String req = request.getPathInfo();
    	
//    	si req es null redirije a listar
    	if (req == null) {
    	    response.sendRedirect("listar");
    	    return;
    	}

    	if (!camposValidos(request)) {
    	    request.setAttribute("error", "Campos invalidos");
    	    request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	    return;
    	}
//despues de las validaciones creamos el articulo
    	try {
    	    Articulo articulo = construirArticuloDesdeRequest(request);
    	    if (req.equals("/editar")) {
    	        articuloService.actualizar(articulo);
    	    } else if (req.equals("/nuevo")) {
    	        articuloService.agregar(articulo);
    	    }
    	} catch (NumberFormatException e) {
    	    request.setAttribute("error", "Datos numericos invalidos");
    	    request.getRequestDispatcher("/views/articulos/formulario.jsp").forward(request, response);
    	    return;
    	}

    	response.sendRedirect(request.getContextPath() + "/articulos");
    }

    private Articulo construirArticuloDesdeRequest(HttpServletRequest request) throws NumberFormatException {
//    	metodo que crea el objeto articulo
    	String cod = request.getParameter("codigo");
    	long codigo = 0;
    	
    	if (cod != null && !cod.isEmpty()) {
    		codigo = Long.parseLong(cod);
    	}
    	
    	String descripcion = request.getParameter("descripcion");
    	double precio = Double.parseDouble(request.getParameter("precio"));
    	int stock = Integer.parseInt(request.getParameter("stock"));
    	return new Articulo(codigo, descripcion, precio, stock);
    }
}
