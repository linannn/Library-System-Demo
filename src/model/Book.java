package model;

import java.util.List;

public class Book {
  private List<Author> authors;
  private String ISBN;
  private String title;
  private String quantity;
  private List<Tag> tags;
  public String getISBN() {
    return ISBN;
  }
  public void setISBN(String iSBN) {
    ISBN = iSBN;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getQuantity() {
    return quantity;
  }
  public void setQuantity(String quantity) {
    this.quantity = quantity;
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
}
