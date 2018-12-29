<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="utils.BD08"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang ="es">
    <head>
        <title>RentG - Inicio Sesión</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/iniciosesion.css">
        <link rel="stylesheet" href="css/css1.css">

        <link rel="icon" href="img/favicon.png" sizes="16x16">
        <!--        <script src="javascript/loginCliente.js"></script>
                <script src="javascript/indexedunido.js"></script>
                <script src="javascript/sessionStorageCliente.js"></script>-->
        <script src="javascript/comprobacionTReal.js"></script>

    </head>
    <body>
        <header class= "cabecera" id="cabeceraInicioSesion">
            <a id="logo-header" href="index.html">
                <img src="img/Logo RentG.png" style="max-width: 35%">

            </a> 

        </header>
         
        <nav id="menupricipal">
            <div>
                <ul>
                    <li id="busqueda"><a href="index.html">Búsqueda</a></li>
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
                                <img src="img/login.png" style="max-width: 18%">
                            </div>
                            <div id="cuerpo">


                                <form action="Login" name="datos" class="formulario" id="iniciarsesion" method="post">
                                    <label for="email" class="campo">E-mail: 
                                        <input type="email" name="email" id="email"  pattern="^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$" required/>
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
                                        <input type="password" name="contrasena" id="contrasena" required/>
                                    </label><br />
                                    <div class="clear"></div>
                                    <section id="zonadatos">
                                    </section>

                                    <button type="submit" id="btnInicioSesion" class="boton">Iniciar Sesión</button>

                                </form>


                            </div>
                            <div id="pieiniciosesion">Sistema de Inicio de Sesión de Usuario <br />

                                <a id="link" href="inicioSesionAdmin.jsp">Inicio Sesión Responsable</a>
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
