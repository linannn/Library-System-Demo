package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

import model.Author;
import model.Book;
import model.Tag;
import database.DBConn;

public class BookService {
  public int addBook(Book book) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    try {
      conn = DBConn.getConnection();
      String sql = "insert into book values(?,?,?)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, book.getISBN());
      pst.setString(2, book.getTitle());
      pst.setString(3, book.getQuantity());
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    try {
      conn = DBConn.getConnection();
      String sql = "insert into is_author values(?,?)";
      Iterator<Author> it = book.getAuthors().iterator();
      while (it.hasNext()) {
        pst = conn.prepareStatement(sql);
        pst.setString(1, it.next().getaID());
        pst.setString(2, book.getISBN());
        res = pst.executeUpdate();
      }
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    try {
      conn = DBConn.getConnection();
      String sql = "insert into book_tag values(?,?)";
      Iterator<Tag> it = book.getTags().iterator();
      while (it.hasNext()) {
        pst = conn.prepareStatement(sql);
        pst.setString(1, book.getISBN());
        pst.setString(2, it.next().getTagID());
        res = pst.executeUpdate() ;
      }
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    return res;
  }
  
  public List<Book> queryBook(String msg, String info) {
    String sql = "select * from book where "+msg+" like ?";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Book> books = new ArrayList<Book>();
    try {
      pst = conn.prepareStatement(sql);
      pst.setString(1, '%'+info+"%");
      rs = pst.executeQuery();
      while (rs.next()) {
        Book book = new Book();
        book.setISBN(rs.getString(1));
        book.setTitle(rs.getString(2));
        book.setQuantity(rs.getString(3));
        book.setAuthors((new AuthorService()).getAuthorByISBN(rs.getString(1)));
        book.setTags((new TagService()).getTagByISBN(rs.getString(1)));
        books.add(book);
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
    return books;
  }
  
  public int addBookCopy(String ISBN, String location, int bookNumb) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    try {
      conn = DBConn.getConnection();
      String sql = "insert into book_copy values(?,null,?,0)";
      pst = conn.prepareStatement(sql);
      pst.setString(1, ISBN);
      pst.setString(2, location);
      for (int i = 0; i < bookNumb; i++) {
        res = pst.executeUpdate();
      }
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    return res;
  }
  public int borrowBook(String borrowID, String lID, String bookID) {
    PreparedStatement pst = null;
    Connection conn = null;
    String ISBN = null;
    int res = -1;
    String sqlBorrow = "insert into borrow values (?,?,?,?,?,null,0,0)";
    ISBN = getISBN(bookID);
    if (ISBN == null) {
      return -1;
    }
    try {
      conn = DBConn.getConnection();
      pst = conn.prepareStatement(sqlBorrow);
      pst.setString(1, borrowID);
      pst.setString(2, lID);
      pst.setString(3, ISBN);
      pst.setString(4, bookID);
      pst.setString(5, getDate());
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    if (res == -1) {
        return -1;
    }
    if (setBorrow(1, bookID) == -1) {
      return -1;
    }
    return 1;
  }
  public int returnBook(String borrowID, String lID, String bookID) {
    PreparedStatement pst = null;
    Connection conn = null;
    String ISBN = null;
    int res = -1;
    String sql = "update borrow set last_time = ? where uID= ? and lID= ? and book_ISBN= ? and book_ID= ?";
    ISBN = getISBN(bookID);
    if (ISBN == null) {
      return -1;
    }
    try {
      conn = DBConn.getConnection();
      pst = conn.prepareStatement(sql);
      pst.setString(1, getDate());
      pst.setString(2, borrowID);
      pst.setString(3, lID);
      pst.setString(4, ISBN);
      pst.setString(5, bookID);
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    if (res == -1) {
        return -1;
    }
    if (setBorrow(0, bookID) == -1) {
      return -1;
    }
    return 1;
  }
  public List<Book> getBorrowedBook(String borrowerID) {
    String sql = "select book_ISBN from borrow where uID = ? and last_time is not null";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Book> books = new ArrayList<Book>();
    try {
      pst = conn.prepareStatement(sql);
      pst.setString(1, borrowerID);
      rs = pst.executeQuery();
      while (rs.next()) {
        books.addAll(queryBook("ISBN", rs.getString(1)));
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
    return books;
  }
  public List<Book> getBorrowingBook(String borrowerID) {
    String sql = "select book_ISBN, book_ID from borrow where uID = ? and last_time is null";
    Connection conn = DBConn.getConnection();
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Book> books = new ArrayList<Book>();
    try {
      pst = conn.prepareStatement(sql);
      pst.setString(1, borrowerID);
      rs = pst.executeQuery();
      while (rs.next()) {
        Book book = queryBook("ISBN", rs.getString(1)).get(0);
        book.setbID(rs.getString(2));
        books.add(book);
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
    return books;
  }
  public int renewBook(String borrowID, String bookID) {
    PreparedStatement pst = null;
    Connection conn = null;
    String ISBN = null;
    int res = -1;
    String sql = "update borrow set renewed = 1 where uID= ? and book_ISBN= ? and book_ID= ?";
    ISBN = getISBN(bookID);
    if (ISBN == null) {
      return -1;
    }
    try {
      conn = DBConn.getConnection();
      pst = conn.prepareStatement(sql);
      pst.setString(1, borrowID);
      pst.setString(2, ISBN);
      pst.setString(3, bookID);
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    if (res == -1) {
        return -1;
    }
    if (setBorrow(0, bookID) == -1) {
      return -1;
    }
    return 1;
  }
  public String getISBN(String bID) {
    PreparedStatement pst = null;
    Connection conn = null;
    ResultSet rs = null;
    String ISBN = null;
    String sql = "select book_ISBN from book_copy where bID = ?";
    try {
      conn = DBConn.getConnection();
      pst = conn.prepareStatement(sql);
      pst.setString(1, bID);
      rs = pst.executeQuery();
      if(rs.next()) {
        ISBN = rs.getString(1);
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
    return ISBN;
  }
  public String getDate() {
    Calendar cal=Calendar.getInstance(); 
    String date,day,month,year; 
    year =String.valueOf(cal.get(Calendar.YEAR));
    month =String.valueOf(cal.get(Calendar.MONTH)+1); 
    day =String.valueOf(cal.get(Calendar.DATE)); 
    date = year+"-"+month+"-"+day;
    return date;
  }
  public int setBorrow(int borrow, String bID) {
    PreparedStatement pst = null;
    Connection conn = null;
    int res = -1;
    String sql = "update book_copy set is_borrowed = ? where bID = ?";
    try {
      conn = DBConn.getConnection();
      pst = conn.prepareStatement(sql);
      pst.setInt(1, borrow);
      pst.setString(2, bID);
      res = pst.executeUpdate();
      if(pst != null)
        pst.close();
      if(conn != null)
        conn.close();
    }catch(SQLException e) {
      e.printStackTrace();
    }
    if (res == -1) {
      return -1;
    }
    return 1;
  }
}
