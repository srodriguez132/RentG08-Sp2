<%@page import="java.sql.Date"%>
<%@page import="java.io.File"%>
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
        <script src="javascript/vaciarTabla.js"></script>
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
                            }

                            ;
                            
                            
                              
                        %>

                    <%
                        HttpSession s = request.getSession();

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
                    <img src="img/<%=imagen%>" alt=""  width="80"/>

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
                                <img src="img/busqueda.png" style="max-width: 8%">
                            </div>
                            <div id="cuerpo">                
                                <form name="formulario" action="consultaReservaUsuario.jsp" method="post">
                                    <label for="fecha">Fecha: </label>
                                    <input type="date" name="fecha" id="fechaUsuario"><br />
                                    <button type="submit" name="btnConsultaUsuario" id="botonPost" class="boton" value="buscar">Buscar<br />
                                         
                      
                                </form>
                                
                               
                            </div>    
                             <div id="mensajeErrorConsulta">
                                        <%
                                            if (request.getParameter("message") != null) {
                                        %>

                                        <p><%=request.getParameter("message")%></p>

                                        <% }
                                        %>
                                    </div>
                            <form name="cancelarReservas" action="ConsultaUsuario" method="post">
                                <section id="zonadatos">   

                                    <div class="datagrid">
                                        <table>
                                            <thead><tr><th></th><th>Fecha Inicio</th><th>Fecha Fin</th><th>Matrícula</th><th>Estado</th>
                                                    <th>Precio</th><th>Penalización</th><th>Total</th><th>Acciones</th></tr></thead>


                                            <tbody id="datosTabla">


                                                <%
                                                    try {
                                                        String matricula;
                                                        Date fechainicio;
                                                        Date fechafin;
                                                        String estado;
                                                        int penalizacion;
                                                        int precio;
                                                        int total;
                                                        String fechaBusqueda = request.getParameter("fecha");
                                                        Statement set = con.createStatement();
                                                        ResultSet rs = set.executeQuery("SELECT * from reserva WHERE email LIKE '%" + email + "%' AND fechainicio >= CAST('" + fechaBusqueda + "' as datetime)");
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
                                                            
                                                            if (cont % 2 == 0) {
                                                %>                         

                                                <tr> <td><input type="radio" id="seleccionReserva" name="R1" value="<%=id%>"/></td> <td><%=fechainicio%></td><td><%=fechafin%></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>

                                                <%
                                                } else {
                                                %>
                                                <tr class="alt"><td><input type="radio" id="seleccionReserva" name="R1" value="<%=id%>"/></td><td><%=fechainicio%></td><td><%=fechafin%></td><td><%=matricula%></td><td><%=estado%></td><td><%=precio%></td>
                                                    <td><%=penalizacion%></td><td><%=total%></td><td>data</td></tr>
                                                    <%
                                                                }
                                                                cont = cont + 1;
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
                                        <br> <button type="submit" name="btnConsultaUsuario" class="boton" value="cancelar">Cancelar Reserva</button></br>
                                        
                                        <br> <button  onclick="vaciar()" class="boton" name="btnConsultaUsuario" value="vaciar">Vaciar</button></br>
                                        </p>
                                    
                                </section>
                                              
                            </form>
                            
                                        
                                        
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
