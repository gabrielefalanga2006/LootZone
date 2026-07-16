package it.lootzone.control;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import it.lootzone.model.Cart;
import it.lootzone.model.CartItemBean;
import it.lootzone.model.OrdineBean;
import it.lootzone.model.OrdineModelDM;
import it.lootzone.model.RigaOrdineBean;
import it.lootzone.model.UserBean;
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Cart carrello = (Cart) session.getAttribute("carrello");
        if (carrello == null || carrello.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/checkout.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Cart carrello = (Cart) session.getAttribute("carrello");
        if (carrello == null || carrello.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        UserBean utente = (UserBean) session.getAttribute("utente");
        OrdineBean ordine = new OrdineBean();
        ordine.setIdCliente(utente.getIdUtente());
        ordine.setTotale(carrello.getTotale()); 
        ordine.setStatoSpedizione("In Elaborazione");
        List<RigaOrdineBean> righe = new ArrayList<>();
        for (CartItemBean item : carrello.getItems()) {
            RigaOrdineBean riga = new RigaOrdineBean();
            riga.setIdProdotto(item.getProdotto().getIdProdotto());
            riga.setQuantita(item.getQuantita());
            righe.add(riga);
        }
        ordine.setRighe(righe);
        OrdineModelDM ordineModel = new OrdineModelDM();
        try {
            ordineModel.doSave(ordine);
            carrello.svuota();
            session.setAttribute("carrello", carrello);
            request.setAttribute("successMessage", "Ordine completato con successo!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/confermaOrdine.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore durante il completamento dell'ordine.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/checkout.jsp");
            dispatcher.forward(request, response);
        }
    }
}
