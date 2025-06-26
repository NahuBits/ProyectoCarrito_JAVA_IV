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
@WebServlet("/menu")
public class MenuController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario.getTipo() == TipoUsuario.CLIENTE) {
            req.getRequestDispatcher("views/menu/cliente.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("views/menu/empleado.jsp").forward(req, resp);
        }
    }
}
