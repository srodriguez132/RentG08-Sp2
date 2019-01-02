<%-- 
    Document   : consultaReservaRS
    Created on : 02-ene-2019, 16:10:51
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="utils.BD08"%>
<%@page import="java.sql.Connection"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Consulta Reservas Admin</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="stylesheet" href="css/consultaReservaAdmin.css">
        <link rel="icon" href="img/favicon.png" sizes="16x16">
        <script src="javascript/indexedunido.js"></script>
    </head>
    <body>
        <header class="cabecera" id="cabeceraBusqueda">
            <a id="logo-header" href="inicioLogueado.jsp">
                <img src="img/Logo RentG.png" style="max-width: 35%">
            </a>
        </header>
        <nav id="menupricipal">
            <div>
                <ul>
                    <li ><a href="inicioSesionAdmin.html">Cerrar Sesion Admin</a></li>
                    <li id="pestanaActual"><a  id="pestanaActualTexto" href="#">Consultar Reservas</a></li>
                    <!--                    <li><a href="inicioSesion.html">Iniciar Sesión</a></li>-->
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
                                <form name="formulario" >
                                    <label for="email">Email:</label>
                                    <input type="email" name="cliente" id="consCliente"><br />
                                    <input type="button" name="botonC" id="botonC" class="boton" value="Buscar por cliente" action="consultaRS" method="post"><br />
                                    <label for="date">Fecha:</label>
                                    <input type="date" name="fecha" id="consFecha"><br />
                                    <input type="button" name="botonF" id="botonF" class="boton" value="Buscar por fecha" action="consultaRS" method="post"><br />
                                    <label for="matricula">Matrícula:</label>
                                    <input type="text" name="matricula" id="consMatricula"><br />
                                    <input type="button" name="botonM" id="botonM" class="boton" value="Buscar por matrícula" action="consultaRS" method="post"><br />
                                </form>
                            </div>
                            <section id="cajaReservas">   
                                <p>Información no disponible</p>
                            </section>
                            <div id="pieconsulta">Sistema de Consulta</div>                    
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
                      