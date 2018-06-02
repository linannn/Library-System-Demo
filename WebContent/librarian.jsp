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
  <div class="login-body" style="width:70%">
    <div class="login-heading">
      <h1>Librarian</h1>
    </div>
    <div class="login-info">
      <ul class="nav nav-tabs">
        <li class="active" ><a href="#addBook" data-toggle="tab">Add Book</a></li>
        <li ><a href="#borrowBook"  data-toggle="tab">Borrow Book</a></li>
        <li ><a href="#returnBook"  data-toggle="tab">Return Book</a></li>
        <li ><a href="#queryBook" data-toggle="tab">Query Book</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="addBook">
          <form action = "actionAddBook.action" method="post" id ="bookForm">
          <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
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
             <div class="form-group">
              <label for="inputPassword" class="control-label">Location</label> <input
                class="form-control" name="location">
            </div>
            <div class="form-group">
              <label for="inputPassword" class="control-label">Number</label> <input
                class="form-control" name="bookNumb">
            </div>
             <div align="center">
             <input type="submit" value="Add Book">
             <!-- 
              <button type="submit" 
              class="btn  btn-lg btn-primary  hvr-shutter-out-vertical"
                onclick="addBookJson()">Add Book</button>
                 -->
              </div>
          </form>
        </div>
        
        
        <div class="tab-pane" id="borrowBook">
         <form action="actionBorrowBook.action" method="post" id ="borrowBookForm">
          <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
            <div class="form-group">
              <label for="inputUserID" class="control-label">borrowerID</label> <input
                class="form-control" name="borrowerID">
            </div>
            <div class="form-group">
              <label for="inputPassword" class="control-label">BookID</label>
              <input class="form-control" name="bookID">
             </div>
            <div align="center">
              <input type="submit" value="Borrow">
            </div>
          </form>
        </div>
        
        <div class="tab-pane" id="returnBook">
          <form action="actionReturnBook.action" method="post">
          <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
            <div class="form-group">
              <label for="inputUserID" class="control-label">borrowerID</label> <input
                class="form-control" name="borrowerID">
            </div>
            <div class="form-group">
              <label for="inputPassword" class="control-label">BookID</label>
              <input class="form-control" name="bookID">
             </div>
            <div align="center">
              <input type="submit" value="Return">
            </div>
          </form>
          
        </div>
        <div class="tab-pane" id="queryBook">
        <div>
        <form method="post" class="table" id = "queryForm">
           <div class="form-group">
              <div class="col-sm-2">
               <s:select class="form-control"
                list="#{'title':'Title', 'ISBN':'ISBN'}" 
                name="msg" 
                value="Title" />
              </div>
              <div class="col-sm-4">
                <input name = "info"  class="form-control">
               </div>
               <div class="col-sm-3">
               <button type="button" class="btn btn-default" onclick="queryBook()">
                 Search
               </button>
              </div>
            </div>
          </form>
          </div>
          <div>
          <br><br><br>
            <h3 id = "resultH"></h3>
            <table class="table table-striped" id = "queryResultTable">
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  
<div id="authorLayer" style="display: none">
  <form action = "actionAddAuthor.action" Class="form-horizontal" theme="simple" method="post"
    id="authorForm" >
    <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
    <br>
    <table>
      
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
        <input type="submit" class="btn  btn-lg btn-primary  hvr-shutter-out-vertical" value="Add Author">
      </div>
    </div>
  </form>
</div>
<div id="tagLayer" style="display: none">
  <form action = "actionAddTag.action" Class="form-horizontal" theme="simple" method="post"
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
      <div align="center">
        <input type="submit" class="btn  btn-lg btn-primary  hvr-shutter-out-vertical" value="Add Tag">
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
function queryBook(){
	$("#queryResultTable").empty();
	$("#resultH").empty();
  var formData = new FormData(document.getElementById("queryForm"));
  $.ajax({
		type : "post",
		url : "actionQueryBook",
		data : formData,
		async : false,
		cache : false,
		contentType : false,
		processData : false,
		success : function(data){
		 var obj = JSON.parse(data);
		 if (obj.result.length == 0){
			 alert("no result");
		 }
		 else{
			 $("#resultH").append("Result:");
			  var tableTitle = "<thead><tr><th>Title</th><th>ISBN</th><th>Quantity</th>"+
				"<th>Author</th><th>Tag</th></tr></thead>";
				$("#queryResultTable").append(tableTitle);
				obj.result.forEach(function(book){
					var bookItem = "<tr><td>"+book.title+"</td><td>"+book.ISBN+"</td><td>"+book.quantity+"</td><td>";
					var j, len;
					for(j = 0, len=book.authors.length; j < len; j++) {
						  bookItem = bookItem + book.authors[j].firstName + " "+ book.authors[j].lastName;
					}
					bookItem = bookItem + "</td><td>";
					for(j = 0, len=book.tags.length; j < len; j++) {
						  bookItem = bookItem + book.tags[j].tag + " ";
					}
					bookItem = bookItem + "</td></tr>";
					$("#queryResultTable").append(bookItem);
					});
		  }
		},
		error : function(e){
		    alert("上传失败！");
		  }
		});
}


/*

var showPlaceStr='${queryP}';
var showPlace = eval('(' + showPlaceStr + ')');
$.each(showPlace,function(place,pdo){
      AMap.service('AMap.Geocoder',function(){//回调函数
          geocoder = new AMap.Geocoder({
          });
      geocoder.getLocation(place, function (status, result) {
        alert
          if (status == 'complete' && result.geocodes.length) {
                  //marker.setPosition(result.geocodes[0].location);
                  var ss=result.geocodes[0].location
                  var marker = new AMap.Marker({
                      position: ss,
                      map: mapShowAll
                  });
              }
        });
      })
});


*/

</script>
</body>
</html>