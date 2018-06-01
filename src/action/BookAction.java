package action;

import model.Tag;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.*;

import model.Author;
import model.Book;
import model.User;
import service.*;
@SuppressWarnings("serial")
public class BookAction extends ActionSupport {
  private Author author;
  private Tag tag;
  private Book book;
  private List<Author> authors;
  private List<Tag> tags;
  private String returnRes;
  private String userId;
  private String location;
  private int bookNumb;
  private String borrowerID;
  private String bookID;
  private List<Book> borrowedBook;
  private List<Book> borrowingBook;
  private User borrower;
  private AuthorService as = new AuthorService();
  private BookService bs = new BookService();
  private TagService ts = new TagService();
  private UserService us = new UserService();
  public List<Book> getBorrowedBook() {
    return borrowedBook;
  }
  public User getBorrower() {
    return borrower;
  }
  public void setBorrower(User borrower) {
    this.borrower = borrower;
  }
  public void setBorrowedBook(List<Book> borrowedBook) {
    this.borrowedBook = borrowedBook;
  }
  public List<Book> getBorrowingBook() {
    return borrowingBook;
  }
  public void setBorrowingBook(List<Book> borrowingBook) {
    this.borrowingBook = borrowingBook;
  }
  public Author getAuthor() {
    return author;
  }
  public String getBookID() {
    return bookID;
  }
  public void setBookID(String bookID) {
    this.bookID = bookID;
  }
  public String getBorrowerID() {
    return borrowerID;
  }
  public void setBorrowerID(String borrowerID) {
    this.borrowerID = borrowerID;
  }
  public String getLocation() {
    return location;
  }
  public void setLocation(String location) {
    this.location = location;
  }
  public int getBookNumb() {
    return bookNumb;
  }
  public void setBookNumb(int bookNumb) {
    this.bookNumb = bookNumb;
  }
  public String getUserId() {
    return userId;
  }
  public void setUserId(String userId) {
    this.userId = userId;
  }
  public String getReturnRes() {
    return returnRes;
  }
  public void setReturnRes(String returnRes) {
    this.returnRes = returnRes;
  }
  public List<Author> getAuthors() {
    return authors;
  }
  public void setAuthors(List<Author> authors) {
    this.authors = authors;
  }
  public List<Tag> getTags() {
    return tags;
  }
  public void setTags(List<Tag> tags) {
    this.tags = tags;
  }
  public void setAuthor(Author author) {
    this.author = author;
  }
  public Tag getTag() {
    return tag;
  }
  public void setTag(Tag tag) {
    this.tag = tag;
  }
  public Book getBook() {
    return book;
  }
  public void setBook(Book book) {
    this.book = book;
  }
  
  public String addAuthor() {
    int res = as.addAuther(author);
    Map<String, String> map = new HashMap<String,String>();
    if(res == -1) {
      map.put("result", "Add Author Failed");
    }
    else {
      map.put("result", "Add Author Succeed");
    }
    returnRes = JSONObject.fromObject(map).toString();
    return SUCCESS;
  }
  public String addTag() {
    int res = ts.addTag(tag);
    Map<String, String> map = new HashMap<String,String>();
    if(res == -1) {
      map.put("result", "Add Tag Failed");
    }
    else {
      map.put("result", "Add Tag Succeed");
    }
    returnRes = JSONObject.fromObject(map).toString();
    return SUCCESS;
  }
  public String addBook() {
    int res = bs.addBook(book);
    int resCopy = bs.addBookCopy(book.getISBN(), location, bookNumb);
    if(res == -1 || resCopy == -1) {
      return "error";
    }
    return SUCCESS;
  }
  public String librarianHome() {
    authors = as.getAllAuthor();
    tags = ts.getAllTag();
    return SUCCESS;
  }
  public String borrowBook() {
    int res = bs.borrowBook(borrowerID, userId, bookID);
    if(res == -1) {
      return "error";
    }
    return SUCCESS;
  }
  public String returnBook() {
    int res = bs.returnBook(borrowerID, userId, bookID);
    if(res == -1) {
      return "error";
    }
    return SUCCESS;
  }
  public String borrowerHome() {
    borrower = us.getBorrower(userId);
    borrowedBook = bs.getBorrowedBook(userId);
    System.out.println(borrowedBook.size());
    borrowingBook = bs.getBorrowingBook(userId);
    return SUCCESS;
  }
  public String renewBook() {
    int res = bs.renewBook(borrowerID, bookID);
    Map<String, String> map = new HashMap<String,String>();
    if(res == -1) {
      map.put("result", "Add Tag Failed");
    }
    else {
      map.put("result", "Add Tag Succeed");
    }
    returnRes = JSONObject.fromObject(map).toString();
    return SUCCESS;
  }
}
