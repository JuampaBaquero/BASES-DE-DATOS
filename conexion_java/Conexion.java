import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Conexion
{
    public void consultarClientes(String genero, int edadMin)
    {
        StringBuilder SQL = new StringBuilder("SELECT nombre");
        //StringBuilder me ayuda a concatenar strings
        SQL.append("FROM clientes AS c");
        SQL.append("WHERE c.cedula = ?");
        SQL.append("AND c.edad > ?");
        
        /*
        También se puede hacer con triple comilla
        """
        ...
            *query épica*
        ...
        """
        */
        try(
            Connection conector = DriverManager.getConnection(
                Constantes.RUTA_CONEXION,
                Constantes.USERNAME,
                Constantes.PASSWORD
            );
            PreparedStatement ps = conector.prepareStatement(SQL.toString());
            ResultSet rs = ps.executeQuery();
        ){
            while(rs.next())
            {
                System.out.println("Nombre: " + rs.getString("nombre"));
                //Acá depende lo que uses, por ejemplo double getBigDecimal()
            }
        }
        catch(SQLException e){
            System.out.println("Error al conectar: " + e.toString());
            e.printStackTrace();
        }
    }
}