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
import it.lootzone.model.ProdottoBean;
import it.lootzone.model.ProdottoModelDM;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoModelDM prodottoModel = new ProdottoModelDM();
        try {
            Collection<ProdottoBean> prodotti = prodottoModel.doRetrieveAll(false);
            request.setAttribute("prodottiEvidenza", prodotti);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
