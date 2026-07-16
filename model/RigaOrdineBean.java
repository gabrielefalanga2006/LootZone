package it.lootzone.model;
import java.io.Serializable;
public class RigaOrdineBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private int idOrdine;
    private int idProdotto;
    private int quantita;
    public RigaOrdineBean() {
    }
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }
    public double getPrezzoAcquisto() { return 0.0; }
    private String nomeProdotto;
    public String getNomeProdotto() { return nomeProdotto; }
    public void setNomeProdotto(String nomeProdotto) { this.nomeProdotto = nomeProdotto; }
}
