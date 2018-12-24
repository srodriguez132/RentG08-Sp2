/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author MCO
 */
public class BD08 {

    // Referencia a un objeto de la interface java.sql.Connection 
    private static Connection con;
        
    public static Connection getConexion(String databaseURL, String user, String password) {
        if (con == null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
               
                con = DriverManager.getConnection(databaseURL, user, password);
                System.out.println("Conexión correcta");
            } catch (ClassNotFoundException ex1) {
                System.out.println("No se ha conectado: " + ex1);
            } catch (SQLException ex2) {
                System.out.println("No se ha conectado:" + ex2);
            }
        }
        return con;
    }
    
     

    public static void destroy() {
        System.out.println("Cerrando conexion...");
        try {
            con.close();
        } catch (SQLException ex) {
            System.out.println("No se pudo cerrar la conexion");
            System.out.println(ex.getMessage());
        }
    }
}
