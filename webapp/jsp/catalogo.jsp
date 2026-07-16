<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .catalogo-container {
            padding: var(--spacing-lg) 5%;
        }
        .search-area {
            display: flex;
            justify-content: center;
            margin-bottom: var(--spacing-lg);
        }
        .search-area input[type="text"] {
            width: 50%;
            padding: var(--spacing-sm) var(--spacing-md);
            font-size: 1.1rem;
            border: 1px solid var(--border-color);
            background-color: var(--surface-color);
            color: var(--text-primary);
            border-radius: var(--border-radius-sm) 0 0 var(--border-radius-sm);
            outline: none;
        }
        .search-area button {
            padding: var(--spacing-sm) var(--spacing-md);
            font-size: 1.1rem;
            border: none;
            background-color: var(--accent-blue);
            color: #111;
            font-weight: bold;
            cursor: pointer;
            border-radius: 0 var(--border-radius-sm) var(--border-radius-sm) 0;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: var(--spacing-md);
        }
        .product-card {
            background-color: var(--surface-color);
            padding: var(--spacing-md);
            border-radius: var(--border-radius-md);
            text-align: center;
            border: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product-card:hover {
            border-color: var(--accent-pink);
        }
        .product-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: var(--border-radius-sm);
            margin-bottom: var(--spacing-sm);
        }
        .product-price {
            color: var(--accent-green);
            font-size: 1.2rem;
            font-weight: bold;
            margin: var(--spacing-sm) 0;
        }
        .card-actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .card-actions .btn-primary, .card-actions form {
            flex: 1;
        }
        .card-actions button {
            width: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main class="catalogo-container">
        <h2 style="margin-bottom: var(--spacing-md); border-left: 4px solid var(--accent-pink); padding-left: 10px;">Esplora il Catalogo</h2>
        <c:if test="${empty prodotti}">
            <p>Nessun prodotto disponibile al momento.</p>
        </c:if>
        <c:if test="${not empty prodotti}">
            <div class="product-grid">
                <c:forEach var="prodotto" items="${prodotti}">
                    <div class="product-card">
                        <img src="${not empty prodotto.immagineUrl ? pageContext.request.contextPath += '/images/' += prodotto.immagineUrl : 'https://via.placeholder.com/250x300/1A1A1D/FFFFFF?text=No+Cover'}" alt="Immagine di <c:out value="${prodotto.nome}"/>">
                        <h4><c:out value="${prodotto.nome}"/></h4>
                        <p style="font-size:0.8rem; color:var(--text-secondary);"><c:out value="${prodotto.piattaforma}"/> - <c:out value="${prodotto.genere}"/></p>
                        <p class="product-price">€ <c:out value="${prodotto.prezzo}"/></p>
                        <div class="card-actions">
                            <a href="${pageContext.request.contextPath}/dettaglio?id=${prodotto.idProdotto}" class="btn-primary" style="background-color: var(--border-color);">Dettagli</a>
                            <form action="${pageContext.request.contextPath}/aggiungiCarrello" method="POST">
                                <input type="hidden" name="id" value="${prodotto.idProdotto}">
                                <input type="hidden" name="quantita" value="1">
                                <button type="submit" class="btn-primary">Al Carrello</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
