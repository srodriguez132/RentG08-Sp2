window.addEventListener("load", iniciar, false);

function iniciar() {
    document.datos.addEventListener("invalid", validacion, true);
    document.datos.addEventListener("input", controlar, false);

}

function validacion(e) {
    var elemento = e.target;
    elemento.style.background = '#FFDDDD';
}

function controlar(e) {
    var elemento = e.target;
    if (elemento.validity.valid) {
        elemento.style.background = '#FFFFFF';
    } else {
        elemento.style.background = '#FFDDDD';
    }
}