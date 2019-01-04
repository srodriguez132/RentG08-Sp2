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
import java.text.ParseException;
import java.util.Calendar;
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
 * @author kurri
 */
public class ReservaLogueada extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReservaLogueada</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservaLogueada at " + request.getContextPath() + "</h1>");
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
        int id = (int) (Math.random() * 999999999) + 1;
        String email = s.getAttribute("emailUsuario").toString();
        String matricula = request.getParameter("coche");
        String fechaI = s.getAttribute("FechaInicio").toString();
        String horaI = s.getAttribute("HoraInicio").toString();
        String fechaF = s.getAttribute("FechaFin").toString();
        String horaF = s.getAttribute("HoraFin").toString();
        String lugar = s.getAttribute("Lugar").toString();
        String fechaHoraIni = fechaI + " " + horaI;
        String fechaHoraFin = fechaF + " " + horaF;
        s.setAttribute("Matricula", matricula);
        String precio = s.getAttribute("Precio").toString();

        try {
            set = con.createStatement();
            set.executeUpdate("INSERT INTO reserva (id, email, matricula, lugar, precio, fechainicio, fechafin)"
                    + " VALUES ('" + id + "', '" + email + "', '" + matricula + "', '" + lugar + "', '" + precio + "', '" + fechaHoraIni + "'"
                    + ",'" + fechaHoraFin + "' )");
            set.close();
            request.getRequestDispatcher("ReservaOk.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ReservaLogueada.class.getName()).log(Level.SEVERE, null, ex);
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
