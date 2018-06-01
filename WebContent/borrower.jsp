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
<title>Borrower</title>
</head>
<body class="login-bg">
  <div class="login-body">
    <div class="login-heading">
      <h1>Borrower</h1>
    </div>
    <div class="login-info">
      <ul class="nav nav-tabs">
        <li class="active" ><a href="#personalInfo" data-toggle="tab">PersonalInfo</a></li>
        <li ><a href="#borrowedBook"  data-toggle="tab">BorrowedBook</a></li>
        <li ><a href="#borrowingBook"  data-toggle="tab">BorrowingBook</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="personalInfo">
         <s:property value = "borrower.name"/>
         <s:property value = "borrower.email"/>
         <s:property value = "borrower.registerDate"/>
         <s:property value = "borrower.limit"/>
         <s:property value = "borrower.credit"/>
        </div>
        
        
        <div class="tab-pane" id="borrowedBook">
	        <s:iterator value = "borrowedBook" var = "book" status = "sta">
	          <s:property value="%{#book.title}" />
	          <br>
	          <s:property value="%{#book.ISBN}" />
            <br>
            <s:property value="%{#book.quantity}" />
            <br>
            <s:iterator value="#book.authors" var="author" status="s">
              <s:property value="%{#author.firstName}" /> <s:property value="%{#author.lastName}" />
            </s:iterator>
            <s:iterator value="#book.tags" var="tag" status="s">
              <s:property value="%{#tag.tag}" />
            </s:iterator>
	        </s:iterator>
          
          
        </div>
        
        <div class="tab-pane" id="borrowingBook">
          <s:iterator value = "borrowingBook" var = "book" status = "sta">
            <s:property value="%{#book.title}" />
            <br>
            <s:property value="%{#book.ISBN}" />
            <br>
            <s:property value="%{#book.quantity}" />
            <br>
            <s:iterator value="#book.authors" var="author" status="s">
              <s:property value="%{#author.firstName}" /> <s:property value="%{#author.lastName}" />
            </s:iterator>
            <s:iterator value="#book.tags" var="tag" status="s">
              <s:property value="%{#tag.tag}" />
            </s:iterator>
            <form method="post" class="renewForm">
		          <input type="hidden" name="userId" value='<s:property value = "userId"/>' />
	            <input type="hidden" name="borrowerID" value='<s:property value = "userId"/>' />
	            <input type="hidden" name="bookID" value='<s:property value="%{#book.bID}" />' />
	            <div class = "renewButton">
			          <button type="button"
			          class="btn  btn-lg btn-primary  hvr-shutter-out-vertical"
			          >Add Tag</button>
		          </div>
		        </form>
          </s:iterator>
          
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