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
		
		function fCheck() {
			let emails = "";
			let email = document.getElementsByName("email");
			for(let i=0; i<email.length; i++) {
				if(document.getElementsByName("email")[i].checked == true) {
					emails += document.getElementsByName("email")[i].value + ";";
				}
			}
			
			$("#toMail").val(emails);
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
	<h2>메일 보내기</h2>
	<p>(받는 사람의 메일주소를 정확히 입력하셔야 합니다)</p>
	<form name="myform" method="post">
		<table class="table table-bordered">
			<tr>
				<th>
					받는 사람
					 <button type="button" class="btn btn-primary btn-sm ml-3" data-toggle="modal" data-target="#myModal">회원 리스트</button>
				</th>
				<td>
					<input type="text" name="toMail" id="toMail" value="${email}" placeholder="받는 사람 메일주소를 입력하세요" class="form-control" required autofocus />
				</td>
			</tr>	
			<tr>
				<th>메일 제목</th>
				<td>
					<input type="text" name="title" placeholder="제목을 입력하세요" class="form-control" required />
				</td>
			</tr>	
			<tr>
				<th>메일 내용</th>
				<td>
					<textarea rows="7" name="content" class="form-control" required></textarea>
				</td>
			</tr>	
			<tr>
				<td colspan="2" class="text-center">
					<input type="submit" value="메일 보내기" class="btn btn-success mr-2" />
					<input type="reset" value="다시 쓰기" class="btn btn-secondary mr-2" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="btn btn-success" />
				</td>
			</tr>	
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>


<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h1 class="modal-title text-center">회원 리스트</h1>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<form>
        		<c:forEach var="vo" items="${vos}">
        			<div class="row">
								<div class="col-sm-5 text-center">${vo.name}</div>        			
								<div class="col-sm-5 text-center">${vo.email}</div>        			
								<div class="col-sm-2"><input type="checkbox" name="email" value="${vo.email}"/></div>        			
        			</div>
        		</c:forEach>
        	</form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
      	  <button type="button" class="btn btn-primary" onclick="javascript:fCheck()" data-dismiss="modal">선택</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>