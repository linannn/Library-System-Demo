package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DBConn;
import model.Tag;
public class TagService {
  public int addTag(Tag tag) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    try {
      conn = DBConn.getConnection();
      String sql = "insert into tag values(null,?)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, tag.getTag());
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
  public List<Tag> getAllTag(){
    String sql = "select * from tag";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    List<Tag> tags = new ArrayList<Tag>();
    try {
      pst = conn.prepareStatement(sql);
      ResultSet rs = pst.executeQuery();
      while (rs.next()) {
        Tag tag = new Tag();
        tag.setTagID(rs.getString(1));
        tag.setTag(rs.getString(2));
        tags.add(tag);
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
    return tags;
  }
  public List<Tag> getTagByISBN(String ISBN){
    String sql = "select * from book_tag where book_ISBN = ?";
    String sqlName = "select * from tag where tagID = ?";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    PreparedStatement pstName = null;
    List<Tag> tags = new ArrayList<Tag>();
    Tag tag = new Tag();
    try {
      pst = conn.prepareStatement(sql);
      pst.setString(1, ISBN);
      ResultSet rs = pst.executeQuery();
      while (rs.next()) {
        pstName = conn.prepareStatement(sqlName);
        pstName.setString(1, rs.getString(1));
        ResultSet rsName = pstName.executeQuery();
        while (rsName.next()) {
          tag.setTagID(rs.getString(1));
          tag.setTag(rs.getString(2));
          tags.add(tag);
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
    return tags;
  }

}
