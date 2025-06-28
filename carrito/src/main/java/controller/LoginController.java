package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import enums.TipoUsuario;
import models.Usuario;
import services.ProveedorServicios;
import services.UsuarioService;


@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UsuarioService usuarioService;

    public LoginController() {
    	 this.usuarioService = ProveedorServicios.getInstance().getUsuarioService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nombre = request.getParameter("usuario");
        String password = request.getParameter("password");
        
        

        Usuario user = usuarioService.validar(nombre, password);

        if (user != null) {
        	HttpSession sesion = request.getSession();
        	sesion.setAttribute("usuario", user);
        	
        	sesion.setAttribute("rol", user.getTipo().name());

                response.sendRedirect("menu");
           
        } else {
            request.setAttribute("error", "Usuario o contraseña invalidos");
            request.getRequestDispatcher("views/usuarios/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/usuarios/login.jsp").forward(req, resp);
    }
}
