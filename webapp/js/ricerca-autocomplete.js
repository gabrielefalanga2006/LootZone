
document.addEventListener("DOMContentLoaded", function() {
    var searchInput = document.getElementById("searchInput");
    if (!searchInput) return;
    var suggestionsBox = document.createElement("div");
    suggestionsBox.setAttribute("id", "suggestionsBox");
    suggestionsBox.style.position = "absolute";
    suggestionsBox.style.backgroundColor = "var(--surface-color)";
    suggestionsBox.style.border = "1px solid var(--accent-purple)";
    suggestionsBox.style.width = searchInput.offsetWidth + "px";
    suggestionsBox.style.display = "none";
    suggestionsBox.style.zIndex = "1000";
    searchInput.parentNode.appendChild(suggestionsBox);
    searchInput.addEventListener("keyup", function() {
        var query = searchInput.value;
        if (query.trim().length === 0) {
            suggestionsBox.style.display = "none";
            return;
        }
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var responseTesto = xhr.responseText;
                var prodotti = JSON.parse(responseTesto);
                suggestionsBox.innerHTML = ""; 
                if (prodotti.length > 0) {
                    var ul = document.createElement("ul");
                    ul.style.listStyleType = "none";
                    ul.style.margin = "0";
                    ul.style.padding = "0";
                    prodotti.forEach(function(p) {
                        var li = document.createElement("li");
                        li.style.padding = "10px";
                        li.style.borderBottom = "1px solid #333";
                        li.style.cursor = "pointer";
                        var a = document.createElement("a");
                        a.href = "dettaglio?id=" + p.id; 
                        a.style.color = "var(--text-primary)";
                        a.style.display = "block";
                        a.textContent = p.nome; 
                        li.appendChild(a);
                        li.addEventListener("mouseover", function() {
                            li.style.backgroundColor = "var(--accent-purple)";
                        });
                        li.addEventListener("mouseout", function() {
                            li.style.backgroundColor = "transparent";
                        });
                        ul.appendChild(li);
                    });
                    suggestionsBox.appendChild(ul);
                    suggestionsBox.style.display = "block";
                } else {
                    suggestionsBox.style.display = "none";
                }
            }
        };
        var contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
        if(contextPath === "") contextPath = "/LootZone"; 
        xhr.open("GET", contextPath + "/ricercaAjax?q=" + encodeURIComponent(query), true);
        xhr.send();
    });
    document.addEventListener("click", function(e) {
        if (e.target !== searchInput && e.target !== suggestionsBox) {
            suggestionsBox.style.display = "none";
        }
    });
});
