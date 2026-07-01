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
import it.lootzone.model.ProdottoBean;
import it.lootzone.model.ProdottoModelDM;
import it.lootzone.model.UserBean;
@WebServlet("/admin/catalogo")
public class GestioneCatalogoServlet extends HttpServlet {
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
        ProdottoModelDM prodottoModel = new ProdottoModelDM();
        try {
            Collection<ProdottoBean> prodotti = prodottoModel.doRetrieveAll(false);
            request.setAttribute("prodotti", prodotti);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento del catalogo");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin-catalogo.jsp");
        dispatcher.forward(request, response);
    }
}
