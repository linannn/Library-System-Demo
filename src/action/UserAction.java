package action;

import model.User;
import service.UserService;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class UserAction extends ActionSupport {
  private User user = new User();
  private UserService us = new UserService();
  public User getUser() {
    return user;
  }
  public void setUser(User user) {
    this.user = user;
  }
  public UserService getUs() {
    return us;
  }
  public void setUs(UserService us) {
    this.us = us;
  }
  public String register() {
    int res = -1;
    if (user.getUserTag().equals("borrower")) {
      res = us.borrowerRegister(user);
    } else {
      res = us.librarianRegister(user);
    }
    if(res == -1)
      return "error";
    return SUCCESS;
  }
  public String login() {
    System.out.println(user.getUserTag());
    int res = us.login(user);
    if (res == -1) 
      return "error";
    else {
      if (user.getUserTag().equals("borrower"))
        return "borrower";
      return "librarian";
    }
  }
}
