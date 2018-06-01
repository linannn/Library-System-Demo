package service;
  
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.Date;
import java.text.SimpleDateFormat;

import model.User;
import database.DBConn;

public class UserService {
  public int borrowerRegister(User user) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd");
    try {
      conn = DBConn.getConnection();
      String sql = "insert into borrower values(?,?,?,?,?,?,?)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, user.getID());
      pst.setString(2, user.getName());
      pst.setString(3, user.getPasswd());
      pst.setString(4, data.format(new Date()));
      pst.setString(5, user.getEmail());
      pst.setInt(6, 10);
      pst.setInt(7, 50);
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    return res;
  }
  
  public int librarianRegister(User user) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    try {
      conn = DBConn.getConnection();
      String sql = "insert into librarian values(?,?,?)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, user.getID());
      pst.setString(2, user.getName());
      pst.setString(3, user.getPasswd());
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    return res;
  }
  
  public int login(User user) {
    PreparedStatement pst = null;
    Connection conn = null;
    ResultSet rs = null;
    int res = -1;
    String sql = "";
    if (user.getUserTag().equals("borrower")) {
      sql = "select * from borrower where uID = ? and bPassword = ? limit 1";
    } else {
      sql = "select * from librarian where lID = ? and lPassword = ? limit 1";
    }
    try {
      conn = DBConn.getConnection();
      pst = conn.prepareStatement(sql);
      pst.setString(1, user.getID());
      pst.setString(2, user.getPasswd());
      rs = pst.executeQuery();
      if(rs.next()) {
        res = 1;
      }
      if(conn != null)
        conn.close();
      if(pst != null)
        pst.close();
      if(rs != null)
        rs.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    return res;
  }
}
