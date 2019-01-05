/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD08;

/**
 *
 * @author Usuario
 */
@WebServlet(name = "Total", urlPatterns = {"/Total"})
public class Total extends HttpServlet {

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
            out.println("<title>Servlet Total</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Total at " + request.getContextPath() + "</h1>");
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
        String id1 = request.getParameter("R1");
        String id = id1.substring(0,id1.indexOf("/"));
        java.util.Date fecha = Calendar.getInstance().getTime();
        java.sql.Timestamp dato = new Timestamp(fecha.getTime());
        if ("fechaEntrega".equals(request.getParameter("fechaEntrega"))) {
            try {
                String sql= "update reserva set inicio=? where id=?;" ;
                set=con.prepareStatement(sql);
                set.executeUpdate("update reserva set inicio = '" + dato + "' where id='"+id+"';");
              //  System.out.println("Fecha de entrega actualizada");
            } catch (SQLException ex) {
                Logger.getLogger(Total.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                set=con.createStatement();
                set.executeUpdate("update reserva set fin='" + dato + "'where id='"+id+"';");
               // System.out.println("Fecha de devolución actualizada");
            } catch (SQLException ex) {
                Logger.getLogger(Total.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        try {
        
            rs= set.executeQuery("select * from reserva where id='"+id+"'");
            Timestamp fechaEntrega= rs.getTimestamp("inicio");
            Timestamp fechaDevolucion= rs.getTimestamp("fin");
             long diferencia = fechaDevolucion.getTime() - fechaEntrega.getTime();
             long minutos = TimeUnit.MILLISECONDS.toMinutes(diferencia);
             set.executeUpdate("update reserva set penalizacion= 2*'"+minutos+"'where id '"+id+"'");
             rs.close();
             rs= set.executeQuery("select * from reserva where id='"+id+"'");
             float precio= rs.getFloat("precio");
             float penalizacion= rs.getFloat("penalizacion");
             float total= precio + penalizacion;
             set.executeUpdate("update reserva set total='"+total+"'");
             rs.close();
             set.close();
             
        } catch (SQLException ex) {
            Logger.getLogger(Total.class.getName()).log(Level.SEVERE, null, ex);
        }        
 request.getRequestDispatcher ("consultaReservaRS.jsp").forward(request, response);
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
