package it.lootzone.model;
import java.io.Serializable;
import java.math.BigDecimal;
public class ProdottoBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private int idProdotto;
    private String nome; 
    private String piattaforma;
    private String genere;
    private BigDecimal prezzo; 
    private String tipoFormato;
    private String descrizione;
    private String immagineUrl; 
    private boolean eliminato;
    public ProdottoBean() {
    }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getPiattaforma() { return piattaforma; }
    public void setPiattaforma(String piattaforma) { this.piattaforma = piattaforma; }
    public String getGenere() { return genere; }
    public void setGenere(String genere) { this.genere = genere; }
    public BigDecimal getPrezzo() { return prezzo; }
    public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }
    public String getTipoFormato() { return tipoFormato; }
    public void setTipoFormato(String tipoFormato) { this.tipoFormato = tipoFormato; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public String getImmagineUrl() { return immagineUrl; }
    public void setImmagineUrl(String immagineUrl) { this.immagineUrl = immagineUrl; }
    public boolean isEliminato() { return eliminato; }
    public void setEliminato(boolean eliminato) { this.eliminato = eliminato; }
}
