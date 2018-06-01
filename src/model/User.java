package model;

public class User {
  private String ID;
  private String name;
  private String passwd;
  private String registerData;
  private String email;
  private int limit;
  private int credit;
  private String userTag;
  
  public String getID() {
    return ID;
  }
  public void setID(String iD) {
    ID = iD;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getRegisterData() {
    return registerData;
  }
  public void setRegisterData(String registerData) {
    this.registerData = registerData;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public int getLimit() {
    return limit;
  }
  public String getUserTag() {
    return userTag;
  }
  public void setUserTag(String userTag) {
    this.userTag = userTag;
  }
  public void setLimit(int limit) {
    this.limit = limit;
  }
  public int getCredit() {
    return credit;
  }
  public void setCredit(int credit) {
    this.credit = credit;
  }
  
}
