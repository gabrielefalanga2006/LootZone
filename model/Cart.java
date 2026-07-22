package it.lootzone.model;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;
    private List<CartItemBean> items;
    public Cart() {
        items = new ArrayList<>();
    }
    public void addItem(ProdottoBean prodotto, int quantita) {
        if (prodotto == null) return;
        for (CartItemBean item : items) {
            if (item.getProdotto().getIdProdotto() == prodotto.getIdProdotto()) {
                item.setQuantita(item.getQuantita() + quantita);
                return;
            }
        }
        items.add(new CartItemBean(prodotto, quantita));
    }
    public void removeItem(int idProdotto) {
        items.removeIf(item -> item.getProdotto().getIdProdotto() == idProdotto);
    }
    public void updateQuantita(int idProdotto, int nuovaQuantita) {
        if (nuovaQuantita <= 0) {
            removeItem(idProdotto);
            return;
        }
        for (CartItemBean item : items) {
            if (item.getProdotto().getIdProdotto() == idProdotto) {
                item.setQuantita(nuovaQuantita);
                break;
            }
        }
    }
    public List<CartItemBean> getItems() {
        return items;
    }
    public BigDecimal getTotale() {
        BigDecimal totale = BigDecimal.ZERO;
        for (CartItemBean item : items) {
            totale = totale.add(item.getPrezzoTotale());
        }
        return totale;
    }
    public int getTotaleElementi() {
        int count = 0;
        for (CartItemBean item : items) {
            count += item.getQuantita();
        }
        return count;
    }
    public void svuota() {
        items.clear();
    }
}
