package it.lootzone.model;
import java.io.Serializable;
import java.sql.Timestamp;
public class UserBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private int idUtente;
    private String email;
    private String password;
    private Timestamp dataRegistrazione;
    private String ruolo;
    private String nickname;
    private String indirizzoSpedizione;
    private String codiceAdmin;
    private String ruoloGestione;
    public UserBean() {
    }
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public Timestamp getDataRegistrazione() { return dataRegistrazione; }
    public void setDataRegistrazione(Timestamp dataRegistrazione) { this.dataRegistrazione = dataRegistrazione; }
    public String getRuolo() { return ruolo; }
    public void setRuolo(String ruolo) { this.ruolo = ruolo; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getIndirizzoSpedizione() { return indirizzoSpedizione; }
    public void setIndirizzoSpedizione(String indirizzoSpedizione) { this.indirizzoSpedizione = indirizzoSpedizione; }
    public String getCodiceAdmin() { return codiceAdmin; }
    public void setCodiceAdmin(String codiceAdmin) { this.codiceAdmin = codiceAdmin; }
    public String getRuoloGestione() { return ruoloGestione; }
    public void setRuoloGestione(String ruoloGestione) { this.ruoloGestione = ruoloGestione; }
    public String getNome() { return nickname; } 
    public String getCognome() { return ""; } 
    public String getIndirizzo() { return indirizzoSpedizione; }
    public String getPasswordHash() { return password; }
}
