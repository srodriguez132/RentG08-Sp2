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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
public class Buscar extends HttpServlet {

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
            out.println("<title>Servlet Buscar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Buscar at " + request.getContextPath() + "</h1>");
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
        String fechaIni = request.getParameter("fechaI");
        SimpleDateFormat formatodate = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date fechaI = null;
        try {
            fechaI = formatodate.parse(fechaIni);
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }
        String horaIni = request.getParameter("horaI");
        java.sql.Time horaI = java.sql.Time.valueOf(horaIni);
        String fechaFina = request.getParameter("fechaF");
        java.util.Date fechaF = null;
        try {
            fechaF = formatodate.parse(fechaFina);
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }
        String horaFina = request.getParameter("horaFina");
        java.sql.Time horaF = java.sql.Time.valueOf(horaFina);

        s.setAttribute("FechaInicio", fechaIni);
        s.setAttribute("HoraInicio", horaI);
        s.setAttribute("FechaFin", fechaFina);
        s.setAttribute("HoraFin", horaF);

        boolean existe = false;
        String mensaje;
        ArrayList<String> coches = new ArrayList<>();
        String matricula;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM coches");
            while (rs.next()) {
                matricula = rs.getString("matricula");
                coches.add(matricula);
                existe = true;
            }
            rs.close();
        } catch (SQLException ex1) {
            System.out.println("No lee de la tabla Coches. " + ex1);
        }

        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM reserva");
            if (rs.next()) {
                existe = true;
            }
        } catch (SQLException ex1) {
            System.out.println("No lee de la tabla Reserva. " + ex1);
        }
        if (existe) {
            try {
                java.sql.Date fechaInicio = rs.getDate("fechainicio");
                java.sql.Time horaInicio = rs.getTime("fechainicio");
                java.sql.Date fechaFin = rs.getDate("fechafin");
                java.sql.Time horaFin = rs.getTime("fechafin");

                boolean borrar = false;
                //Controlar fecha de inicio seleccionada
                if (fechaI.compareTo(fechaInicio) > 0 && fechaI.compareTo(fechaFin) < 0) {
                    borrar = true;
                }
                if (fechaI.compareTo(fechaInicio) == 0 && horaI.compareTo(horaInicio) >= 0) {
                    borrar = true;
                }
                if (fechaI.compareTo(fechaFin) == 0 && horaI.compareTo(horaFin) <= 0) {
                    borrar = true;
                }
                //Controlar fecha de fin seleccionada
                if (fechaF.compareTo(fechaInicio) > 0 && fechaF.compareTo(fechaFin) < 0) {
                    borrar = true;
                }
                if (fechaF.compareTo(fechaInicio) == 0 && horaF.compareTo(horaInicio) >= 0) {
                    borrar = true;
                }
                if (fechaF.compareTo(fechaFin) == 0 && horaF.compareTo(horaFin) <= 0) {
                    borrar = true;
                }

            } catch (SQLException ex) {
                Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                matricula = rs.getString("matricula");
                int j = 0;
                while (j < coches.size()) {
                    String mat = coches.get(j);
                    if (matricula.equals(mat)) {
                        coches.remove(j);
                    }
                    j++;
                }
            } catch (SQLException ex) {
                Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
            }

            int i = 0;
            while (i < coches.size()) {
                String co = coches.get(i);
                System.out.println(co);
                i++;
            }
            if (coches.isEmpty()) {
                mensaje = "No hay coches disponibles para esas fechas";
                request.getRequestDispatcher("/index.html?message=" + mensaje).forward(request, response);
            }
        }
        request.getRequestDispatcher("reserva.html").forward(request, response);
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
