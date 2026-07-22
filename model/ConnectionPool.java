package it.lootzone.model;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
public class ConnectionPool {
    private static DataSource dataSource;
    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            dataSource = (DataSource) envCtx.lookup("jdbc/lootzone");
        } catch (NamingException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore di inizializzazione ConnectionPool: DataSource non trovato.");
        }
    }
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
