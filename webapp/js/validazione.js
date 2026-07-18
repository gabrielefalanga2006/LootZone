
function validaRegistrazione() {
    var nome = document.getElementById("nome").value.trim();
    var cognome = document.getElementById("cognome").value.trim();
    var email = document.getElementById("email").value.trim();
    var password = document.getElementById("password").value;
    var errorBox = document.getElementById("error-box");
    if (nome === "" || cognome === "" || email === "" || password === "") {
        errorBox.innerHTML = "Tutti i campi obbligatori devono essere compilati.";
        errorBox.style.display = "block";
        return false;
    }
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        errorBox.innerHTML = "Formato email non valido.";
        errorBox.style.display = "block";
        return false;
    }
    if (password.length < 6) {
        errorBox.innerHTML = "La password deve contenere almeno 6 caratteri.";
        errorBox.style.display = "block";
        return false;
    }
    return true; 
}
function validaLogin() {
    var email = document.getElementById("email").value.trim();
    var password = document.getElementById("password").value;
    var errorBox = document.getElementById("error-box");
    if (email === "" || password === "") {
        errorBox.innerHTML = "Inserisci email e password.";
        errorBox.style.display = "block";
        return false;
    }
    return true;
}
document.addEventListener("DOMContentLoaded", function() {
    var regForm = document.getElementById("regForm");
    if (regForm) {
        regForm.addEventListener("submit", function(e) {
            if (!validaRegistrazione()) {
                e.preventDefault(); 
            }
        });
    }
    var loginForm = document.getElementById("loginForm");
    if (loginForm) {
        loginForm.addEventListener("submit", function(e) {
            if (!validaLogin()) {
                e.preventDefault(); 
            }
        });
    }
});
