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
                    <li><h1><img src="img/<%=imagen%>" alt="" height="60" width="60"/></h1> </li>
                    
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
                                    <form name="reserva" class="formulario" id="reserva"  onsubmit="return enviarsubmit();">
                                        <label for="coche">Seleccione Coche:</label><br><br>
                                        <label for="coche1">
                                            <img src="img/bmw.png" alt="" />BMW
                                        </label>
                                        <input type="radio" name="coche" value="1111aaa" id="coche1" required  />
                                        <label for="coche2">
                                            <img src="img/citroen.png" alt="" />Citroen
                                        </label>
                                        <input type="radio" name="coche" value="2222bbb" id="coche2" required />
                                        <label for="coche3">
                                            <img src="img/ford.png" alt="" />Ford
                                        </label>
                                        <input type="radio" name="coche" value="3333ccc" id="coche3" required />
                                        <label for="coche4">
                                            <img src="img/mercedes.png" alt="" />Mercedes
                                        </label>
                                        <input type="radio" name="coche" value="4444ddd" id="coche4" required /><br><br><br>
                                        <label for="fechaI">Fecha Inicio:</label>
                                        <input type="date" name="fechaI" id="fechaI" required >
                                        <label for="horaI">Hora Inicio:</label>
                                        <input type="time" name="horaI" id="horaI" required ><br><br><br>
                                        <label for="fechaF">Fecha Fin: </label>
                                        <input type="date" name="fechaF" id="fechaF" required >
                                        <label for="horaF">Hora Fin:</label>
                                        <input type="time" name="horaF" id="horaF" required ><br><br><br>
                                        <label for="lugar">Lugar:</label>
                                        <select name="lugar" id="lugar" required>
                                            <option value="Vitoria-Gasteiz">Vitoria-Gasteiz</option>
                                            <option value="Donostia">Donostia</option>
                                            <option value="Bilbao">Bilbao</option>
                                        </select><br><br>
                                        <button type="submit" id="reservar" class="boton">Reservar</button><br><br>
                                    </form>
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