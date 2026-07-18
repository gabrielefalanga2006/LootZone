package it.lootzone.control;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import it.lootzone.model.PasswordUtil;
import it.lootzone.model.UserBean;
import it.lootzone.model.UserModelDM;
@WebServlet("/registrazione")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/registrazione.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = request.getParameter("nome"); 
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String indirizzo = request.getParameter("indirizzo");
        if (nickname == null || nickname.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Tutti i campi obbligatori devono essere compilati.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/registrazione.jsp");
            dispatcher.forward(request, response);
            return;
        }
        UserModelDM userModel = new UserModelDM();
        try {
            if (userModel.doRetrieveByEmail(email) != null) {
                request.setAttribute("error", "Email già in uso.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/registrazione.jsp");
                dispatcher.forward(request, response);
                return;
            }
            UserBean newUser = new UserBean();
            newUser.setEmail(email);
            newUser.setPassword(PasswordUtil.hashPassword(password));
            newUser.setRuolo("cliente");
            newUser.setNickname(nickname);
            newUser.setIndirizzoSpedizione(indirizzo);
            userModel.doSave(newUser);
            response.sendRedirect(request.getContextPath() + "/login?success=registrazione");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore durante la registrazione.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }
}
