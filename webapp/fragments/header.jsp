<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<header class="site-header">
    <button class="hamburger-btn" id="openSidebarBtn">&#9776;</button>
    <div class="logo-container">
        <a href="${pageContext.request.contextPath}/home" style="text-decoration:none;">
            <h1>LOOT<span>ZONE</span></h1>
        </a>
    </div>
    <div class="header-actions">
        <c:if test="${empty sessionScope.utente or sessionScope.utente.ruolo != 'admin'}">
            <a href="${pageContext.request.contextPath}/carrello" style="text-decoration:none; font-size:1.5rem;" title="Vai al Carrello">
                🛒
                <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.totaleElementi > 0}">
                    <span class="cart-badge" style="background:var(--accent-green);color:#000;border-radius:50%;padding:2px 6px;font-size:0.8rem;vertical-align:top;margin-left:-10px;"><c:out value="${sessionScope.carrello.totaleElementi}" /></span>
                </c:if>
            </a>
        </c:if>
    </div>
</header>
<div class="overlay" id="sidebarOverlay"></div>
<div class="sidebar" id="mySidebar">
    <a href="javascript:void(0)" class="close-btn" id="closeSidebarBtn">&times;</a>
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/catalogo">Catalogo</a>
    <c:choose>
        <c:when test="${not empty sessionScope.utente}">
            <c:if test="${sessionScope.utente.ruolo != 'admin'}">
                <a href="${pageContext.request.contextPath}/profilo">Profilo (<c:out value="${sessionScope.utente.nome}" />)</a>
                <a href="${pageContext.request.contextPath}/ordini">I miei ordini</a>
                <a href="${pageContext.request.contextPath}/carrello">Carrello
                    <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.totaleElementi > 0}">
                        <span class="cart-badge" style="background:var(--accent-green);color:#000;border-radius:50%;padding:2px 6px;font-size:0.8rem;margin-left:5px;"><c:out value="${sessionScope.carrello.totaleElementi}" /></span>
                    </c:if>
                </a>
            </c:if>
            <c:if test="${sessionScope.utente.ruolo == 'admin'}">
                <a href="${pageContext.request.contextPath}/admin/catalogo" style="color:var(--accent-pink);">Admin Catalogo</a>
                <a href="${pageContext.request.contextPath}/admin/ordini" style="color:var(--accent-pink);">Admin Ordini</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/logout" style="color:var(--error-color);">Logout</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/login">Login / Registrati</a>
            <a href="${pageContext.request.contextPath}/carrello">Carrello
                <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.totaleElementi > 0}">
                    <span class="cart-badge" style="background:var(--accent-green);color:#000;border-radius:50%;padding:2px 6px;font-size:0.8rem;margin-left:5px;"><c:out value="${sessionScope.carrello.totaleElementi}" /></span>
                </c:if>
            </a>
        </c:otherwise>
    </c:choose>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var sidebar = document.getElementById("mySidebar");
        var overlay = document.getElementById("sidebarOverlay");
        var openBtn = document.getElementById("openSidebarBtn");
        var closeBtn = document.getElementById("closeSidebarBtn");
        function openSidebar() {
            sidebar.classList.add("open");
            overlay.classList.add("open");
        }
        function closeSidebar() {
            sidebar.classList.remove("open");
            overlay.classList.remove("open");
        }
        openBtn.addEventListener("click", openSidebar);
        closeBtn.addEventListener("click", closeSidebar);
        overlay.addEventListener("click", closeSidebar);
    });
</script>
<script src="${pageContext.request.contextPath}/js/ricerca-autocomplete.js"></script>
