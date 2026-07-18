<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty prodotto ? 'Aggiungi Prodotto' : 'Modifica Prodotto'} - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variabili-tema.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-footer.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        .admin-form-container {
            max-width: 900px;
            margin: var(--spacing-lg) auto;
            background-color: var(--surface-color);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius-md);
            border: 1px solid var(--border-color);
        }
        .form-layout {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-lg);
        }
        .form-left {
            flex: 1 1 300px;
            display: flex;
            flex-direction: column;
            gap: var(--spacing-md);
        }
        .form-right {
            flex: 2 1 400px;
            display: flex;
            flex-direction: column;
            gap: var(--spacing-md);
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            margin-bottom: var(--spacing-sm);
            color: var(--text-secondary);
        }
        .form-group input, .form-group textarea, .form-group select {
            padding: var(--spacing-sm);
            background-color: var(--bg-color);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            font-family: var(--font-main);
        }
        .image-preview {
            width: 100%;
            height: 300px;
            background-color: var(--bg-color);
            border: 1px dashed var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
            border-radius: var(--border-radius-sm);
            margin-bottom: var(--spacing-sm);
        }
    </style>
</head>
<body>
    <jsp:include page="/fragments/header.jsp" />
    <main>
        <div class="admin-form-container">
            <h2 style="margin-bottom: var(--spacing-md); border-left: 4px solid var(--accent-pink); padding-left: 10px;">
                ${empty prodotto ? 'Aggiungi Prodotto' : 'Modifica Prodotto'}
            </h2>
            <form action="${pageContext.request.contextPath}/admin/prodotto" method="POST" enctype="multipart/form-data">
                <c:if test="${not empty prodotto}">
                    <input type="hidden" name="id" value="${prodotto.idProdotto}">
                </c:if>
                <input type="hidden" name="action" value="save">
                <div class="form-layout">
                    <div class="form-left">
                        <div class="image-preview">
                            <c:choose>
                                <c:when test="${not empty prodotto.immagineUrl}">
                                    <img src="${pageContext.request.contextPath}/images/${prodotto.immagineUrl}" alt="Immagine di ${prodotto.nome}" style="max-width:100%; max-height:100%;">
                                </c:when>
                                <c:otherwise>
                                    <span>Nessuna foto selezionata</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="form-group">
                            <label for="immagineProdotto">Immagine Prodotto:</label>
                            <input type="file" id="immagineProdotto" name="immagineProdotto" accept="image/*" ${empty prodotto ? 'required' : ''}>
                        </div>
                    </div>
                    <div class="form-right">
                        <div class="form-group">
                            <label for="nome">Nome Prodotto:</label>
                            <input type="text" id="nome" name="nome" value="${prodotto.nome}" required>
                        </div>
                        <div class="form-group">
                            <label for="descrizione">Descrizione:</label>
                            <textarea id="descrizione" name="descrizione" rows="4">${prodotto.descrizione}</textarea>
                        </div>
                        <div style="display:flex; gap:1rem;">
                            <div class="form-group" style="flex:1;">
                                <label for="piattaforma">Piattaforma:</label>
                                <input type="text" id="piattaforma" name="piattaforma" value="${prodotto.piattaforma}">
                            </div>
                            <div class="form-group" style="flex:1;">
                                <label for="genere">Genere:</label>
                                <input type="text" id="genere" name="genere" value="${prodotto.genere}">
                            </div>
                        </div>
                        <div style="display:flex; gap:1rem;">
                            <div class="form-group" style="flex:1;">
                                <label for="tipo_formato">Formato:</label>
                                <select id="tipo_formato" name="tipo_formato">
                                    <option value="Fisico" ${prodotto.tipoFormato == 'Fisico' ? 'selected' : ''}>Fisico</option>
                                    <option value="Digitale" ${prodotto.tipoFormato == 'Digitale' ? 'selected' : ''}>Digitale</option>
                                </select>
                            </div>
                            <div class="form-group" style="flex:1;">
                                <label for="prezzo">Prezzo (€):</label>
                                <input type="number" step="0.01" id="prezzo" name="prezzo" value="${prodotto.prezzo}" required>
                            </div>
                        </div>
                        <div style="margin-top: var(--spacing-md); text-align:right;">
                            <a href="${pageContext.request.contextPath}/admin/catalogo" class="btn-primary" style="background-color:var(--border-color); margin-right:10px;">Annulla</a>
                            <button type="submit" class="btn-accent">Salva Prodotto</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>
    <jsp:include page="/fragments/footer.jsp" />
</body>
</html>
