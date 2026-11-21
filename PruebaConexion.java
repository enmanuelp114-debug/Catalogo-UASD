package catalogouasd;

import java.sql.Connection;
import java.sql.SQLException;

public class PruebaConexion {

    public static void main(String[] args) {

        Connection conexion = Conexion.conectar();

        if (conexion != null) {

            System.out.println("Base de datos uasd_catalogo conectada correctamente.");

            try {
                conexion.close();
                System.out.println("Conexion cerrada correctamente.");

            } catch (SQLException e) {
                System.out.println("Error al cerrar: " + e.getMessage());
            }

        } else {
            System.out.println("No se pudo conectar a la base de datos.");
        }
    }
}