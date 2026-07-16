<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LootZone - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .hero-banner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--surface-color);
            padding: var(--spacing-lg) 5%;
            margin-bottom: var(--spacing-lg);
            border-bottom: 2px solid var(--border-color);
        }
        .hero-text h2 {
            font-size: 2.5rem;
            margin-bottom: var(--spacing-sm);
        }
        .hero-text p {
            color: var(--text-secondary);
            margin-bottom: var(--spacing-md);
            max-width: 400px;
        }
        .hero-image img {
            max-width: 300px;
            width: 100%;
            height: auto;
        }
        .home-section {
            padding: 0 5%;
            margin-bottom: var(--spacing-lg);
        }
        .section-title {
            border-left: 4px solid var(--accent-green);
            padding-left: 10px;
            margin-bottom: var(--spacing-md);
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .evidenza-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: var(--spacing-md);
        }
        .evidenza-card {
            background-color: #1a1a1d; 
            border-radius: var(--border-radius-md);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            border: 1px solid var(--border-color);
            position: relative;
        }
        .evidenza-card:hover {
            border-color: var(--accent-pink);
        }
        .evidenza-top {
            height: 200px;
            background: linear-gradient(180deg, rgba(30,30,30,1) 0%, rgba(20,20,20,1) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }
        .evidenza-top h3 {
            font-family: var(--font-heading);
            font-size: 1.8rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 0 0 10px rgba(255,255,255,0.2);
        }
        .evidenza-bottom {
            padding: var(--spacing-md);
            background-color: var(--surface-color);
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .badge {
            font-size: 0.75rem;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        .badge-orange { color: var(--accent-orange); }
        .badge-pink { color: var(--accent-pink); }
        .badge-blue { color: var(--accent-blue); }
        .evidenza-title {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .evidenza-subtitle {
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-bottom: var(--spacing-md);
        }
        .evidenza-footer {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }
        .evidenza-price {
            color: var(--accent-green);
            font-size: 1.4rem;
            font-weight: bold;
        }
        .evidenza-link {
            color: var(--text-secondary);
            font-size: 0.85rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .evidenza-link:hover {
            color: white;
        }
        .add-to-cart-overlay {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0,0,0,0.7);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            cursor: pointer;
            border: 1px solid var(--border-color);
        }
        .add-to-cart-overlay form {
            margin: 0;
        }
        .add-to-cart-overlay button {
            background: none;
            border: none;
            color: var(--accent-green);
            font-size: 1.5rem;
            cursor: pointer;
        }
        .evidenza-card:hover .add-to-cart-overlay {
            opacity: 1;
        }
        .add-to-cart-overlay:hover {
            border-color: var(--accent-green);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <jsp:include page="/fragments/navbar.jsp" />
    <main>
        <section class="hero-banner">
            <div class="hero-text">
                <h2>Benvenuto su Loot Zone</h2>
                <p>Compra Hardware, giochi fisici e digitali, al prezzo più vantaggioso. Tutto in un unico hub!</p>
                <a href="${pageContext.request.contextPath}/catalogo" class="btn-accent">Vai al catalogo</a>
            </div>
            <div class="hero-image">
                <img src="${pageContext.request.contextPath}/images/icon1.png" alt="Loot Chest Mascotte">
            </div>
        </section>
        <section class="home-section">
            <h3 class="section-title">🔥 Giochi in Evidenza</h3>
            <c:if test="${not empty error}">
                <div style="color: var(--error-color); margin-bottom: 1rem;">
                    <c:out value="${error}" />
                </div>
            </c:if>
            <c:if test="${not empty prodottiEvidenza}">
                <div class="evidenza-grid">
                    <c:forEach var="prodotto" items="${prodottiEvidenza}">
                        <div class="evidenza-card">
                            <div class="add-to-cart-overlay" title="Aggiungi al carrello">
                                <form action="${pageContext.request.contextPath}/aggiungiCarrello" method="POST">
                                    <input type="hidden" name="id" value="${prodotto.idProdotto}">
                                    <input type="hidden" name="quantita" value="1">
                                    <button type="submit">+</button>
                                </form>
                            </div>
                            <div class="evidenza-top" style="display: flex; justify-content: center; align-items: center; height: 100%; overflow: hidden;">
                                <img src="${not empty prodotto.immagineUrl ? pageContext.request.contextPath += '/images/' += prodotto.immagineUrl : 'https://via.placeholder.com/250x300/1A1A1D/FFFFFF?text=No+Cover'}" 
                                     alt="Immagine di <c:out value="${prodotto.nome}"/>"
                                     style="max-width: 100%; max-height: 100%; object-fit: contain;">
                            </div>
                            <div class="evidenza-bottom">
                                <c:choose>
                                    <c:when test="${prodotto.descrizione.contains('Grande Classico')}">
                                        <div class="badge badge-orange">Grande Classico</div>
                                    </c:when>
                                    <c:when test="${prodotto.descrizione.contains('Popolare')}">
                                        <div class="badge badge-pink">Popolare</div>
                                    </c:when>
                                    <c:when test="${prodotto.descrizione.contains('Free to Play')}">
                                        <div class="badge badge-blue">Free to Play</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="badge badge-orange">Novità</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="evidenza-title"><c:out value="${prodotto.nome}"/></div>
                                <div class="evidenza-subtitle">
                                    <c:out value="${prodotto.piattaforma}"/> &bull; 
                                    <c:choose>
                                        <c:when test="${prodotto.descrizione.contains('Disponibile')}">Disponibile subito</c:when>
                                        <c:when test="${prodotto.descrizione.contains('Pre-Owned')}">Pre-Owned</c:when>
                                        <c:when test="${prodotto.descrizione.contains('Digitale')}">Codice Digitale</c:when>
                                        <c:otherwise><c:out value="${prodotto.tipoFormato}"/></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="evidenza-footer">
                                    <div class="evidenza-price">€ <c:out value="${prodotto.prezzo}"/></div>
                                    <a href="${pageContext.request.contextPath}/dettaglio?id=${prodotto.idProdotto}" class="evidenza-link">Vedi dettagli &rarr;</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </section>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
