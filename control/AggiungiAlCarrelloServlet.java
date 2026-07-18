package it.lootzone.control;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import it.lootzone.model.Cart;
import it.lootzone.model.ProdottoBean;
import it.lootzone.model.ProdottoModelDM;
@WebServlet("/aggiungiCarrello")
public class AggiungiAlCarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String qtaStr = request.getParameter("quantita");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int id = Integer.parseInt(idStr);
        int quantita = (qtaStr != null && !qtaStr.trim().isEmpty()) ? Integer.parseInt(qtaStr) : 1;
        HttpSession session = request.getSession();
        Cart carrello = (Cart) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Cart();
        }
        ProdottoModelDM prodottoModel = new ProdottoModelDM();
        try {
            ProdottoBean prodotto = prodottoModel.doRetrieveByKey(id);
            if (prodotto != null && !prodotto.isEliminato()) {
                carrello.addItem(prodotto, quantita);
                session.setAttribute("carrello", carrello);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/carrello");
    }
}
