<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettaglio Prodotto - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .product-detail-container {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-lg);
            padding: var(--spacing-lg) 5%;
            align-items: flex-start;
        }
        .product-image {
            flex: 1 1 400px;
        }
        .product-image img {
            width: 100%;
            border-radius: var(--border-radius-md);
            border: 2px solid var(--border-color);
        }
        .product-info {
            flex: 1 1 400px;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
            border: 1px solid var(--border-color);
        }
        .product-info h2 {
            font-size: 2rem;
            color: var(--accent-pink);
            margin-bottom: var(--spacing-sm);
        }
        .product-info p.price {
            font-size: 2rem;
            color: var(--accent-green);
            font-weight: bold;
            margin-bottom: var(--spacing-md);
        }
        .product-info p.desc {
            color: var(--text-secondary);
            margin-bottom: var(--spacing-lg);
            line-height: 1.5;
        }
        .product-info hr {
            border: 1px solid var(--border-color);
            margin-bottom: var(--spacing-md);
        }
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-sm);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main>
        <div class="product-detail-container">
            <div class="product-image">
                <img src="${not empty prodotto.immagineUrl ? pageContext.request.contextPath += '/images/' += prodotto.immagineUrl : 'https://via.placeholder.com/600x600/1A1A1D/FFFFFF?text=No+Cover'}" alt="Immagine di <c:out value="${prodotto.nome}"/>">
            </div>
            <div class="product-info">
                <h2><c:out value="${prodotto.nome}"/></h2>
                <p>Piattaforma: <strong><c:out value="${prodotto.piattaforma}"/></strong></p>
                <p>Genere: <strong><c:out value="${prodotto.genere}"/></strong></p>
                <p>Formato: <strong><c:out value="${prodotto.tipoFormato}"/></strong></p>
                <hr>
                <p class="desc">
                    <c:out value="${not empty prodotto.descrizione ? prodotto.descrizione : 'Nessuna descrizione disponibile.'}"/>
                </p>
                <p class="price">€ <c:out value="${prodotto.prezzo}"/></p>
                <div class="action-buttons">
                    <form action="${pageContext.request.contextPath}/aggiungiCarrello" method="POST">
                        <input type="hidden" name="id" value="${prodotto.idProdotto}">
                        <div style="margin-bottom: var(--spacing-sm); display:flex; align-items:center; gap: 10px;">
                            <label for="quantita">Quantità:</label>
                            <input type="number" id="quantita" name="quantita" value="1" min="1" style="width: 60px; padding: 5px; background:var(--bg-color); color:white; border:1px solid #333; border-radius: var(--border-radius-sm);">
                        </div>
                        <button type="submit" class="btn-primary" style="width: 100%; margin-bottom: 10px;">Aggiungi al carrello</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/checkout" method="GET">
                        <button type="button" class="btn-accent" style="width: 100%;" onclick="window.location.href='${pageContext.request.contextPath}/carrello'">Vai al Carrello / Compra Ora</button>
                    </form>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
