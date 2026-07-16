package it.lootzone.control;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import it.lootzone.model.ProdottoBean;
import it.lootzone.model.ProdottoModelDM;
@WebServlet("/dettaglio")
public class DettaglioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            ProdottoModelDM prodottoModel = new ProdottoModelDM();
            ProdottoBean prodotto = prodottoModel.doRetrieveByKey(id);
            if (prodotto != null && !prodotto.isEliminato()) {
                request.setAttribute("prodotto", prodotto);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/dettaglio.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/catalogo");
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/catalogo");
        }
    }
}
