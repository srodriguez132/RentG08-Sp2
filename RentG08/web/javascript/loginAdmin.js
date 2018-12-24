
window.addEventListener("load", inicio, false);


function inicio() {
    boton = document.getElementById("btnInicioSesion");
    boton.addEventListener("click", login, false);



}

function login() {

    var usuario = document.getElementById("usuario").value;
    var contrasena = document.getElementById("contrasena").value;

    if (usuario === "admin" && contrasena === "admin") {
        alert('Bienvenido, Responsable de Oficina');
        location.href = "consultaReservaRS.html";

    } else {
        alert('Usuario o contraseña incorrectos');
        location.href = "inicioSesionAdmin.html";
    }


}






