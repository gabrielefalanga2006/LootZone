<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Catalogo - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            padding: var(--spacing-lg) 5%;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
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
        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: var(--border-radius-sm);
            margin-bottom: var(--spacing-sm);
        }
        .card-actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 10px;
        }
        .add-product-card {
            background-color: var(--surface-color);
            border: 2px dashed var(--border-color);
            border-radius: var(--border-radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 5rem;
            color: var(--text-secondary);
            cursor: pointer;
            text-decoration: none;
            min-height: 350px;
        }
        .add-product-card:hover {
            color: var(--accent-pink);
            border-color: var(--accent-pink);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main class="admin-container">
        <h2 style="margin-bottom: var(--spacing-md); border-left: 4px solid var(--accent-pink); padding-left: 10px;">Gestione Catalogo</h2>
        <div class="product-grid">
            <a href="${pageContext.request.contextPath}/admin/prodotto" class="add-product-card">
                +
            </a>
            <c:forEach var="prodotto" items="${prodotti}">
                <div class="product-card">
                    <img src="${not empty prodotto.immagineUrl ? pageContext.request.contextPath += '/images/' += prodotto.immagineUrl : 'https://via.placeholder.com/250x300/1A1A1D/FFFFFF?text=No+Cover'}" alt="Immagine di <c:out value="${prodotto.nome}"/>">
                    <h4><c:out value="${prodotto.nome}"/></h4>
                    <p style="color:var(--accent-green); font-weight:bold;">€ <c:out value="${prodotto.prezzo}"/></p>
                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/admin/prodotto?id=${prodotto.idProdotto}" class="btn-primary" style="flex:1; background-color:var(--border-color); color:white;">Gestisci</a>
                        <form action="${pageContext.request.contextPath}/admin/prodotto" method="POST" style="flex:1;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${prodotto.idProdotto}">
                            <button type="submit" class="btn-danger" style="width:100%;">Elimina</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
