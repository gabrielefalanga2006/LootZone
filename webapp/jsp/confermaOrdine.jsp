<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordine Completato - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .success-container {
            max-width: 600px;
            margin: var(--spacing-lg) auto;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
            text-align: center;
        }
        .success-container h2 {
            color: var(--accent-green);
            margin-bottom: var(--spacing-md);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <jsp:include page="/fragments/navbar.jsp" />
    <main>
        <div class="success-container">
            <h2>🎉 Ordine Completato!</h2>
            <c:if test="${not empty successMessage}">
                <p style="margin-bottom: var(--spacing-md);"><c:out value="${successMessage}"/></p>
            </c:if>
            <p>Grazie per aver acquistato su LootZone. Il tuo ordine è stato registrato nel nostro database e il tuo carrello è stato svuotato.</p>
            <div style="margin-top: var(--spacing-lg);">
                <a href="${pageContext.request.contextPath}/home" class="btn-primary">Torna alla Home</a>
            </div>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
