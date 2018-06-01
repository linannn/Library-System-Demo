<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link href="css/font-awesome.css" rel="stylesheet">
<link
  href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic'
  rel='stylesheet' type='text/css'>
<script src="layer/layer/layer.js"></script>
<title>Borrower</title>
</head>
<body class="login-bg">
  <div class="login-body" style="width:70%">
    <div class="login-heading">
      <h1>Borrower</h1>
    </div>
    <div class="login-info">
      <ul class="nav nav-tabs">
        <li class="active" ><a href="#personalInfo" data-toggle="tab">Personal Info</a></li>
        <li ><a href="#borrowedBook"  data-toggle="tab">Borrowed Book</a></li>
        <li ><a href="#borrowingBook"  data-toggle="tab">Borrowing Book</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="personalInfo">
        <table class="table table-striped" style="width:80%">
			    <tbody>
			    <tr>
			        <td>Name</td>
			        <td><s:property value = "borrower.name"/></td>
			    </tr>
			    <tr>
			        <td>E-mail</td>
			        <td><s:property value = "borrower.email"/></td>
			    </tr>
			    <tr>
			        <td>Register Date</td>
			        <td><s:property value = "borrower.registerDate"/></td>
			    </tr>
			    <tr>
              <td>Limit</td>
              <td><s:property value = "borrower.limit"/></td>
          </tr>
          <tr>
              <td>Credit</td>
              <td><s:property value = "borrower.credit"/></td>
          </tr>
			    </tbody>
			   </table>
        </div>
        
        
        <div class="tab-pane" id="borrowedBook">
					<table class="table table-striped">
					    <thead>
					    <tr>
					        <th>Title</th>
					        <th>ISBN</th>
					        <th>Quantity</th>
					        <th>Author</th>
					        <th>Tag</th>
					    </tr>
					    </thead>
					    <tbody>
					    <s:iterator value = "borrowedBook" var = "book" status = "sta">
						    <tr>
						    <td><s:property value="%{#book.title}" /></td>
						    <td><s:property value="%{#book.ISBN}" /></td>
						    <td><s:property value="%{#book.quantity}" /></td>
						    <td>
							    <s:iterator value="#book.authors" var="author" status="s">
	                  <s:property value="%{#author.firstName}" /> <s:property value="%{#author.lastName}" />
	                </s:iterator>
                </td>
						    <td>
                  <s:iterator value="#book.tags" var="tag" status="s">
                    <s:property value="%{#tag.tag}" />
                  </s:iterator>
						    </td>
						    </tr>
					    </s:iterator>
					    </tbody>
					</table>
        </div>
        
        <div class="tab-pane" id="borrowingBook">
          <table class="table table-striped">
              <thead>
              <tr>
                  <th>Title</th>
                  <th>ISBN</th>
                  <th>Quantity</th>
                  <th>Author</th>
                  <th>Tag</th>
                  <th>Operation</th>
              </tr>
              </thead>
                <s:iterator value = "borrowingBook" var = "book" status = "sta">
                  <tr>
                    <td style="vertical-align: middle"><s:property value="%{#book.title}" /></td>
                    <td style="vertical-align: middle"><s:property value="%{#book.ISBN}" /></td>
                    <td style="vertical-align: middle"><s:property value="%{#book.quantity}" /></td>
                    <td style="vertical-align: middle">
					            <s:iterator value="#book.authors" var="author" status="s">
					              <s:property value="%{#author.firstName}" /> <s:property value="%{#author.lastName}" />
					            </s:iterator>
                    </td>
                    <td style="vertical-align: middle">
					            <s:iterator value="#book.tags" var="tag" status="s">
					              <s:property value="%{#tag.tag}" />
					            </s:iterator>
                    </td>
                    <td style="vertical-align: middle">
				              <form method="post" class="renewForm">
					              <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
					              <input type="hidden" name="borrowerID" value='<s:property value = "userId"/>' />
					              <input type="hidden" name="bookID" value='<s:property value="%{#book.bID}" />' />
					              <div class = "renewButton">
					                <button type="button"
					                class="btn btn-default">
					                 renew
					                </button>
					              </div>
				              </form>
                    </td>
                  </tr>
                </s:iterator>
              <tbody>
              </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

<script>
$(document).ready(function(){
    $('.renewButton').each(function(){
        $(this).click(function(){
          var geneAddData=$(this).parents('.renewForm')[0];
          var formData = new FormData(geneAddData);
             $.ajax({
             type : "post",
             url : 'actionRenewBook',
             data : formData,
             async : false,
             cache : false,
             contentType : false,
             processData : false,
             success : function(data){
            	  var obj = JSON.parse(data);
            	  layer.open({
                      type: 1,
                      title:"AddPdo Message",
                      skin: 'layui-layer-demo',
                      closeBtn: 0,
                      anim: 2,
                      area:['240px','120px'],
                      shadeClose: true,
                      content: obj.result,
                      end: function () {
                              location.reload();
                          }
                 });

            },
	          error : function(e){
	              msg="上传失败！";
	          }
          });
          get();
        })
      })
  })
</script>
</body>
</html>