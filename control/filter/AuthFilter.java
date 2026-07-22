package it.lootzone.control.filter;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebFilter("/admin/*")
public class AuthFilter implements Filter {
    public void init(FilterConfig fConfig) throws ServletException {
    }
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("utente") != null);
        boolean isAdmin = (loggedIn && "admin".equals(session.getAttribute("ruolo")));
        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
    public void destroy() {
    }
}
