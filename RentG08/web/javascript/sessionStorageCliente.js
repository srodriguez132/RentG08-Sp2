window.addEventListener('load', iniciar, false);
//window.addEventListener('load', mostrarNombre, false);
var bd;
function iniciar() {
    var boton = document.getElementById('btnInicioSesion');
    if (boton) {
        boton.addEventListener('click', nuevoitem, false);
    }
    mostrarNombre();
}
function nuevoitem() {
//    var valid = document.iniciarSesion.checkValidity();
//    
//    if(valid){
    var clave = document.getElementById('email').value;
//    var valor = document.getElementById('nombre').value;
    sessionStorage.setItem("email", clave);
    //  mostrar();

    document.getElementById('nombre').value = '';
//    }
}
function mostrarNombre() {
    var clave;
    var cajadatos = document.getElementById('nombreSesion');
    cajadatos.innerHTML = '';
    var solicitud = indexedDB.open("RentG08");

    solicitud.onsuccess = function (e) {
        bd = e.target.result;
        var transaccion = bd.transaction(["clientes"], "readonly");
        var objectStore = transaccion.objectStore("clientes");
        objectStore.openCursor().onsuccess = function (event) {
            var cursor = event.target.result;
            if (cursor) {
                //Comprueba que los datos existen en la base de datos y que coincidan
                if (cursor.value.email === sessionStorage.getItem("email")) {
                    clave = cursor.value.nombre;
                    cajadatos.innerHTML += 'Hola, ' + clave;
                } else {

                    cursor.continue();

                }
            }

        };
    };





}