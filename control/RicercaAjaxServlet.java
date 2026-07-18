package it.lootzone.control;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import it.lootzone.model.ConnectionPool;
@WebServlet("/ricercaAjax")
public class RicercaAjaxServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("q");
        if (query == null || query.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("[");
        String sql = "SELECT ID_Prodotto, Titolo FROM PRODOTTO WHERE Titolo LIKE ? LIMIT 5";
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query.trim() + "%");
            ResultSet rs = ps.executeQuery();
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    jsonResponse.append(",");
                }
                int id = rs.getInt("ID_Prodotto");
                String nome = rs.getString("Titolo").replace("\"", "\\\"");
                jsonResponse.append("{\"id\": ").append(id).append(", \"nome\": \"").append(nome).append("\"}");
                first = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
        jsonResponse.append("]");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
