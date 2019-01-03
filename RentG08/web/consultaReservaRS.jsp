<%-- 
    Document   : consultaReservaRS
    Created on : 02-ene-2019, 16:10:51
    Author     : Usuario
--%>

<%@page import="java.sql.Date"%>
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
        <script src="javascript/vaciarTabla.js"></script>

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
                                <img src="img/busqueda.png" style="max-width: 5%">
                            </div>
                            <div id="cuerpo">
                                <form name="formulario" action="consultaRS" method="post" >
                                    <label for="email">Email:</label>
                                    <input type="email" name="cliente" id="consCliente"><br />
                                    <input type="submit" name="boton" id="botonC" class="boton" value="Buscar por cliente" ><br />
                                    <label for="date">Fecha:</label>
                                    <input type="date" name="fecha" id="consFecha"><br />
                                    <input type="submit" name="boton" id="botonF" class="boton" value="Buscar por fecha" ><br />
                                    <label for="matricula">Matrícula:</label>
                                    <input type="text" name="matricula" id="consMatricula"><br />
                                    <input type="submit" name="boton" id="botonM" class="boton" value="Buscar por matrícula" ><br />
                                </form>
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
                                <section id="zonadatos"> 
                                    <div class="datagrid">
                                        <table>
                                            <thead><tr><th></th><th>Fecha Inicio</th><th>Fecha Fin</th><th>Fecha Entrega</th><th>Fecha Devolución</th><th>Matrícula</th><th>Estado</th>
                                                    <th>Precio</th><th>Penalización</th><th>Total</th><th>Acciones</th></tr></thead>


                                            <tbody id="datosTabla">


                                                <%
                                                    HttpSession s = request.getSession();
                                                    String email = (String) session.getAttribute("emailUsuario");
                                                    try {
                                                        Statement set = con.createStatement();
                                                        String matricula;
                                                        Date fechainicio;
                                                        Date fechafin;
                                                        String estado;
                                                        int penalizacion;
                                                        int precio;
                                                        int total;
                                                        Date inicio;
                                                        Date fin;
                                                        ResultSet rs;
                                                        if (request.getParameter("boton").equals("Buscar por fecha")) {
                                                            String fechaBusqueda = request.getParameter("fecha");
                                                            rs = set.executeQuery("SELECT * from reserva WHERE fechainicio >= CAST('" + fechaBusqueda + "' as datetime)");
                                                        } else if (request.getParameter("boton").equals("Buscar por matricula")) {
                                                            String MatriculaBusqueda = request.getParameter("matricula");
                                                            rs = set.executeQuery("SELECT * from reserva WHERE matricula ='" + MatriculaBusqueda + "'");
                                                        } else {
                                                            String emailBusqueda = request.getParameter("cliente");
                                                            rs = set.executeQuery("SELECT * from reserva WHERE email ='" + emailBusqueda + "'");
                                                        }
                                                        int cont = 0;
                                                        while (rs.next()) {
                                                            int id = rs.getInt("id");
                                                            matricula = rs.getString("matricula");
                                                            fechainicio = rs.getDate("fechainicio");
                                                            fechafin = rs.getDate("fechafin");
                                                            estado = rs.getString("estado");
                                                            penalizacion = rs.getInt("penalizacion");
                                                            precio = rs.getInt("precio");
                                                            total = rs.getInt("total");
                                                            inicio = rs.getDate("inicio");
                                                            fin = rs.getDate("fin");
                                                            if (cont % 2 == 0) {
                                                                if (inicio == null && fin == null) {
                                                %>                         

                                                <tr> <td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td> <td><%=fechainicio%></td><td><%=fechafin%></td><td><input type="datetime" name="fechaEntrega"/></td><td><input type="datetime" name="fechaDevolucion"/></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>

                                                <%} else if (inicio == null && fin != null) {
                                                %>                         

                                                <tr> <td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td> <td><%=fechainicio%></td><td><%=fechafin%></td><td><%=inicio%></td><td><input type="datetime" name="fechaDevolucion"/></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>

                                                <%} else if (inicio != null && fin == null) {
                                                %>                         

                                                <tr> <td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td> <td><%=fechainicio%></td><td><%=fechafin%></td><td><input type="datetime" name="fechaEntrega"/></td><td><%=fin%></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>

                                                <%} else {
                                                %>                         

                                                <tr> <td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td> <td><%=fechainicio%></td><td><%=fechafin%></td><td><%=inicio%></td><td><%=fin%></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>

                                                <%}

                                                } else {
                                                    if (inicio == null && fin == null) {
                                                %>                         
                                                <tr class="alt"><td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td><td><%=fechainicio%></td><td><%=fechafin%></td><td><input type="datetime" name="fechaEntrega"/></td><td><input type="datetime" name="fechaDevolucion"/></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>
                                                    <%}
                                                        if (inicio != null && fin == null) {
                                                    %>
                                                <tr class="alt"><td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td><td><%=fechainicio%></td><td><%=fechafin%></td><td><%=inicio%></td><td><input type="datetime" name="fechaDevolucion"/></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>
                                                    <% }
                                                        if (inicio == null && fin != null) {
                                                    %>
                                                <tr class="alt"><td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td><td><%=fechainicio%></td><td><%=fechafin%></td><td><input type="datetime" name="fechaEntrega"/></td><td><%=fin%><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>
                                                    <%} else {
                                                    %>

                                                <tr class="alt"><td><input type="radio" id="seleccionReserva" name="R1" value=<%=id%>/></td><td><%=fechainicio%></td><td><%=fechafin%></td><td><%=inicio%></td><td><%=fin%></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>
                                                    <%}

                                                                    cont = cont + 1;
                                                                }
                                                            }
                                                            rs.close();
                                                            set.close();

                                                            //con.close();
                                                        } catch (Exception ex) {
                                                            System.out.println("Error en acceso a BD Jugadores" + ex);
                                                        }
                                                    %>
                                            </tbody>
                                    </div> 
                                    </table>
                            </div>
                            <p>
                                <br> <button type="submit" class="boton" action="Total" method="post">Guardar fechas</button></br>
                                <br> <button  onclick="vaciar()" class="boton" name="btnConsultaUsuario" value="vaciar">Vaciar</button></br>
                            </p>
                        </div>
                        <div id="pieconsulta">Sistema de Consulta</div>                    
                </section>
            </div>
        </main>
        <footer id="seccionpie">
            <div>
                <section class="seccionpie" id="consultaRSpie">
                    <address>Vitoria, País Vasco</address>
                    <small>&copy; Derechos Reservados 2018</small>
                </section>
            </div>
        </footer>
    </body>
</html>