package model;

public class BorrowInfo {
  private String lID;
  private String uID;
  private String ISBN;
  private String bID;
  private String startData;
  private String lastData;
  private Boolean renewed;
  private int fine;
  public String getlID() {
    return lID;
  }
  public void setlID(String lID) {
    this.lID = lID;
  }
  public String getuID() {
    return uID;
  }
  public void setuID(String uID) {
    this.uID = uID;
  }
  public String getISBN() {
    return ISBN;
  }
  public void setISBN(String iSBN) {
    ISBN = iSBN;
  }
  public String getbID() {
    return bID;
  }
  public void setbID(String bID) {
    this.bID = bID;
  }
  public String getStartData() {
    return startData;
  }
  public void setStartData(String startData) {
    this.startData = startData;
  }
  public String getLastData() {
    return lastData;
  }
  public void setLastData(String lastData) {
    this.lastData = lastData;
  }
  public Boolean getRenewed() {
    return renewed;
  }
  public void setRenewed(Boolean renewed) {
    this.renewed = renewed;
  }
  public int getFine() {
    return fine;
  }
  public void setFine(int fine) {
    this.fine = fine;
  }
  
}
