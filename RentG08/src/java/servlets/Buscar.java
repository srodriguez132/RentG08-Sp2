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
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
        String mensaje;
        String lugar = request.getParameter("lugar");
        HttpSession s = request.getSession(true);

        //Fecha inicio deseada
        String fechaIni = request.getParameter("fechaI");
        SimpleDateFormat formatodate = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date fechaInic;
        java.sql.Date fechaI = null;
        try {
            fechaInic = formatodate.parse(fechaIni);
            fechaI = new java.sql.Date(fechaInic.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }

        //Hora inicio deseada
        String horaIni = request.getParameter("horaI");
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        long horaInic;
        Time horaI = null;
        try {
            horaInic = sdf.parse(horaIni).getTime();
            horaI = new Time(horaInic);
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }

        //Fecha final deseada
        String fechaFina = request.getParameter("fechaF");
        java.util.Date fechaFinal;
        java.sql.Date fechaF = null;
        try {
            fechaFinal = formatodate.parse(fechaFina);
            fechaF = new java.sql.Date(fechaFinal.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }

        //Hora final deseada
        String horaFina = request.getParameter("horaF");
        long horaFinal;
        Time horaF = null;
        try {
            horaFinal = sdf.parse(horaFina).getTime();
            horaF = new Time(horaFinal);
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }

        java.util.Date fecha = Calendar.getInstance().getTime();
        java.util.Date fechaActual;
        
        try {
            fechaActual = formatodate.parse(formatodate.format(fecha));
            long horaAct = sdf.parse(horaFina).getTime();
            Time horaActual = new Time(horaAct);

            if (fechaI.compareTo(fechaActual) < 0) {
                mensaje = "La fecha de inicio debe ser mayor a la actual";
                request.getRequestDispatcher("/index.jsp?message=" + mensaje).forward(request, response);
            }

            if (fechaI.compareTo(fechaActual) == 0 && horaI.compareTo(horaActual) < 0) {
                mensaje = "La hora de inicio debe ser mayor a la actual";
                request.getRequestDispatcher("/index.jsp?message=" + mensaje).forward(request, response);
            }
            if (fechaI.compareTo(fechaF) > 0) {
                mensaje = "La fecha de fin debe ser mayor que la fecha de inicio";
                request.getRequestDispatcher("/index.jsp?message=" + mensaje).forward(request, response);
            }
            if (fechaI.compareTo(fechaF) == 0 && horaI.compareTo(horaF) > 0) {
                mensaje = "La hora de fin debe ser mayor que la hora de inicio";
                request.getRequestDispatcher("/index.jsp?message=" + mensaje).forward(request, response);
            }
        } catch (ParseException ex) {
            Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean existe = false;
        boolean borrar = false;
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
            while (rs.next()) {
                borrar = false;
                try {
                    java.sql.Date fechaInicio = rs.getDate("fechainicio");
                    java.sql.Time horaInicio = rs.getTime("fechainicio");
                    java.sql.Date fechaFin = rs.getDate("fechafin");
                    java.sql.Time horaFin = rs.getTime("fechafin");

                    //Controlar fecha de inicio seleccionada
                    //Entra si la fecha seleccionada esta entre alguna fecha de inicio y fin ya registrada
                    if (fechaI.compareTo(fechaInicio) > 0 && fechaI.compareTo(fechaFin) < 0) {
                        borrar = true;
                    }
                    //Entra si la fecha seleccionada es igual a la fecha de inicio y despues de alguna hora registrada
                    if (fechaI.compareTo(fechaInicio) == 0 && horaI.compareTo(horaInicio) >= 0) {
                        borrar = true;
                    }
                    //Entra si la fecha seleccionada es igual a la fecha de fin y antes de de alguna hora registrada
                    if (fechaI.compareTo(fechaFin) == 0 && horaI.compareTo(horaFin) <= 0) {
                        borrar = true;
                    }
                    //Controlar fecha de fin seleccionada
                    //Entra si la fecha seleccionada esta entre alguna fecha de inicio y fin ya registrada
                    if (fechaF.compareTo(fechaInicio) > 0 && fechaF.compareTo(fechaFin) < 0) {
                        borrar = true;
                    }
                    //Entra si la fecha seleccionada es igual a la fecha de inicio y despues de alguna hora registrada
                    if (fechaF.compareTo(fechaInicio) == 0 && horaF.compareTo(horaInicio) >= 0) {
                        borrar = true;
                    }
                    //Entra si la fecha seleccionada es igual a la fecha de fin y antes de de alguna hora registrada
                    if (fechaF.compareTo(fechaFin) == 0 && horaF.compareTo(horaFin) <= 0) {
                        borrar = true;
                    }

                    //Controlar fecha de inicio y fin seleccionada
                    if (fechaI.compareTo(fechaInicio) < 0 && fechaF.compareTo(fechaFin) > 0) {
                        borrar = true;
                    }

                } catch (SQLException ex) {
                    Logger.getLogger(Buscar.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (borrar == true) {
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
                }
            }
        } catch (SQLException ex1) {
            System.out.println("No lee de la tabla Reserva. " + ex1);
        }

        int i = 0;
        while (i < coches.size()) {
            String co = coches.get(i);
            System.out.println(co);
            i++;
        }
        if (coches.isEmpty()) {
            mensaje = "No hay coches disponibles para esas fechas";
            request.getRequestDispatcher("/index.jsp?message=" + mensaje).forward(request, response);
        }

        s.setAttribute("FechaInicio", fechaIni);
        s.setAttribute("HoraInicio", horaI);
        s.setAttribute("FechaFin", fechaFina);
        s.setAttribute("HoraFin", horaF);
        s.setAttribute("Lugar", lugar);

        String fechaHoraI = fechaI + " " + horaI + ".000000";
        String fechaHoraF = fechaF + " " + horaF + ".000000";
        java.sql.Timestamp fechaInicio = Timestamp.valueOf(fechaHoraI);
        java.sql.Timestamp fechaFin = Timestamp.valueOf(fechaHoraF);
        long diferencia = fechaFin.getTime() - fechaInicio.getTime();
        long horas = TimeUnit.MILLISECONDS.toHours(diferencia);
        float precio = horas * 10;
        s.setAttribute("Precio", precio);

        int num = 0;
        String coche = "Coche";
        while (num < coches.size()) {
            coche = coche + num;
            String coch = coches.get(num);
            System.out.println(coche);
            s.setAttribute(coche, coch);
            coche = coche.substring(0, 5);
            num++;
        }
        num = num - 1;
        //Numero de coches empieza en 0
        s.setAttribute("NumCoches", num);
        request.getRequestDispatcher("reserva.jsp").forward(request, response);
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
