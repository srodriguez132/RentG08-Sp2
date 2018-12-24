window.addEventListener("load", inicio, false);

function inicio(){
	boton=document.getElementById("cerrarsesion");
	boton.addEventListener("click",eliminarSessionStorage, false); 
}


function eliminarSessionStorage(){
    sessionStorage.clear();
 }
 