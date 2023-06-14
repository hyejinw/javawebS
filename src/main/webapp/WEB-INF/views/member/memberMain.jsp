<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>이곳은 회원방!</h2>
	<hr/>
	<div>
		<p><font color="blue"><b>${sNickName}</b></font>님 페이지</p>
		<p>현재 등급은 <font color="orange">${strLevel}</font>입니다.</p>
	</div>
	<c:if test="${!empty sImsiPwd}">
		<hr/>
		현재 임시비밀번호를 발급받아 사용 중입니다.<br/>
    개인정보를 확인하시고 비밀번호를 변경해주세요.<br/>
    <a href="${ctp}/member/memberPwdUpdate" class="btn btn-success">비밀번호변경</a>
    <hr/>		
	</c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>