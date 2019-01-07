/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.BD08;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Sergio
 */
@WebServlet(name = "ConsultaUsuario", urlPatterns = {"/ConsultaUsuario"})
public class ConsultaUsuario extends HttpServlet {

    private Connection con;
    private Statement set;
    private ResultSet rs;
    private ResultSet rsc;
    String cad;

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConsultaUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConsultaUsuario at " + request.getContextPath() + "</h1>");
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

        if (request.getParameter("btnConsultaUsuario").equals("vaciar")) {
            request.getRequestDispatcher("consultaReservaUsuario.jsp").forward(request, response);
        } else {

            try {
                String idString = request.getParameter("R1");

                if (!idString.equals("null")) {
                    int id = Integer.parseInt(idString);
                    Statement set2 = con.createStatement();
                    rs = set2.executeQuery("Select * from reserva where id LIKE '%" + id + "%'");
                    rs.next();
                    java.sql.Timestamp fechaInicio = rs.getTimestamp("fechainicio");

                    Date fecha = Calendar.getInstance().getTime();


                    java.sql.Timestamp fechaActual = new Timestamp(fecha.getTime());

                    String estado = rs.getString("estado");

                    long diferencia = fechaInicio.getTime() - fechaActual.getTime();

                    long minutos = TimeUnit.MILLISECONDS.toMinutes(diferencia);
                    long actual = TimeUnit.MILLISECONDS.toHours(fechaActual.getTime());

                    System.out.println("Prueba: " + minutos);
                    System.out.println("Dia y hora de ahora: " + fechaActual.getTime());
                    System.out.println("Dia y hora de ahora: " + fechaInicio.getTime());

                    if (estado.equals("Pendiente") && minutos > 120) {
                        set = con.createStatement();

                        set.executeUpdate("delete from reserva where id LIKE '%" + id + "%'");
//                    set.executeUpdate("Update reserva set estado='Pendiente' where id LIKE '%" + id + "%'");
                        set.close();
                        request.getRequestDispatcher("consultaReservaUsuario.jsp").forward(request, response);
                    } else {
                        String mensaje = "La reserva no se puede cancelar";
                        request.getRequestDispatcher("/consultaReservaUsuario.jsp?message=" + mensaje).forward(request, response);
                    }
                    rs.close();
                    set2.close();
                } else {
                    String mensaje = "Tiene que seleccionar una reserva";
                    request.getRequestDispatcher("/consultaReservaUsuario.jsp?message=" + mensaje).forward(request, response);
                }
            } catch (SQLException ex) {
                System.out.println("No funciona" + ex);
            }
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
