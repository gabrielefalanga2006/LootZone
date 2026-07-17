<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profilo Utente - LootZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .profile-container {
            max-width: 800px;
            margin: var(--spacing-lg) auto;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
            border: 1px solid var(--border-color);
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-lg);
            align-items: center;
        }
        .profile-avatar {
            flex: 1;
            text-align: center;
        }
        .profile-avatar img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 3px solid var(--accent-pink);
            object-fit: cover;
        }
        .profile-details {
            flex: 2;
        }
        .profile-details p {
            margin-bottom: var(--spacing-md);
            font-size: 1.1rem;
        }
        .profile-details p span {
            color: var(--text-secondary);
            display: inline-block;
            width: 150px;
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main>
        <div class="profile-container">
            <div class="profile-avatar">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.utente.nome}+${sessionScope.utente.cognome}&background=111111&color=01FF70&size=150" alt="Avatar">
            </div>
            <div class="profile-details">
                <h2>Il tuo Profilo</h2>
                <hr style="border-color:var(--border-color); margin-bottom:var(--spacing-md);">
                <p><span>Nome e Cognome:</span> <strong><c:out value="${sessionScope.utente.nome} ${sessionScope.utente.cognome}"/></strong></p>
                <p><span>Email:</span> <strong><c:out value="${sessionScope.utente.email}"/></strong></p>
                <p><span>Metodo di Pagamento:</span> <strong>Carte / PayPal Salvato (Mock)</strong></p>
                <div style="margin-top: var(--spacing-lg);">
                    <a href="${pageContext.request.contextPath}/ordini" class="btn-primary" style="background-color: var(--border-color);">Vai ai miei ordini</a>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
