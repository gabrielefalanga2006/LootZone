<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .form-container {
            max-width: 500px;
            margin: var(--spacing-lg) auto;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
            border: 1px solid #333;
        }
        .form-group {
            margin-bottom: var(--spacing-md);
        }
        .form-group label {
            display: block;
            margin-bottom: var(--spacing-sm);
        }
        .form-group input {
            width: 100%;
            padding: var(--spacing-sm);
            background-color: var(--bg-color);
            color: var(--text-primary);
            border: 1px solid #444;
            border-radius: var(--border-radius-sm);
        }
        #error-box {
            display: none;
            color: var(--error-color);
            margin-bottom: var(--spacing-md);
            border: 1px solid var(--error-color);
            padding: var(--spacing-sm);
            border-radius: var(--border-radius-sm);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main>
        <div class="form-container">
            <h2>Crea il tuo account</h2>
            <div id="error-box"></div>
            <c:if test="${not empty error}">
                <div style="color: var(--error-color); margin-bottom: 1rem;">
                    <c:out value="${error}" />
                </div>
            </c:if>
            <form id="regForm" action="${pageContext.request.contextPath}/registrazione" method="POST">
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome">
                </div>
                <div class="form-group">
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" name="cognome">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="password">Password (minimo 6 caratteri):</label>
                    <input type="password" id="password" name="password">
                </div>
                <button type="submit" class="btn-primary" style="width: 100%;">Registrati</button>
            </form>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/validazione.js"></script>
</body>
</html>
