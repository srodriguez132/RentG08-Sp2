
window.addEventListener("load", inicio, false);
var bd;

function inicio() {
    boton = document.getElementById("btnInicioSesion");
    boton.addEventListener("click", login, false);

    var solicitud = indexedDB.open("RentG08");

    solicitud.onsuccess = function (e) {
        bd = e.target.result;
    };

}

function login() {
    var transaccion = bd.transaction(["clientes"], "readonly");
    var objectStore = transaccion.objectStore("clientes");

    var valido = document.datos.checkValidity();

    if (valido) {

        objectStore.openCursor().onsuccess = function (event) {
            var cursor = event.target.result;
            var existe = false;

            if (cursor) {
                //Comprueba que los datos existen en la base de datos y que coincidan
                if (cursor.value.email === document.getElementById("email").value && cursor.value.contrasena === document.getElementById("contrasena").value) {

                    existe = true;
                    location.href = "inicioLogueado.html";

                } else {

                    cursor.continue();

                }
            } else {
                if (existe) {

                    location.href = "inicioLogueado.html";
                } else {
                    alert('Email o contraseña incorrectos');
                    location.href = "inicioSesion.html";
                    sessionStorage.clear();

                }
            }

        };

    } else {
        alert('Email o contraseña incorrectos');


    }
}


