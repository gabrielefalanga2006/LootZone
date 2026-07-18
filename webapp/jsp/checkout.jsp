<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .checkout-container {
            max-width: 600px;
            margin: var(--spacing-lg) auto;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
        }
        .summary-box {
            background-color: var(--bg-color);
            padding: var(--spacing-md);
            border-radius: var(--border-radius-sm);
            margin-bottom: var(--spacing-md);
        }
        .summary-box h3 {
            margin-bottom: var(--spacing-sm);
            color: var(--accent-green);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <jsp:include page="/fragments/navbar.jsp" />
    <main>
        <div class="checkout-container">
            <h2>Riepilogo Ordine</h2>
            <c:if test="${not empty error}">
                <div style="color: var(--error-color); margin-bottom: 1rem;">
                    <c:out value="${error}" />
                </div>
            </c:if>
            <div class="summary-box">
                <h3>Dati Spedizione</h3>
                <p><strong>Nome:</strong> <c:out value="${sessionScope.utente.nome} ${sessionScope.utente.cognome}"/></p>
                <p><strong>Indirizzo:</strong> <c:out value="${not empty sessionScope.utente.indirizzo ? sessionScope.utente.indirizzo : 'Non specificato'}"/></p>
            </div>
            <div class="summary-box">
                <h3>Prodotti</h3>
                <ul>
                    <c:forEach var="item" items="${sessionScope.carrello.items}">
                        <li><c:out value="${item.quantita}x ${item.prodotto.nome} - € ${item.prezzoTotale}"/></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="summary-box">
                <h3>Totale da Pagare: € <c:out value="${sessionScope.carrello.totale}"/></h3>
            </div>
            <form action="${pageContext.request.contextPath}/checkout" method="POST">
                <button type="submit" class="btn-accent" style="width: 100%; font-size: 1.2rem;">Conferma Ordine e Paga</button>
            </form>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
