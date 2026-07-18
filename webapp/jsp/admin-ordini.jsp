<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Ordini - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 1000px;
            margin: var(--spacing-lg) auto;
            padding: 0 5%;
        }
        .ordine-row {
            display: flex;
            background-color: var(--surface-color);
            border: 1px solid var(--border-color);
            margin-bottom: var(--spacing-sm);
            align-items: center;
            border-radius: var(--border-radius-sm);
            overflow: hidden; 
        }
        .ordine-info {
            flex: 1;
            padding: var(--spacing-md);
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }
        .ordine-wave {
            flex: 1;
            height: 20px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 100 20" xmlns="http://www.w3.org/2000/svg"><path d="M0 10 Q 25 20, 50 10 T 100 10" stroke="%23AAAAAA" fill="transparent" stroke-width="2"/></svg>') repeat-x;
            opacity: 0.5;
        }
        .ordine-actions {
            display: flex;
            height: 100%;
        }
        .btn-action {
            border: none;
            padding: 15px 25px;
            font-weight: bold;
            cursor: pointer;
            color: #000;
            font-family: var(--font-main);
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-completa {
            background-color: var(--accent-green);
        }
        .btn-completa:hover {
            background-color: #00e565;
        }
        .btn-elimina {
            background-color: var(--error-color);
            color: white;
        }
        .btn-elimina:hover {
            background-color: #e03a31;
        }
        .ordine-row form {
            margin: 0;
            height: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main>
        <div class="admin-container">
            <h2 style="margin-bottom: var(--spacing-md); border-left: 4px solid var(--accent-pink); padding-left: 10px;">Gestione Ordini</h2>
            <c:choose>
                <c:when test="${not empty ordini}">
                    <c:forEach var="ordine" items="${ordini}">
                        <div class="ordine-row">
                            <div class="ordine-info" style="flex-direction: column; align-items: flex-start; justify-content: center;">
                                <div style="display: flex; gap: var(--spacing-md); align-items: center; width: 100%;">
                                    <span style="font-family: var(--font-heading); color: var(--text-primary);">#<c:out value="${ordine.idOrdine}"/></span>
                                    <span style="color:var(--text-secondary);"><c:out value="${ordine.stato}"/></span>
                                    <span style="font-weight:bold; color:var(--accent-blue);">€ <c:out value="${ordine.totale}"/></span>
                                    <span style="color:var(--text-secondary); font-size: 0.9rem; margin-left: auto;">
                                        Data: <c:out value="${ordine.dataAcquisto}"/> | Cliente: <strong><c:out value="${ordine.nomeCliente}"/></strong> (ID: <c:out value="${ordine.idCliente}"/>)
                                    </span>
                                </div>
                                <div style="margin-top: 10px; font-size: 0.85rem; color: #ccc; border-top: 1px solid var(--border-color); padding-top: 10px; width: 100%;">
                                    <strong style="color: var(--text-primary);">Prodotti Acquistati:</strong>
                                    <ul style="list-style: none; padding-left: 0; margin-top: 5px; margin-bottom: 0;">
                                        <c:forEach var="riga" items="${ordine.righe}">
                                            <li>- <c:out value="${riga.quantita}"/>x <c:out value="${riga.nomeProdotto}"/></li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <div class="ordine-actions">
                                <form action="${pageContext.request.contextPath}/admin/ordini" method="POST">
                                    <input type="hidden" name="action" value="completa">
                                    <input type="hidden" name="id" value="${ordine.idOrdine}">
                                    <button type="submit" class="btn-action btn-completa" ${ordine.stato == 'Completato' ? 'disabled style="opacity:0.5;cursor:not-allowed;"' : ''}>Completa</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/ordini" method="POST">
                                    <input type="hidden" name="action" value="elimina">
                                    <input type="hidden" name="id" value="${ordine.idOrdine}">
                                    <button type="submit" class="btn-action btn-elimina" ${ordine.stato == 'Annullato' ? 'disabled style="opacity:0.5;cursor:not-allowed;"' : ''}>Elimina</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>Nessun ordine trovato nel sistema.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
