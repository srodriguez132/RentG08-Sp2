<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="utils.BD08"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang ="es">
    <head>
        <title>RentG - Reserva</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/busquedaSergio.css">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="stylesheet" href="css/reserva.css">

        <script src="javascript/indexedunido.js"></script>
        <script src="javascript/sessionStorageCliente.js"></script>
        <script src="javascript/cerrarSesion.js"></script>
        <link rel="icon" href="img/favicon.png" sizes="16x16">


    </head>
    <body>
        <header class="cabecera" id="cabeceraBusqueda">
            <a id="logo-header" href="#">
                <img id="logo" src="img/Logo RentG.png" alt="" style="max-width: 35%">
            </a>
        </header>
        <nav id="menuprincipal">
            <div>
                <ul>
                    <li><a href="inicioSesion.html" id="cerrarsesion">Cerrar Sesion</a></li>
                    <li><a href="inicioLogueado.jsp">Búsqueda</a></li>
                    <li><a href="consultaReservaUsuario.jsp">Consultar Reservas</a></li>
        <%!
               
                private Connection con;
                public void jspInit() {
                   ServletContext application = getServletContext();
                   String IP = application.getInitParameter("IP");
                   String database = application.getInitParameter("BDNombre");
                   String URL = "jdbc:mysql://"+ IP + "/" + database;
                   String userName = application.getInitParameter("usuario");
                   String password = application.getInitParameter("contrasena");
                   con = BD08.getConexion(URL, userName, password);
                };  
             
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
                    <img id="imgusuario" src="img/<%=imagen%>" alt=""  width="80" />
                    
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
                <section id="seccionreserva">
                    <div id="envoltura">
                        <div id="contenedor">
                            <div id="superior" >
                                <img src="img/favicon.png" style="max-width: 8%">
                            </div>

                            <div>
                                <section id="cuerpo">
                                    <label for="ok">RESERVA REALIZADA CORRECTAMENTE</label>
                                    <br><br>
                                    
                                    <label for="coche">Matricula: <%=session.getAttribute("Matricula")%></label>
                                    <br><br>
                                    <label for="fechaI">Fecha Inicio: <%=session.getAttribute("FechaInicio")%></label>
                                    <br>
                                    <label for="horaI">Hora Inicio: <%=session.getAttribute("HoraInicio")%></label>
                                    <br><br>
                                    <label for="fechaF">Fecha Fin: <%=session.getAttribute("FechaFin")%></label>
                                    <br>
                                    <label for="horaF">Hora Fin: <%=session.getAttribute("HoraFin")%></label>
                                    <br><br>
                                    <label for="lugar">Lugar: <%=session.getAttribute("Lugar")%></label>
                                </section>
                            </div>
                            <div id="piereserva">Sistema de Reserva de Coches</div>
                            </section>
                        </div>
                        </main>
                        <footer id="seccionpie">
                            <div>
                                <section class="seccionpie" id="reservapie">
                                    <address>Vitoria, País Vasco</address>
                                    <small>&copy; Derechos Reservados 2018</small>
                                </section>
                            </div>
                        </footer>
                        </body>
                        </html>
