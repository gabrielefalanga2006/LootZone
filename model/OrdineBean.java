package it.lootzone.model;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
public class OrdineBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private int idOrdine;
    private Timestamp dataAcquisto; 
    private BigDecimal totale;
    private String statoSpedizione; 
    private int idCliente; 
    private Integer idAmministratore; 
    private List<RigaOrdineBean> righe;
    public OrdineBean() {
    }
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
    public Timestamp getDataAcquisto() { return dataAcquisto; }
    public void setDataAcquisto(Timestamp dataAcquisto) { this.dataAcquisto = dataAcquisto; }
    public BigDecimal getTotale() { return totale; }
    public void setTotale(BigDecimal totale) { this.totale = totale; }
    public String getStatoSpedizione() { return statoSpedizione; }
    public void setStatoSpedizione(String statoSpedizione) { this.statoSpedizione = statoSpedizione; }
    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }
    public Integer getIdAmministratore() { return idAmministratore; }
    public void setIdAmministratore(Integer idAmministratore) { this.idAmministratore = idAmministratore; }
    public List<RigaOrdineBean> getRighe() { return righe; }
    public void setRighe(List<RigaOrdineBean> righe) { this.righe = righe; }
    public int getIdUtente() { return idCliente; }
    public Timestamp getDataOrdine() { return dataAcquisto; }
    public String getStato() { return statoSpedizione; }
    public void setStato(String stato) { this.statoSpedizione = stato; }
    private String nomeCliente;
    public String getNomeCliente() { return nomeCliente; }
    public void setNomeCliente(String nomeCliente) { this.nomeCliente = nomeCliente; }
}
