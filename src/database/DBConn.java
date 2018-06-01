package database;

import java.sql.DriverManager;
import java.sql.Connection;

public class DBConn {
  private static Connection connection;
  private static final String driver = "com.mysql.jdbc.Driver";
  private static final String url = "jdbc:mysql://localhost:3306/library";
  private static final String username = "root";
  private static final String password = "123456";
  public static Connection getConnection() {
    try {
      Class.forName(driver);
    }catch (ClassNotFoundException el) {
    }
    try {
      connection =  DriverManager.getConnection(url,username,password);
    }catch (Exception e) {
      e.printStackTrace();
    }
    return connection;
  }
}
