<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>boardList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
	 	.here:hover {
	 		text-decoration:none;
	 	}
	</style>
  <script>
    'use strict';
    
    // 준회원이면 글쓰기 불가
    function writeCheck() {
    	
    	/* 23번처럼 강제 캐스팅하면 500번 오류가 생긴다. */
    	<%-- let level = '<%=(String) session.getAttribute("sLevel") %>';     --%>	
    	/* let level = sessionStorage.getItem('sLevel') // 세션 가져오기 */
    	
    	let level = '<%=String.valueOf(session.getAttribute("sLevel")) %>';
    	if(level == "1") {
    		alert('정회원부터 글 작성이 가능합니다.\n정회원 등업 조건: 방명록 글 작성 5회, 방문 10회 이상');
    	}
    	else {
/*     		location.href = "${ctp}/board/boardInput?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"; */
    		location.href = "${ctp}/board/boardInput";
    	}
    }
    
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/board/boardList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
    
    function searchCheck() {
    	let searchString = $("#searchString").val();
    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
  </script> 
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<P><br /></P>
<div class="container">	
	<h2 class="text-center">게 시 판</h2>
	<table class="table table-borderless">
		<tr>
			<td colspan="2" class="text-right">
        <select name="pageSize" id="pageSize" onchange="pageCheck()">
          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
        </select> 건
			</td>
		</tr>
		<tr>
			<td>
				<!--방법1) 준회원은 글쓰기 불가 -->
				<a href="javascript:writeCheck()" class="btn btn-primary btn-sm">글쓰기</a>
<%-- 				<!--방법2) 준회원은 글쓰기 불가: 그냥 버튼 자체를 안 보이게 하기 -->
				<c:if test="${sLevel != 1}"><a href="${ctp}/board/boardInput" class="btn btn-primary btn-sm">글쓰기</a></c:if> --%>
				
			</td>
			<td class="text-right">
        <!-- 첫페이지 / 이전페이지 / (현재페이지번호/총페이지수) / 다음페이지 / 마지막페이지 -->
        <c:if test="${pageVO.pag > 1}">
          <a href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로" class="here">◁◁</a>
          <a href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로" class="here">◀</a>
        </c:if>
        ${pageVO.pag} | ${pageVO.totPage}
        <c:if test="${pageVO.pag < pageVO.totPage}">
          <a href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로" class="here">▶</a>
          <a href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로" class="here">▷▷</a>
        </c:if>
			</td>
		</tr>
	</table>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>글 번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성 날짜</th>
			<th>조회수</th>
			<th>좋아요</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<%-- <td>${vo.idx}</td> --%>
				<td>${curScrStartNo}</td>
				<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
				<td class="text-left">
					<c:if test="${vo.openSw == 'OK' || sLevel == 0 || sMid == vo.mid}">
						<a href="${ctp}/board/boardContent?idx=${vo.idx}&pageSize=${pageVO.pageSize}&pag=${pageVO.pag}">${vo.title}</a>
						<c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
	<%-- 					<c:if test="${vo.hour_diff <= 24}"><span class="badge badge-warning">New</span></c:if> --%>
					</c:if>
					<c:if test="${vo.openSw != 'OK' && sLevel != 0 && sMid != vo.mid}">
						${vo.title}
					</c:if>
					<!-- 댓글이 있을 때만 괄호() 안에 댓글 개수 추가 -->
					<c:if test="${vo.replyCount != 0}">(${vo.replyCount})</c:if>
					
				</td>
				<td>${vo.nickName}</td>
				<td>
					<!-- 1일(24시간)이내는 시간만 표시, 이후는 날짜와 시간 표시 : 2023-05-04 10:35:21 -->
					<!-- 단, 날짜가 오늘 날짜만 시간으로 표시하고 어제 날짜는 날짜로 표시 -->
					<c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
					<c:if test="${vo.hour_diff <= 24}">
						${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
					</c:if>
				</td>
				<td>${vo.readNum}</td>
				<td>${vo.good}</td>
			</tr>	
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
	<br/>
	<!-- 블록 페이징 -->
	<!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
  <div class="text-center">
  	<ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=1">◁◁</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*blockSize + 1}">◀</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">▶</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">▷▷</a></li></c:if>
 		</ul>
  </div>
  <br/>
  <!-- 검색기 처리 -->
  <div class="container text-center">
  	<form name="searchForm" method="get" action="${ctp}/board/boardSearch">
  		<b>검색 : </b>
  		<select name="search">
  			<option value="title" selected>제목</option>   <!-- 이렇게 미리 value를 주면 back에서 처리할 때 편하다. -->
  			<option value="nickName">글쓴이</option>
  			<option value="content">내용</option>
  		</select>
  		<input type="text" name="searchString" id="searchString"/>
  		<input type="button" value="검색" onclick="searchCheck()" class="btn btn-primary btn-sm"/>
  		<input type="hidden" name="pag" value="${pageVO.pag}"/>   <!-- 값을 넘겨줄 때 hidden으로 페이지 위치와 크기를 함께 보내야 한다.  -->
  		<input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
  	</form>
  </div>	
</div>	
<P><br /></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>