<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		
		function pwdCheck() {
			let pwd = $("#pwd").val();
			let rePwd = $("#rePwd").val();
			
			if(pwd == ""  || rePwd == "") {
				alert("비밀번호를 입력하세요");
				$("#pwd").focus();
			}
			else if(pwd != rePwd) {
				alert("비밀번호가 일치하지 않습니다");
				$("#rePwd").focus();
			}
			else {
				myform.submit();
			}
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>비밀번호 변경</h2>
	<p>아이디와 이메일 주소를 입력 후 메일로 임시비밀번호를 발급</p>
	<form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>새비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" class="form-control" required /></td>
      </tr>
      <tr>
        <th>비밀번호확인</th>
        <td><input type="password" name="rePwd" id="rePwd" class="form-control" required /></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="비밀번호변경" onclick="pwdCheck()" class="btn btn-success" />
          <input type="reset" value="다시입력" class="btn btn-warning" />
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>