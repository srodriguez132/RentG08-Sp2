<%-- 
    Document   : prueba
    Created on : 27-dic-2018, 12:36:50
    Author     : Sergio
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.BD08"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
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
                try {
                  
                    Statement set = con.createStatement();
                    ResultSet rs = set.executeQuery("SELECT * FROM Clientes");
                    while (rs.next()) {
                        String nombre = rs.getString("imagen");
                        
            %>                         
            <h3><%=nombre%></h3>
                <%
                        }
                        rs.close();
                        set.close();
                        //con.close();
                    } catch (Exception ex) {
                        System.out.println("Error en acceso a BD Jugadores" + ex);
                    }
                %>
    </body>
</html>
