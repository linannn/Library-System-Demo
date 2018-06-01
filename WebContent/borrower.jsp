<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link href="css/font-awesome.css" rel="stylesheet">
<link
  href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic'
  rel='stylesheet' type='text/css'>
<script src="layer/layer/layer.js"></script>
<title>Librarian</title>
</head>
<body class="login-bg">
  <div class="login-body">
    <div class="login-heading">
      <h1>Librarian</h1>
    </div>
    <div class="login-info">
      <ul class="nav nav-tabs">
        <li class="active" ><a href="#addBook" data-toggle="tab">AddBook</a></li>
        <li ><a href="#borrowBook"  data-toggle="tab">BorrowBook</a></li>
        <li ><a href="#returnBook"  data-toggle="tab">ReturnBook</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="addBook">
          <form action="actionAddBook.action" method="post" id ="bookForm">
            <input name="userId" value = '<s:property value = "userId"/>' />
            <div class="form-group">
              <label for="inputUserID" class="control-label">ISBN</label> <input
                class="form-control" name="book.ISBN">
            </div>
            <div class="form-group">
              <label for="inputPassword" class="control-label">Title</label>
              <input class="form-control" name="book.title">
            </div>
            <div class="form-group">
              <label for="inputPassword" class="control-label">Quantity</label> <input
                class="form-control" name="book.quantity">
            </div>
            <div class="form-group">
            <table width="100%">
            <tr>
              <td align="left"><label for="inputPassword" class="control-label">Author</label></td>
              <td align="right"><label for="inputPassword" class="control-label" style="text-align:right">
                <a href="javascript:addAuthorLayer();"><i class="fa fa-search nav_icon"></i>Add Author</a>
              </label></td>
              </tr>
             </table>
              <select name = 'book.authors[0].aID' class="form-control">
               <s:iterator value = "authors" var = "authors" status = "sta">
                 <option value ='<s:property value="%{#authors.aID}" />'>
                 <s:property value="%{#authors.firstName}" /> <s:property value="%{#authors.lastName}" />
                 </option>
               </s:iterator>
             </select>
             </div>
             <div class="form-group">
              <table width="100%">
               <tr>
                <td align="left"><label for="inputPassword" class="control-label">Tag</label></td>
                <td align="right"><label for="inputPassword" class="control-label" style="text-align:right">
                          <a href="javascript:addTagLayer();"><i class="fa fa-search nav_icon"></i>Add Tag</a>
                </label></td>
                </tr>
               </table>
             <select name = 'book.tags[0].tagID' class="form-control">
             <s:iterator value = "tags" var = "tags" status = "sta">
               <option value ='<s:property value="%{#tags.tagID}" />'>
               <s:property value="%{#tags.tag}" />
               </option>
             </s:iterator>
             </select>
             </div>
             <div align="center">
              <button type="submit" 
              class="btn  btn-lg btn-primary  hvr-shutter-out-vertical"
                onclick="addBookJson()">Add Book</button>
              </div>
          </form>
        </div>
        
        
        <div class="tab-pane" id="borrowBook">
          
          
        </div>
        
        <div class="tab-pane" id="returnBook">
          
          
        </div>
      </div>
    </div>
  </div>
  
  
<div id="authorLayer" style="display: none">
  <form Class="form-horizontal" theme="simple" method="post"
    id="authorForm" >
    <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
    <table>
      <br>
      <tr class="form-group">
        <td class="col-sm-6">First Name</td>
        <td class="col-sm-6">
          <input type="text" Class="form-control" name="author.firstName"/>
        </td>
      <tr class="form-group">
        <td class="col-sm-6">Last Name</td>
        <td class="col-sm-6">
          <input type="text" Class="form-control" name="author.lastName"/>
        </td>
      </tr>
    </table>
    <br>
    <div class="form-group">
      <div align="center">
        <button type="button"
          class="btn  btn-lg btn-primary  hvr-shutter-out-vertical"
          onclick="jsonAddAuthor()">AddAuthor</button>
      </div>
    </div>
  </form>
</div>
<div id="tagLayer" style="display: none">
  <form Class="form-horizontal" theme="simple" method="post"
    id="tagForm" >
    <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
    <table id="pdo">
      <br>
      <tr class="form-group">
        <td class="col-sm-6">Tag</td>
        <td class="col-sm-6">
          <input type="text" Class="form-control" name="tag.tag"/>
        </td>
    </table>
    <br>
    <div class="form-group">
    <div class="col-sm-offset-1  col-sm-4"></div>
      <div align="center">
        <button type="button"
          class="btn  btn-lg btn-primary  hvr-shutter-out-vertical"
          onclick="addTagJson()">Add Tag</button>
      </div>
    </div>
  </form>
</div>
<script>
function addTagLayer(){
  layer.open({
        type:1,
        title:"Add Author",
        area:['400px','200px'],
              shadeClose:true,
              content:$("#tagLayer")
      });
}
function addAuthorLayer(){
    layer.open({
        type:1,
        title:"Add Author",
        area:['400px','300px'],
              shadeClose:true,
              content:$("#authorLayer")
      });
}
function addBookJson(){
  alert("hello");
    var formData = new FormData(document.getElementById("bookForm"));
      $.ajax({
        type : "post",
        url : 'actionAddBook',
        data : formData,
        async : false,
        cache : false,
        contentType : false,
        processData : false,
        success : function(data){
          var obj = JSON.parse(data);
          layer.open({
                  type: 1,
                  title:"Add Book Message",
                  skin: 'layui-layer-demo',
                  closeBtn: 0,
                  anim: 2,
                  area:['240px','120px'],
                  shadeClose: true,
                  content: obj.result,
                  end:function (){
                    location.reload();
                  }
                });
   
        },
        error : function(e){
          msg="上传失败！";
        }
      });
      get();
}
function addTagJson(){
      var formData = new FormData(document.getElementById("tagForm"));
        $.ajax({
          type : "post",
          url : 'actionAddTag',
          data : formData,
          async : false,
          cache : false,
          contentType : false,
          processData : false,
          success : function(data){
            var obj = JSON.parse(data);
            layer.open({
                    type: 1,
                    title:"Add Tag Message",
                    skin: 'layui-layer-demo',
                    closeBtn: 0,
                    anim: 2,
                    area:['240px','120px'],
                    shadeClose: true,
                    content: obj.result,
                    end:function (){
                      location.reload();
                    }
                  });
     
          },
          error : function(e){
            msg="上传失败！";
          }
        });
        get();
}
function jsonAddAuthor(){
  var formData = new FormData(document.getElementById("authorForm"));
    $.ajax({
      type : "post",
      url : 'actionAddAuthor',
      data : formData,
      async : false,
      cache : false,
      contentType : false,
      processData : false,
      success : function(data){
        var obj = JSON.parse(data);
        layer.open({
                type: 1,
                title:"Add Author Message",
                skin: 'layui-layer-demo',
                closeBtn: 0,
                anim: 2,
                area:['240px','120px'],
                shadeClose: true,
                content: obj.result,
                end:function (){
                  location.reload();
                }
              });
 
      },
      error : function(e){
        msg="上传失败！";
      }
    });
    get();
  }
</script>
<script>
</script>
</body>
</html>