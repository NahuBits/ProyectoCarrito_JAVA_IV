package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        HttpSession session = request.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("usuario") != null;

        boolean isLoginPage = uri.endsWith("login") || uri.contains("LoginController");
        boolean isLogoutPage = uri.endsWith("logout") || uri.contains("LogoutController");
        boolean isMenuServlet = uri.endsWith("menu") || uri.contains("MenuController");
        boolean isResource = uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/");

        if (loggedIn || isLoginPage || isLogoutPage || isMenuServlet || isResource) {
            
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}