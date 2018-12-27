<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.BD08"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page session="true"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Consulta de tus reservas</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="stylesheet" href="css/consultaReserva.css">
        <link rel="icon" href="img/favicon.png" sizes="16x16">
        <script src="javascript/indexedunido.js"></script>
        <script src="javascript/sessionStorageCliente.js"></script>
        <script src="javascript/cerrarSesion.js"></script>

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
                    <li><a href="inicioSesion.jsp" id="cerrarsesion">Cerrar Sesion</a></li>
                    <li><a href="inicioLogueado.jsp">Búsqueda</a></li>
                    <li  id="pestanaActual"><a id="pestanaActualTexto"  href="consultaReservaUsuario.jsp">Consultar Reservas</a></li>
                        <%!
                            private Connection con;
                            
                            public void jspInit() {
                                ServletContext application = getServletContext();
                                String IP = application.getInitParameter("IP");
                                String database = application.getInitParameter("BDNombre");
                                String URL = "jdbc:mysql://" + IP + "/" + database;
                                String userName = application.getInitParameter("usuario");
                                String password = application.getInitParameter("contrasena");
                                con = BD08.getConexion(URL, userName, password);
                            };
                            
                            
                              
                        %>
                    
                        <%
                            HttpSession s = request.getSession();
                            
                            String nombre = (String) s.getAttribute("nombreUsuario");
                         
                            
                                
                        %>   

                    <li><h1><%=nombre%></h1> </li>

                    
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
                                <form name="formulario">
                                    <label for="fecha">Fecha: </label>
                                    <input type="date" name="fecha" id="fechaUsuario"><br />
                                    <input type="button" name="botonPost" id="botonPost" class="boton" value="Buscar Posteriores"><br />
                                    <input type="button" name="botonAnt" id="botonAnt" class="boton" value="Buscar Anteriores"><br />
                                </form>
                            </div>    
                            <section id="zonadatos">   

                            </section>
                            <div id="pieconsulta">Sistema de Consulta</div>                       
                            </section>    
                        </div>
                        </main>  
                        <footer id="seccionpie">
                            <div>
                                <section class="seccionpie" id="busquedapieUsuario">
                                    <address>Vitoria, País Vasco</address>
                                    <small>&copy; Derechos Reservados 2018</small>
                                </section>
                            </div>
                        </footer>
                        </body>
                        </html>
