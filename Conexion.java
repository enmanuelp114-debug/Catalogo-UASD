package catalogouasd;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    public static Connection conectar() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/uasd_catalogo";
            String usuario = "root";
            String password = "indesifrable";

            Connection conection = DriverManager.getConnection(
                url, usuario, password
            );

            System.out.println("Conexion exitosa");

            return conection;

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
}
