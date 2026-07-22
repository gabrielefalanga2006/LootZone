package it.lootzone.model;
import java.io.Serializable;
import java.math.BigDecimal;
public class CartItemBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private ProdottoBean prodotto;
    private int quantita;
    public CartItemBean() {
    }
    public CartItemBean(ProdottoBean prodotto, int quantita) {
        this.prodotto = prodotto;
        this.quantita = quantita;
    }
    public ProdottoBean getProdotto() {
        return prodotto;
    }
    public void setProdotto(ProdottoBean prodotto) {
        this.prodotto = prodotto;
    }
    public int getQuantita() {
        return quantita;
    }
    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
    public BigDecimal getPrezzoTotale() {
        if (prodotto != null && prodotto.getPrezzo() != null) {
            return prodotto.getPrezzo().multiply(BigDecimal.valueOf(quantita));
        }
        return BigDecimal.ZERO;
    }
}
