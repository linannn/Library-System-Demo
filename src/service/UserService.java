package service;
  
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.Calendar;
import model.User;
import database.DBConn;

public class UserService {
  public int borrowerRegister(User user) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    Calendar cal=Calendar.getInstance(); 
    String date,day,month,year; 
    year =String.valueOf(cal.get(Calendar.YEAR));
    month =String.valueOf(cal.get(Calendar.MONTH)+1); 
    day =String.valueOf(cal.get(Calendar.DATE)); 
    date = year+"-"+month+"-"+day;
    try {
      conn = DBConn.getConnection();
      String sql = "insert into borrower values(?,?,?,?,?,?,?)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, user.getID());
      pst.setString(2, user.getName());
      pst.setString(3, user.getPasswd());
      pst.setString(4, date);
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
  public User getBorrower(String bID) {
    String sql = "select * from borrower where uID = ?";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    User borrower = new User();
    ResultSet rs = null;
    try {
      pst = conn.prepareStatement(sql);
      pst.setString(1, bID);
      rs = pst.executeQuery();
      if (rs.next()) {
        //uID, name, bPassword, register_data, email, limit, credit_value
        borrower.setID(rs.getString(1));
        borrower.setName(rs.getString(2));
        borrower.setRegisterDate(rs.getString(4));
        borrower.setEmail(rs.getString(5));
        System.out.println(rs.getString(4));
        borrower.setLimit(rs.getInt(6));
        borrower.setCredit(rs.getInt(7));
      }
      if(rs != null)
        rs.close();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    } catch(SQLException e) {
      e.printStackTrace();
    }
    return borrower;
  }
}
