<%@page import="java.io.File"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="utils.BD08"%>
<%@page import="java.sql.Connection"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang ="es">
    <head>
        <title>RentG - Búsqueda</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/busquedaSergio.css">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="icon" href="img/favicon.png" sizes="16x16">

        <script src="javascript/sessionStorageCliente.js"></script>
        <script src="javascript/cerrarSesion.js"></script>

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
                    <li><a href="inicioSesion.jsp" id="cerrarsesion">Cerrar Sesion</a></li>
                    <li id="pestanaActual"><a id="pestanaActualTexto" href="inicioLogueado.jsp">Búsqueda</a></li>
                    <li><a href="consultaReservaUsuario.jsp">Consultar Reservas</a></li>
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
                            }

                            ;  
             
                        %>
                        <%
                            String email = (String) session.getAttribute("emailUsuario");
                            try {

                                Statement set = con.createStatement();

                                ResultSet rs = set.executeQuery("SELECT * from clientes WHERE email LIKE '%" + email + "%'");
                                rs.next();
                                String nombre = rs.getString("nombre");
                                String imagen = rs.getString("imagen");

                                HttpSession s2 = request.getSession();
                                s2.setAttribute("nombreUsuario", nombre);
                        %>  


                    <li><h1>Hola, <%=nombre%></h1> </li>
                    <img id="imgusuario" src="img/<%=imagen%>" alt=""  width="80"/>

                    <%

                            rs.close();
                            set.close();

                        } catch (SQLException ex) {
                            System.out.println("Error en acceso a Clientes" + ex);
                        }
                    %>

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
                                <form action="BuscarLogueado" name="busqueda" class="formulario" method="post">
                                    <label for="fechaI">Fecha Inicio:</label>
                                    <input type="date" name="fechaI" id="fechaI" required=""><br /> 
                                    <label for="horaI">Hora Inicio:</label>
                                    <input type="time" name="horaI" id="horaI" required=""><br />
                                    <label for="fechaF">Fecha Fin:</label>
                                    <input type="date" name="fechaF" id="fechaF" required=""><br />
                                    <label for="horaF">Hora Fin:</label>
                                    <input type="time" name="horaF" id="horaF" required=""><br />
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
                                    <button type="submit" id="buscar" class="boton">Buscar coches</button>
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
