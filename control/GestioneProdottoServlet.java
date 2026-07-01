package it.lootzone.control;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import it.lootzone.model.ProdottoBean;
import it.lootzone.model.ProdottoModelDM;
import it.lootzone.model.UserBean;
@WebServlet("/admin/prodotto")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class GestioneProdottoServlet extends HttpServlet {
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
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                ProdottoModelDM prodottoModel = new ProdottoModelDM();
                ProdottoBean prodotto = prodottoModel.doRetrieveByKey(id);
                request.setAttribute("prodotto", prodotto);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin-prodotto.jsp");
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
        ProdottoModelDM prodottoModel = new ProdottoModelDM();
        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                prodottoModel.doDelete(id);
            } else {
                String idStr = request.getParameter("id");
                String nome = request.getParameter("nome");
                String piattaforma = request.getParameter("piattaforma");
                String genere = request.getParameter("genere");
                String tipoFormato = request.getParameter("tipo_formato");
                String descrizione = request.getParameter("descrizione");
                String prezzoStr = request.getParameter("prezzo");
                ProdottoBean prodotto = new ProdottoBean();
                prodotto.setNome(nome);
                prodotto.setPiattaforma(piattaforma);
                prodotto.setGenere(genere);
                prodotto.setTipoFormato(tipoFormato);
                prodotto.setDescrizione(descrizione);
                if (prezzoStr != null && !prezzoStr.isEmpty()) {
                    prodotto.setPrezzo(new BigDecimal(prezzoStr));
                }
                Part filePart = request.getPart("immagineProdotto");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    if (fileName != null && !fileName.isEmpty()) {
                        String savePath = request.getServletContext().getRealPath("") + "images";
                        File fileSaveDir = new File(savePath);
                        if (!fileSaveDir.exists()) {
                            fileSaveDir.mkdir();
                        }
                        String fullPath = savePath + File.separator + fileName;
                        filePart.write(fullPath);
                        prodotto.setImmagineUrl(fileName);
                    }
                } else if (idStr != null && !idStr.isEmpty()) {
                    ProdottoBean oldProdotto = prodottoModel.doRetrieveByKey(Integer.parseInt(idStr));
                    if (oldProdotto != null) {
                        prodotto.setImmagineUrl(oldProdotto.getImmagineUrl());
                    }
                }
                if (idStr != null && !idStr.isEmpty()) {
                    prodotto.setIdProdotto(Integer.parseInt(idStr));
                    prodottoModel.doUpdate(prodotto);
                } else {
                    prodottoModel.doSave(prodotto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/catalogo");
    }
}
