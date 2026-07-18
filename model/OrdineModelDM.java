package it.lootzone.model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
public class OrdineModelDM {
    public synchronized void doSave(OrdineBean ordine) throws SQLException {
        String insertOrdine = "INSERT INTO ORDINE (Data_Acquisto, Totale, Stato_Spedizione, ID_Cliente, ID_Amministratore) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = ConnectionPool.getConnection()) {
            connection.setAutoCommit(false);
            try (PreparedStatement ps = connection.prepareStatement(insertOrdine, Statement.RETURN_GENERATED_KEYS)) {
                if (ordine.getDataAcquisto() != null) {
                    ps.setTimestamp(1, ordine.getDataAcquisto());
                } else {
                    ps.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
                }
                ps.setBigDecimal(2, ordine.getTotale());
                ps.setString(3, ordine.getStatoSpedizione() != null ? ordine.getStatoSpedizione() : "In Elaborazione");
                ps.setInt(4, ordine.getIdCliente());
                if (ordine.getIdAmministratore() != null) {
                    ps.setInt(5, ordine.getIdAmministratore());
                } else {
                    ps.setNull(5, java.sql.Types.INTEGER);
                }
                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                int idOrdine = -1;
                if (rs.next()) {
                    idOrdine = rs.getInt(1);
                    ordine.setIdOrdine(idOrdine);
                }
                if (ordine.getRighe() != null) {
                    String insertRiga = "INSERT INTO DETTAGLIO_ORDINE (ID_Ordine, ID_Prodotto, Quantita) VALUES (?, ?, ?)";
                    try (PreparedStatement psRiga = connection.prepareStatement(insertRiga)) {
                        for (RigaOrdineBean riga : ordine.getRighe()) {
                            psRiga.setInt(1, idOrdine);
                            psRiga.setInt(2, riga.getIdProdotto());
                            psRiga.setInt(3, riga.getQuantita());
                            psRiga.addBatch();
                        }
                        psRiga.executeBatch();
                    }
                }
                connection.commit();
            } catch (SQLException e) {
                connection.rollback();
                throw e;
            } finally {
                connection.setAutoCommit(true);
            }
        }
    }
    public synchronized void doUpdate(OrdineBean ordine) throws SQLException {
        String updateSQL = "UPDATE ORDINE SET Totale = ?, Stato_Spedizione = ?, ID_Amministratore = ? WHERE ID_Ordine = ?";
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(updateSQL)) {
            ps.setBigDecimal(1, ordine.getTotale());
            ps.setString(2, ordine.getStatoSpedizione());
            if (ordine.getIdAmministratore() != null) {
                ps.setInt(3, ordine.getIdAmministratore());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setInt(4, ordine.getIdOrdine());
            ps.executeUpdate();
        }
    }
    public synchronized OrdineBean doRetrieveByKey(int id) throws SQLException {
        String selectSQL = "SELECT * FROM ORDINE WHERE ID_Ordine = ?";
        OrdineBean bean = null;
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectSQL)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bean = mapRowToBean(rs);
                bean.setRighe(doRetrieveRighe(bean.getIdOrdine(), connection));
            }
        }
        return bean;
    }
    public synchronized Collection<OrdineBean> doRetrieveByUtente(int idUtente) throws SQLException {
        String selectSQL = "SELECT * FROM ORDINE WHERE ID_Cliente = ? ORDER BY Data_Acquisto DESC";
        Collection<OrdineBean> ordini = new ArrayList<>();
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectSQL)) {
            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrdineBean bean = mapRowToBean(rs);
                bean.setRighe(doRetrieveRighe(bean.getIdOrdine(), connection));
                ordini.add(bean);
            }
        }
        return ordini;
    }
    public synchronized Collection<OrdineBean> doRetrieveAll() throws SQLException {
        String selectSQL = "SELECT O.*, C.Nickname FROM ORDINE O JOIN CLIENTE C ON O.ID_Cliente = C.ID_Utente ORDER BY O.Data_Acquisto DESC";
        Collection<OrdineBean> ordini = new ArrayList<>();
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectSQL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrdineBean bean = mapRowToBean(rs);
                bean.setNomeCliente(rs.getString("Nickname"));
                bean.setRighe(doRetrieveRighe(bean.getIdOrdine(), connection));
                ordini.add(bean);
            }
        }
        return ordini;
    }
    private ArrayList<RigaOrdineBean> doRetrieveRighe(int idOrdine, Connection connection) throws SQLException {
        String selectSQL = "SELECT D.*, P.Titolo FROM DETTAGLIO_ORDINE D JOIN PRODOTTO P ON D.ID_Prodotto = P.ID_Prodotto WHERE D.ID_Ordine = ?";
        ArrayList<RigaOrdineBean> righe = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(selectSQL)) {
            ps.setInt(1, idOrdine);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RigaOrdineBean riga = new RigaOrdineBean();
                riga.setIdOrdine(rs.getInt("ID_Ordine"));
                riga.setIdProdotto(rs.getInt("ID_Prodotto"));
                riga.setQuantita(rs.getInt("Quantita"));
                riga.setNomeProdotto(rs.getString("Titolo"));
                righe.add(riga);
            }
        }
        return righe;
    }
    private OrdineBean mapRowToBean(ResultSet rs) throws SQLException {
        OrdineBean bean = new OrdineBean();
        bean.setIdOrdine(rs.getInt("ID_Ordine"));
        bean.setDataAcquisto(rs.getTimestamp("Data_Acquisto"));
        bean.setTotale(rs.getBigDecimal("Totale"));
        bean.setStatoSpedizione(rs.getString("Stato_Spedizione"));
        bean.setIdCliente(rs.getInt("ID_Cliente"));
        int idAdmin = rs.getInt("ID_Amministratore");
        if (!rs.wasNull()) {
            bean.setIdAmministratore(idAdmin);
        }
        return bean;
    }
}
