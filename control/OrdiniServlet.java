package it.lootzone.control;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import it.lootzone.model.OrdineBean;
import it.lootzone.model.OrdineModelDM;
import it.lootzone.model.UserBean;
@WebServlet("/ordini")
public class OrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        UserBean utente = (UserBean) session.getAttribute("utente");
        OrdineModelDM ordineModel = new OrdineModelDM();
        try {
            Collection<OrdineBean> ordini = ordineModel.doRetrieveByUtente(utente.getIdUtente());
            request.setAttribute("ordini", ordini);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento degli ordini");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/ordini.jsp");
        dispatcher.forward(request, response);
    }
}
