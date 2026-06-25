package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection myConnection = null;

    private static final String URL =
        "jdbc:mysql://localhost:3307/nakhodaptp?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kuala_Lumpur";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() {
        try {
            if (myConnection == null || myConnection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                myConnection = DriverManager.getConnection(URL, USER, PASS);
                System.out.println("✅ DB connected successfully");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("❌ DB CONNECTION FAILED: " + e.getMessage());
            e.printStackTrace();
        }
        return myConnection;
    }
}
