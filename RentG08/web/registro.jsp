<!DOCTYPE html>
<html lang ="es">
    <head>
        <title>RentG - Registro</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/registro.css">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="icon" href="img/favicon.png" sizes="16x16">
        <link rel="stylesheet" href="css/arrastrarImagen.css">



        <script src="javascript/arrastrarImagen.js"></script>
        <script src="javascript/sessionStorageCliente.js"></script>
        <script src="javascript/comprobacionTReal.js"></script>

    </head>
    <body>
        <header class="cabecera" id="cabeceraRegistro">
            <a id="logo-header" href="index.html">
                <img src="img/Logo RentG.png" style="max-width: 35%">

            </a>

        </header>
        <nav id="menupricipal">
            <div>
                <ul>
                    <li id="busqueda"><a href="index.html">B�squeda</a></li>
                    <li id="pestanaActual"><a id="pestanaActualTexto" href="#">Registrarse</a></li>
                    <li><a href="inicioSesion.jsp">Iniciar Sesi�n</a></li>

                </ul>
            </div>
        </nav>
        <main>
            <div>
                <section id="registrar">
                    <div id="envoltura">
                        <div id="contenedor">
                            <div id="superior" >
                                <img src="img/favicon.png" style="max-width: 18%">
                            </div>
                            <div id="cuerpo">
                                <form name="datos" action="Registrarse" class="formulario" id="registro" method="post" enctype="multipart/form-data">
                                    <label for="email" class="campo">E-mail: 
                                        <input type="email" name="email" id="email" placeholder="Ej: a@a.com" pattern="^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$" required=""/>
                                    </label><br />
                                    <div id="mensajeError">
                                        <%
                                            if (request.getParameter("message") != null) {
                                        %>
                                        
                                            <h3><%=request.getParameter("message")%></h3>
                                        
                                        <% }
                                        %>
                                    </div>
                                    
                                    <label for="contrasena">Contrase�a:
                                        <input type="password"  name="contrasena" id="contrasena" required=""/>
                                    </label><br />
                                    <label for="nombre">Nombre:
                                        <input type="text" id="nombre" maxlength="20" name="nombre" pattern="^[a-zA-Z]{3,20}$" required=""/>
                                    </label><br />
                                    <label for="apellido">Apellido:
                                        <input type="text" name="apellido" maxlength="40" id="apellido" required=""/>
                                    </label><br />
                                    <label for="movil">M�vil:
                                        <input type="tel" name="movil" id="movil" pattern="^(\+34|0034|34)?[6|7|9][0-9]{8}$" required=""/>
                                    </label><br />

                                    <label for="imagen">Imagen:
                                    </label>
                                    
                                    <input type="file" id="caja" name="imagen"/>
                                    <p id="txtImagen">Arrastre y suelte la imagen el en recuadro superior</p>
                                    <br />

                                    <button type="submit" id="registrarse" class="boton">Registrarse</button>

                                </form>
                                    
                                   

                            </div>
                            <div id="pieregistro">Sistema de Registro</div>

                            </section>
                        </div>

                        </main>

                        <footer id="seccionpie">
                            <div>
                                <section class="seccionpie" id="registropie">
                                    <address>Vitoria, Pa�s Vasco</address>
                                    <small>&copy; Derechos Reservados 2018</small>
                                </section>
                            </div>
                        </footer>
                        </body>
                        </html>
