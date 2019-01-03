/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Array;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Vector;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD08;

/**
 *
 * @author Grupo 08
 */
public class LoginReserva extends HttpServlet {

    private Connection con;
    private Statement set;
    private ResultSet rs;
    String cad;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        ServletContext contexto = cfg.getServletContext();

        String IP = contexto.getInitParameter("IP");
        String basedatos = contexto.getInitParameter("BDNombre");
        String URL = "jdbc:mysql://" + IP + "/" + basedatos;

        String nombreUsuario = contexto.getInitParameter("usuario");
        String contrasena = contexto.getInitParameter("contrasena");

        con = BD08.getConexion(URL, nombreUsuario, contrasena);
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //response.sendRedirect("index.jsp?message="+mensaje);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession s = request.getSession(true);
        String email = request.getParameter("email");
        String contra = request.getParameter("contrasena");
        s.setAttribute("emailUsuario", email);

        String datoSesion = (String) s.getAttribute("emailUsuario");

        boolean existe = false;
        String pass = null;
        String mensaje = null;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM Clientes where email ='" + email + "'");
            if (rs.next()) {
                existe = true;
                pass = rs.getString("contraseña");
            } else {
                existe = false;
            }
            rs.close();
            set.close();
        } catch (SQLException ex1) {
            System.out.println("No lee de la tabla Clientes. " + ex1);
        }
        if (existe == true) {
            if (pass.equals(contra)) {
                s.setAttribute("Email", email);
                s.setAttribute("Contrasena", contra);
                int id = (int) (Math.random() * 999999999) + 1;
                String matricula = s.getAttribute("Matricula").toString();
                String fechaI = s.getAttribute("FechaInicio").toString();
                String horaI = s.getAttribute("HoraInicio").toString();
                String fechaF = s.getAttribute("FechaFin").toString();
                String horaF = s.getAttribute("HoraFin").toString();
                String fechaHoraIni = fechaI + " " + horaI;
                String fechaHoraFin = fechaF + " " + horaF;
                float precio = 0;

                try {
                    set = con.createStatement();
                    set.executeUpdate("INSERT INTO reserva (id, email, matricula, precio, fechainicio, fechafin)"
                            + " VALUES ('" + id + "', '" + email + "', '" + matricula + "', '" + precio + "', '" + fechaHoraIni + "'"
                            + ",'" + fechaHoraFin + "' )");
                    set.close();
                    Statement set2 = con.createStatement();
                    rs = set2.executeQuery("Select * from reserva where id LIKE '%" + id + "%'");
                    rs.next();
                    java.sql.Timestamp fechaInicio = rs.getTimestamp("fechainicio");
                    java.sql.Timestamp fechaFin = rs.getTimestamp("fechafin");

                    java.util.Date fecha = Calendar.getInstance().getTime();

                    long diferencia = fechaFin.getTime() - fechaInicio.getTime();

                    long horas = TimeUnit.MILLISECONDS.toHours(diferencia);
                    precio = horas * 10;
                    rs.close();
                    set2.close();
                    Statement st3 = con.createStatement();
                    st3.executeUpdate("update reserva set precio = '" + precio + "' where id LIKE '%" + id + "%'");
                    st3.close();
                    request.getRequestDispatcher("ReservaOk.jsp").forward(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(ReservaLogueada.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.getRequestDispatcher("/ReservaOk.jsp").forward(request, response);

            } else {
                mensaje = "La contrasena es incorrecta";
                request.getRequestDispatcher("/LoginReserva.jsp?message=" + mensaje).forward(request, response);
            }
        } else {
            mensaje = "El email es incorrecto";
            request.getRequestDispatcher("/LoginReserva.jsp?message=" + mensaje).forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
