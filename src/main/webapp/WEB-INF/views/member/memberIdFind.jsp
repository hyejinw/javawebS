<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/> 
	<script>
		'use strict';
		let str = '';
		
		function fCheck() {
			let name = $("#name").val();
			let email = $("#email").val();
			
			console.log("name : " + name + ", email :" + email );
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/memberIdFind",
				data : {name:name , email:email},
				success : function(res) {
					str = "아이디 검색결과✔ : " + res;
					$("#demo").html(str);
				},
				error : function() {
					alert("전송 오류!");
				}
			}); 
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<P><br /></P>
<div class="container">	
	<h2 class="text-center">아이디 찾기</h2>
	<form name="myform">
		<table class="table text-center">
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" id="name" value="${name}" required class="form-control"/></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" id="email" value="${email}" class="form-control"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="아이디 찾기" onclick="javascript:fCheck()" class="btn btn-primary mr-2"/>
					<input type="reset" value="다시입력" class="btn btn-warning mr-2"/>
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-secondary"/>
				</td>
			</tr>
		</table>
	</form>
  <hr/>
  <div>
    <span id="demo"></span>
  </div>
</div>	
<P><br /></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>