package it.lootzone.control;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import it.lootzone.model.PasswordUtil;
import it.lootzone.model.UserBean;
import it.lootzone.model.UserModelDM;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/login.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Tutti i campi sono obbligatori.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);
            return;
        }
        UserModelDM userModel = new UserModelDM();
        try {
            UserBean user = userModel.doRetrieveByEmail(email);
            if (user != null) {
                String hashedInputPassword = PasswordUtil.hashPassword(password);
                if (hashedInputPassword.equals(user.getPassword())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("utente", user);
                    session.setAttribute("ruolo", user.getRuolo());
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
                }
            }
            request.setAttribute("error", "Email o password non validi.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore di connessione al database.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
