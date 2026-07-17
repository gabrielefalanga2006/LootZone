<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>I Miei Ordini - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .ordini-container {
            max-width: 800px;
            margin: var(--spacing-lg) auto;
            padding: 0 5%;
        }
        .ordine-card {
            display: flex;
            background-color: var(--surface-color);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius-md);
            margin-bottom: var(--spacing-md);
            padding: var(--spacing-md);
            align-items: center;
            gap: var(--spacing-lg);
        }
        .ordine-icon {
            flex: 0 0 100px;
            height: 100px;
            background-color: var(--bg-color);
            border: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: var(--border-radius-sm);
        }
        .ordine-icon img {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .ordine-details {
            flex: 1;
        }
        .ordine-details p {
            margin-bottom: var(--spacing-sm);
            color: var(--text-secondary);
        }
        .ordine-details p strong {
            color: var(--text-primary);
        }
        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: bold;
            background-color: var(--accent-green);
            color: #000;
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main>
        <div class="ordini-container">
            <h2 style="margin-bottom: var(--spacing-md); border-left: 4px solid var(--accent-blue); padding-left: 10px;">I Miei Ordini</h2>
            <c:if test="${not empty error}">
                <p style="color:var(--error-color);"><c:out value="${error}"/></p>
            </c:if>
            <c:choose>
                <c:when test="${not empty ordini}">
                    <c:forEach var="ordine" items="${ordini}">
                        <div class="ordine-card">
                            <div class="ordine-icon">
                                <img src="https://via.placeholder.com/80/1A1A1D/7FDBFF?text=ORD" alt="Ordine">
                            </div>
                            <div class="ordine-details">
                                <p>Ordine N° <strong><c:out value="${ordine.idOrdine}"/></strong></p>
                                <p>Informazioni: <strong>Totale € <c:out value="${ordine.totale}"/></strong></p>
                                <p>Data di Arrivo Stimata: <strong><c:out value="${ordine.dataAcquisto}"/></strong></p>
                                <p>Stato: <span class="status-badge"><c:out value="${ordine.stato}"/></span></p>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>Non hai ancora effettuato ordini.</p>
                    <a href="${pageContext.request.contextPath}/catalogo" class="btn-primary" style="margin-top: 10px;">Vai al catalogo</a>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
