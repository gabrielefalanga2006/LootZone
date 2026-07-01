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
@WebServlet("/admin/ordini")
public class GestioneOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        UserBean utente = (UserBean) session.getAttribute("utente");
        if (!"admin".equals(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        OrdineModelDM ordineModel = new OrdineModelDM();
        try {
            Collection<OrdineBean> ordini = ordineModel.doRetrieveAll();
            request.setAttribute("ordini", ordini);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento degli ordini");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin-ordini.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        UserBean utente = (UserBean) session.getAttribute("utente");
        if (!"admin".equals(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                OrdineModelDM ordineModel = new OrdineModelDM();
                OrdineBean ordine = ordineModel.doRetrieveByKey(id);
                if (ordine != null) {
                    if ("completa".equals(action)) {
                        ordine.setStato("Completato");
                        ordineModel.doUpdate(ordine);
                    } else if ("elimina".equals(action)) {
                        ordine.setStato("Annullato");
                        ordineModel.doUpdate(ordine);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/ordini");
    }
}
