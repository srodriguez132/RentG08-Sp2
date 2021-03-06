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
@WebServlet(name = "LoginAdmin", urlPatterns = {"/LoginAdmin"})
public class LoginAdmin extends HttpServlet {

    private Connection con;
    private Statement set;
    private ResultSet rs;
    String cad;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        ServletContext contexto = cfg.getServletContext();

        String IP = contexto.getInitParameter("IP");
        String database = contexto.getInitParameter("BDNombre");
        String URL = "jdbc:mysql://" + IP + "/" + database;

        String userName = contexto.getInitParameter("usuario");
        String password = contexto.getInitParameter("contrasena");

        con = BD08.getConexion(URL, userName, password);
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
            out.println("<title>Servlet LoginAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginAdmin at " + request.getContextPath() + "</h1>");
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
        String usuario = request.getParameter("usuario");
        String contra = request.getParameter("contrasena");

        boolean existe = false;
        String pass = null;
        String mensaje = null;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM responsable where usuario ='" + usuario + "'");
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
                s.setAttribute("Usuario", usuario);
                s.setAttribute("Contrasena", contra);
                request.getRequestDispatcher("/consultaReservaRS.jsp").forward(request, response);
            } else {
                mensaje = "La contrasena es incorrecta";
                request.getRequestDispatcher("/inicioSesionAdmin.jsp?message=" + mensaje).forward(request, response);
            }
        } else {
            mensaje = "El email es incorrecto";
            request.getRequestDispatcher("/inicioSesionAdmin.jsp?message=" + mensaje).forward(request, response);
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
