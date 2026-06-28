package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection myConnection = null;

    // 1. Ambil nilai dari Railway Environment Variables (jika ada)
    private static final String HOST = System.getenv("MYSQLHOST") != null ? System.getenv("MYSQLHOST") : "localhost";
    private static final String PORT = System.getenv("MYSQLPORT") != null ? System.getenv("MYSQLPORT") : "3307";
    private static final String DB_NAME = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "nakhodaptp";
    private static final String USER = System.getenv("MYSQLUSER") != null ? System.getenv("MYSQLUSER") : "root";
    private static final String PASS = System.getenv("MYSQLPASSWORD") != null ? System.getenv("MYSQLPASSWORD") : "";

    // 2. Cantumkan menjadi URL JDBC yang dinamik
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME 
            + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kuala_Lumpur";

    public static Connection getConnection() {
        try {
            if (myConnection == null || myConnection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Log untuk kita semak URL mana yang dia tengah guna (Boleh tengok kat Console Railway nanti)
                System.out.println("🔄 Connecting to DB via URL: jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME);
                
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