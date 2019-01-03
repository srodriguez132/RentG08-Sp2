<!DOCTYPE html>
<html lang ="es">
    <head>
        <title>RentG - Búsqueda</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/busquedaSergio.css">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="icon" href="img/favicon.png" sizes="16x16">



    </head>
    <body>
        <header class="cabecera" id="cabeceraBusqueda">
            <a id="logo-header" href="#">
                <img src="img/Logo RentG.png" style="max-width: 35%">
            </a>
        </header>
        <nav id="menupricipal">
            <div>
                <ul>
                    <li id="pestanaActual"><a id="pestanaActualTexto" href="#">Búsqueda</a></li>
                    <li><a href="registro.jsp">Registrarse</a></li>
                    <li><a href="inicioSesion.jsp">Iniciar Sesión</a></li>

                </ul>
            </div>
        </nav>
        <main>
            <div>
                <section id="busqueda">
                    <div id="envoltura">
                        <div id="contenedor">

                            <div id="superior" >
                                <img src="img/busqueda.png" style="max-width: 18%">
                            </div>
                            <div id="cuerpo">
                                <form action="Buscar" name="busqueda" class="formulario" method="post">
                                    <label for="fechaI">Fecha Inicio:</label>
                                    <input type="date" name="fechaI" id="fechaI" ><br /> 
                                    <label for="horaI">Hora Inicio:</label>
                                    <input type="time" name="horaI" id="horaI"><br />
                                    <label for="fechaF">Fecha Fin:</label>
                                    <input type="date" name="fechaF" id="fechaF"><br />
                                    <label for="horaF">Hora Fin:</label>
                                    <input type="time" name="horaF" id="horaF"><br />
                                    <label for="lugar">Lugar:</label><br>
                                    <select name="lugar" id="lugar">
                                        <option value ="Vitoria-Gasteiz">Vitoria-Gasteiz</option>
                                        <option value ="Donostia">Donostia</option>
                                        <option value ="Bilbao">Bilbao</option>
                                    </select><br />
                                    <div id="mensajeError">
                                        <%
                                            if (request.getParameter("message") != null) {
                                        %>

                                        <h3><%=request.getParameter("message")%></h3>

                                        <% }
                                        %>
                                    </div>
                                    <button type="submit" id="btnBuscar" class="boton">Buscar coches</button>
                                </form>
                            </div>
                            <div id="pieiniciosesion">Sistema de Búsqueda de Coches</div>
                            </section>
                        </div>
                        </main>
                        <footer id="seccionpie">
                            <div>
                                <section class="seccionpie" id="busquedapie">
                                    <address>Vitoria, País Vasco</address>
                                    <small>&copy; Derechos Reservados 2018</small>
                                </section>
                            </div>
                        </footer>
                        </body>
                        </html>
