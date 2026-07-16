<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrello - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .cart-container {
            max-width: 1000px;
            margin: var(--spacing-lg) auto;
            padding: var(--spacing-lg) 5%;
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-lg);
            align-items: flex-start;
        }
        .cart-items {
            flex: 2 1 400px;
            background-color: var(--surface-color);
            padding: var(--spacing-md);
            border-radius: var(--border-radius-md);
            border: 1px solid var(--border-color);
        }
        .cart-summary {
            flex: 1 1 300px;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
            border: 1px solid var(--accent-pink);
            position: sticky;
            top: 100px;
        }
        .cart-item-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-sm) 0;
            border-bottom: 1px solid var(--border-color);
        }
        .cart-item-row:last-child {
            border-bottom: none;
        }
        .cart-total {
            text-align: center;
            font-size: 1.5rem;
            color: var(--accent-green);
            margin: var(--spacing-lg) 0;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <jsp:include page="/fragments/navbar.jsp" />
    <main>
        <div class="cart-container">
            <c:choose>
                <c:when test="${not empty sessionScope.carrello and not empty sessionScope.carrello.items}">
                    <div class="cart-items">
                        <h2 style="margin-bottom: var(--spacing-md);">Il tuo Carrello</h2>
                        <c:forEach var="item" items="${sessionScope.carrello.items}">
                            <div class="cart-item-row">
                                <div style="flex: 2;">
                                    <h4><c:out value="${item.prodotto.nome}"/></h4>
                                    <span style="color:var(--text-secondary); font-size:0.9rem;">Prezzo: € <c:out value="${item.prodotto.prezzo}"/></span>
                                </div>
                                <div style="flex: 1; text-align:center;">
                                    Quantità: <c:out value="${item.quantita}"/>
                                </div>
                                <div style="flex: 1; text-align:right; font-weight:bold;">
                                    € <c:out value="${item.prezzoTotale}"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="cart-summary">
                        <h3 style="text-align:center; color:var(--text-primary);">Calcolo del prezzo</h3>
                        <div class="cart-total">
                            Totale: € <c:out value="${sessionScope.carrello.totale}"/>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn-primary" style="display:block; width:100%; margin-bottom:10px;">Compra ora</a>
                        <a href="${pageContext.request.contextPath}/catalogo" class="btn-accent" style="display:block; width:100%; background:var(--bg-color); color:var(--text-primary); border:1px solid var(--border-color);">Continua gli acquisti</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="width:100%; text-align:center; padding: 50px;">
                        <h2>Il tuo carrello è vuoto.</h2>
                        <a href="${pageContext.request.contextPath}/catalogo" class="btn-primary" style="margin-top: 20px;">Torna al catalogo</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
