package it.lootzone.model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
public class UserModelDM {
    public synchronized void doSave(UserBean user) throws SQLException {
        String insertUtente = "INSERT INTO UTENTE (Email, Password) VALUES (?, ?)";
        try (Connection connection = ConnectionPool.getConnection()) {
            connection.setAutoCommit(false); 
            try (PreparedStatement psUtente = connection.prepareStatement(insertUtente, Statement.RETURN_GENERATED_KEYS)) {
                psUtente.setString(1, user.getEmail());
                psUtente.setString(2, user.getPassword());
                psUtente.executeUpdate();
                ResultSet rs = psUtente.getGeneratedKeys();
                int newId = -1;
                if (rs.next()) {
                    newId = rs.getInt(1);
                    user.setIdUtente(newId);
                }
                if ("admin".equals(user.getRuolo())) {
                    String insertAdmin = "INSERT INTO AMMINISTRATORE (ID_Utente, Codice_Admin) VALUES (?, ?)";
                    try (PreparedStatement psAdmin = connection.prepareStatement(insertAdmin)) {
                        psAdmin.setInt(1, newId);
                        psAdmin.setString(2, "ADM-" + newId); 
                        psAdmin.executeUpdate();
                    }
                } else {
                    String insertCliente = "INSERT INTO CLIENTE (ID_Utente, Nickname, Indirizzo_Spedizione) VALUES (?, ?, ?)";
                    try (PreparedStatement psCliente = connection.prepareStatement(insertCliente)) {
                        psCliente.setInt(1, newId);
                        psCliente.setString(2, user.getNickname() != null ? user.getNickname() : "User" + newId);
                        psCliente.setString(3, user.getIndirizzoSpedizione());
                        psCliente.executeUpdate();
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
    public synchronized UserBean doRetrieveByKey(int id) throws SQLException {
        String selectUtente = "SELECT * FROM UTENTE WHERE ID_Utente = ?";
        UserBean bean = null;
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectUtente)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bean = mapRowToBean(rs, connection);
            }
        }
        return bean;
    }
    public synchronized UserBean doRetrieveByEmail(String email) throws SQLException {
        String selectUtente = "SELECT * FROM UTENTE WHERE Email = ?";
        UserBean bean = null;
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectUtente)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bean = mapRowToBean(rs, connection);
            }
        }
        return bean;
    }
    public synchronized Collection<UserBean> doRetrieveAll() throws SQLException {
        String selectSQL = "SELECT * FROM UTENTE";
        Collection<UserBean> users = new ArrayList<>();
        try (Connection connection = ConnectionPool.getConnection();
             PreparedStatement ps = connection.prepareStatement(selectSQL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapRowToBean(rs, connection));
            }
        }
        return users;
    }
    private UserBean mapRowToBean(ResultSet rs, Connection connection) throws SQLException {
        UserBean bean = new UserBean();
        int id = rs.getInt("ID_Utente");
        bean.setIdUtente(id);
        bean.setEmail(rs.getString("Email"));
        bean.setPassword(rs.getString("Password"));
        bean.setDataRegistrazione(rs.getTimestamp("Data_Registrazione"));
        String selectAdmin = "SELECT * FROM AMMINISTRATORE WHERE ID_Utente = ?";
        try (PreparedStatement psAdmin = connection.prepareStatement(selectAdmin)) {
            psAdmin.setInt(1, id);
            ResultSet rsAdmin = psAdmin.executeQuery();
            if (rsAdmin.next()) {
                bean.setRuolo("admin");
                bean.setCodiceAdmin(rsAdmin.getString("Codice_Admin"));
                bean.setRuoloGestione(rsAdmin.getString("Ruolo_Gestione"));
                return bean;
            }
        }
        String selectCliente = "SELECT * FROM CLIENTE WHERE ID_Utente = ?";
        try (PreparedStatement psCliente = connection.prepareStatement(selectCliente)) {
            psCliente.setInt(1, id);
            ResultSet rsCliente = psCliente.executeQuery();
            if (rsCliente.next()) {
                bean.setRuolo("cliente");
                bean.setNickname(rsCliente.getString("Nickname"));
                bean.setPreferenzeGenere(rsCliente.getString("Preferenze_Genere"));
                bean.setIndirizzoSpedizione(rsCliente.getString("Indirizzo_Spedizione"));
            }
        }
        return bean;
    }
}
