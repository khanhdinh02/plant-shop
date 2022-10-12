package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    public static Connection makeConnection() throws Exception {
        Connection connection = null;
        String user = "sa";
        String pass = "12345";
        String connString = "jdbc:sqlserver://localhost:1433;databaseName=PlantShop";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        connection = DriverManager.getConnection(connString, user, pass);

        return connection;
    }
}
