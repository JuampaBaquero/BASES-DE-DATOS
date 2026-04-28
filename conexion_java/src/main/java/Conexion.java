//Esto es para que tenga lo del .env
import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Conexion
{
    public void consultarClientes(String genero, int edadMin)
    {
        System.out.println("Intentando conectar. . .");
        Dotenv dotenv = Dotenv.load();
        StringBuilder SQL = new StringBuilder("SELECT nombre");
        //StringBuilder me ayuda a concatenar strings
        SQL.append(" FROM cliente c");
        SQL.append(" WHERE c.genero = ?");
        SQL.append(" AND c.edad >= ?");
        
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
                //USAR UN .ENV
                dotenv.get("DB_PATH"),
                dotenv.get("DB_USUARIO"),
                dotenv.get("DB_CONTRASENA")
            );
            PreparedStatement ps = conector.prepareStatement(SQL.toString());
        ){
            ps.setString(1, genero);
            ps.setInt(2, edadMin);
            try(ResultSet rs = ps.executeQuery();)
            {
                while(rs.next())
                {
                    System.out.println("Nombre: " + rs.getString("nombre"));
                    //Acá depende lo que uses, por ejemplo double getBigDecimal()
                }
            }
        }
        catch(SQLException e){
            System.out.println("Error al conectar: " + e.toString());
            e.printStackTrace();
        }
    }
}