package it.lootzone.model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
public class ProdottoModelDM {
    private static final String TABLE_NAME = "PRODOTTO";
    public synchronized void doSave(ProdottoBean prodotto) throws SQLException {
        String insertSQL = "INSERT INTO " + TABLE_NAME + " (Titolo, Piattaforma, Genere, Prezzo_Base, Tipo_Formato, Descrizione, Immagine) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getPiattaforma());
            ps.setString(3, prodotto.getGenere());
            ps.setBigDecimal(4, prodotto.getPrezzo());
            ps.setString(5, prodotto.getTipoFormato() != null ? prodotto.getTipoFormato() : "Fisico");
            ps.setString(6, prodotto.getDescrizione());
            ps.setString(7, prodotto.getImmagineUrl());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()) {
                prodotto.setIdProdotto(rs.getInt(1));
            }
        }
    }
    public synchronized void doUpdate(ProdottoBean prodotto) throws SQLException {
        String updateSQL = "UPDATE " + TABLE_NAME + " SET Titolo = ?, Piattaforma = ?, Genere = ?, Prezzo_Base = ?, Tipo_Formato = ?, Descrizione = ?, Immagine = ? WHERE ID_Prodotto = ?";
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(updateSQL)) {
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getPiattaforma());
            ps.setString(3, prodotto.getGenere());
            ps.setBigDecimal(4, prodotto.getPrezzo());
            ps.setString(5, prodotto.getTipoFormato());
            ps.setString(6, prodotto.getDescrizione());
            ps.setString(7, prodotto.getImmagineUrl());
            ps.setInt(8, prodotto.getIdProdotto());
            ps.executeUpdate();
        }
    }
    public synchronized ProdottoBean doRetrieveByKey(int id) throws SQLException {
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE ID_Prodotto = ?";
        ProdottoBean bean = null;
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectSQL)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bean = mapRowToBean(rs);
            }
        }
        return bean;
    }
    public synchronized Collection<ProdottoBean> doRetrieveAll(boolean order) throws SQLException {
        String selectSQL = "SELECT * FROM " + TABLE_NAME + (order ? " ORDER BY Titolo" : "");
        Collection<ProdottoBean> prodotti = new ArrayList<>();
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectSQL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                prodotti.add(mapRowToBean(rs));
            }
        }
        return prodotti;
    }
    private ProdottoBean mapRowToBean(ResultSet rs) throws SQLException {
        ProdottoBean bean = new ProdottoBean();
        bean.setIdProdotto(rs.getInt("ID_Prodotto"));
        bean.setNome(rs.getString("Titolo"));
        bean.setPiattaforma(rs.getString("Piattaforma"));
        bean.setGenere(rs.getString("Genere"));
        bean.setPrezzo(rs.getBigDecimal("Prezzo_Base"));
        bean.setTipoFormato(rs.getString("Tipo_Formato"));
        bean.setDescrizione(rs.getString("Descrizione"));
        bean.setImmagineUrl(rs.getString("Immagine"));
        return bean;
    }
    public synchronized boolean doDelete(int id) throws SQLException {
        String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE ID_Prodotto = ?";
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(deleteSQL)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
