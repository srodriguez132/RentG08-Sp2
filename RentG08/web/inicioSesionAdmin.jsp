<%-- 
    Document   : inicioSesionAdmin
    Created on : 25-dic-2018, 11:09:25
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>RentG - Inicio Sesión Responsable</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/inicioSesionAdmin.css">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="icon" href="img/favicon.png" sizes="16x16">

        <script src="javascript/comprobacionTReal.js"></script>
    </head>
    <body>
        <header class= "cabecera" id="cabeceraInicioSesion">
            <a id="logo-header" href="#">

                <img src="img/Logo RentG.png" style="max-width: 35%">

            </a>

        </header>
        <nav id="menupricipal">
            <div>
                <ul>
                    <li id="busqueda"><a href="index.jsp">Búsqueda</a></li>
                    <li><a href="registro.jsp">Registrarse</a></li>
                    <li id="pestanaActual"><a id="pestanaActualTexto" href="#">Iniciar Sesion</a></li>

                </ul>
            </div>
        </nav>
        <main>
            <div>
                <section id="logueo">
                    <div id="envoltura">
                        <div id="contenedor">
                            <div id="superior" >
                                <img src="img/admin.png" style="max-width: 18%">
                            </div>
                            <div id="cuerpo">
                                <form name="logueo" action="LoginAdmin" class="formulario" id="iniciarsesion"  method="post">
                                    <label for="text" class="campo">Usuario: 
                                        <input type="text" name="usuario" id="usuario" pattern="^[a-zA-Z0-9]{1,30}$" required=""/>
                                    </label><br />
                                    <div id="mensajeError">
                                        <%
                                            if (request.getParameter("message") != null) {
                                        %>

                                        <h3><%=request.getParameter("message")%></h3>

                                        <% }
                                        %>
                                    </div>

                                    <label for="contrasena">Contraseña:
                                        <input type="password" name="contrasena" id="contrasena" pattern="^[a-zA-Z0-9]{1,30}$" required=""/>
                                    </label><br />
                                    <div class="clear"></div>
                                    <section id="zonadatos">
                                    </section>
                                    <button type="submit" id="btnInicioSesion" class="boton">Iniciar Sesión</button>
                                </form>
                            </div>
                            <div id="pieiniciosesion">Sistema de Inicio de Sesión Responsable <br />
                                <a id="link" href="inicioSesion.jsp">Inicio Sesión Usuario</a>
                            </div>

                            </section>
                        </div>
                        </main>
                        <footer id="seccionpie">
                            <div>
                                <section class="seccionpie" id="inicioSesionPie">
                                    <address>Vitoria, País Vasco</address>
                                    <small>&copy; Derechos Reservados 2018</small>
                                </section>
                            </div>
                        </footer>
                        </body>
                        </html>
