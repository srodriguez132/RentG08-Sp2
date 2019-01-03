

<%@page import="utils.BD08"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang ="es">
    <head>
        <title>RentG - Reserva</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/css1.css">
        <link rel="stylesheet" href="css/reserva.css">
        <script src="javascript/indexedunido.js"></script>
        <link rel="icon" href="img/favicon.png" sizes="16x16">

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

    </head>
    <body>
        <header class="cabecera" id="cabeceraBusqueda">
            <a id="logo-header" href="#">
                <img src="img/Logo RentG.png" alt="" style="max-width: 35%">
            </a>
        </header>
        <nav id="menuprincipal">
            <div>
                <ul>
                    <li><a href="index.html">Principal</a></li>
                    <li><a href="registro.html">Registrarse</a></li>
                    <li><a href="inicioSesion.html">Iniciar sesi�n</a></li>
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
                                    <form action="Reservar" name="reserva" class="formulario" id="reserva" onsubmit="return enviarsubmit();">
                                        <table>
                                            <thead><tr><th></th><th>Coche</th><th>Marca</th><th>Seleccionar</th></tr></thead>
                                            <tbody id="datosTabla">
                                                <%
                                                    try {
                                                        String imagen;
                                                        String marca;
                                                        String numCoches = session.getAttribute("NumCoches").toString();
                                                        int num = Integer.parseInt(numCoches);
                                                        int i = 0;
                                                        ArrayList<String> matriculas = new ArrayList<>();
                                                        String coche = "Coche";
                                                        while (i <= num) {
                                                            coche = coche + i;
                                                            matriculas.add(session.getAttribute(coche).toString());
                                                            coche = coche.substring(0, 5);
                                                            i++;
                                                        }
                                                        int cont = 0;
                                                        while (cont <= num) {
                                                            String matricula = matriculas.get(cont);
                                                            Statement set = con.createStatement();
                                                            ResultSet rs = set.executeQuery("SELECT * from coches WHERE matricula = '" + matricula + "'");
                                                            

                                                            imagen = rs.getString("imagen");
                                                            marca = rs.getString("marca");


                                                %>                         

                                                <tr> <td><input type="radio" id="seleccionCoche" name="R1" value="<%=matricula%>"/></td> <td><img src="img/bmw.png" alt="" /></td><td><%=marca%></td></tr>


                                                <%
                                                            rs.close();
                                                            set.close();
                                                        }
                                                    } //con.close();
                                                    catch (Exception ex) {
                                                        System.out.println("Error en acceso a BD" + ex);
                                                    }
                                                %>







                                            </tbody>

                                            </div> 
                                        </table>
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
                                        <label for="fechaI">Fecha Inicio: <%=session.getAttribute("FechaInicio")%></label>
                                        <br>
                                        <label for="horaI">Hora Inicio: <%=session.getAttribute("HoraInicio")%></label>
                                        <br><br>
                                        <label for="fechaF">Fecha Fin: <%=session.getAttribute("FechaFin")%></label>
                                        <br>
                                        <label for="horaF">Hora Fin: <%=session.getAttribute("HoraFin")%></label>
                                        <br><br>
                                        <label for="lugar">Lugar: <%=session.getAttribute("Lugar")%></label>
                                        <br><br>
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
                                    <address>Vitoria, Pa�s Vasco</address>
                                    <small>&copy; Derechos Reservados 2018</small>
                                </section>
                            </div>
                        </footer>
                        </body>
                        </html>