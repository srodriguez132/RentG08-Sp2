/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.nio.file.Paths;
import java.sql.Connection;
import static java.sql.JDBCType.VARCHAR;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import utils.BD08;

/**
 *
 * @author Grupo 08
 */
@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
@MultipartConfig
public class Registro extends HttpServlet {

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
            out.println("<title>Servlet Registro</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Registro at " + request.getContextPath() + "</h1>");
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

        String email = (String) request.getParameter("email");
        String contra = (String) request.getParameter("contrasena");
        String nombre = (String) request.getParameter("nombre");
        String apellido = (String) request.getParameter("apellido");
        String movil = (String) request.getParameter("movil");
//        String imagen = (String) request.getParameter("imagen");
//        File imagen = new File("/img");
//        imagen = (File) request.getAttribute("imagen");

          Part part = request.getPart("imagen");
          String fileName = extractFileName(part);
          String ruta = "C:\\Users\\kurri\\Desktop" + File.separator + fileName;
          File fileSaveDir = new File(ruta);
          part.write(ruta + File.separator);
          
          String imagen = ruta;


// Retrieves <input type="file" name="file">
//        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
//        InputStream fileContent = filePart.getInputStream();
        try {
            boolean existe;
            set = con.createStatement();
            rs = set.executeQuery("SELECT * from clientes where email LIKE '%" + email + "%'");

            if (rs.next()) {
                existe = true;

                String mensaje = "Email en uso. Seleccione otro.";
                request.getRequestDispatcher("/registro.jsp?message=" + mensaje).forward(request, response);
                rs.close();
                set.close();

            } else {
                existe = false;
                rs.close();
                set.executeUpdate("INSERT INTO Clientes (email, contraseña, nombre, apellido, movil, imagen)"
                        + " VALUES ('" + email + "', '" + contra + "', '" + nombre + "', '" + apellido + "'"
                        + ",'" + movil + "','" + imagen + "' )");
                set.close();
                request.getRequestDispatcher("inicioSesion.jsp").forward(request, response);

            }

        } catch (SQLException e) {
            System.out.println("Error" + e);
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

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for(String s : items){
            if(s.trim().startsWith("filename")){
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }


}
