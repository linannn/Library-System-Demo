package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DBConn;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

import model.Author;

public class AuthorService {
  public int addAuther(Author author) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    try {
      conn = DBConn.getConnection();
      String sql = "insert into author values(null,?,?)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, author.getFirstName());
      pst.setString(2, author.getLastName());
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

  public List<Author> getAllAuthor(){
    String sql = "select * from author";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    List<Author> authors = new ArrayList<Author>();
    try {
      pst = conn.prepareStatement(sql);
      ResultSet rs = pst.executeQuery();
      while (rs.next()) {
        Author author = new Author();
        author.setaID(rs.getString(1));
        author.setFirstName(rs.getString(2));
        author.setLastName(rs.getString(3));
        authors.add(author);
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
    return authors;
  }

  public List<Author> getAuthorByISBN(String ISBN){
    String sql = "select * from is_author where ISBN = ?";
    String sqlName = "select * from author where aID = ?";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    PreparedStatement pstName = null;
    List<Author> authors = new ArrayList<Author>();
    Author author = new Author();
    try {
      pst = conn.prepareStatement(sql);
      pst.setString(1, ISBN);
      ResultSet rs = pst.executeQuery();
      while (rs.next()) {
        pstName = conn.prepareStatement(sqlName);
        pstName.setString(1, rs.getString(1));
        ResultSet rsName = pst.executeQuery();
        while (rsName.next()) {
          author.setaID(rsName.getString(1));
          author.setFirstName(rsName.getString(2));;
          author.setLastName(rsName.getString(3));
          authors.add(author);
        }
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
    return authors;
  }
}
