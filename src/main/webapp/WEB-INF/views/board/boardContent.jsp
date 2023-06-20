<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function goodCheck() {
    	// location.href = "${ctp}/board/boardGoodCheck.bo?idx=${vo.idx}";  // 일반처리한것... 아래는 aJax처리
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/board/boardGoodCheckAjax",
    		data  : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res == "0"
    					) alert("이미 좋아요 버튼을 클릭하셨습니다.");
    			else location.reload();
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
    
    function goodCheckPlus() {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/board/boardGoodPlusMinus",
    		data  : {
    			idx : ${vo.idx},
    			goodCnt : 1
    		},
    		success:function() {
    			location.reload();
    		}
    	});
    }
    
    function goodCheckMinus() {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/board/boardGoodPlusMinus",
    		data  : {
    			idx : ${vo.idx},
    			goodCnt : -1
    		},
    		success:function() {
    			location.reload();
    		}
    	});
    }
    
    function goodSwitchCheck(count) {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/board/boardGoodPlusMinus",
    		data  : {
    			idx : ${vo.idx},
    			goodCnt : count
    		},
    		success:function() {
    			location.reload();
    		}
    	});
    }
    
    function boardDelete() {
    	let ans = confirm("현 게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&nickName=${vo.nickName}";
    }
    
    // 댓글달기(aJax처리)
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요!");
    		$("#content").focus();
    		return false;
    	}
    	let query = {
    			boardIdx : ${vo.idx},
    			mid      : '${sMid}',
    			nickName : '${sNickName}',
    			content  : content,
    			hostIp   : '${pageContext.request.remoteAddr}'
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/board/boardReplyInput",
    		data  : query,
    		success:function(res) {
    			if(res == "1") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("댓글이 입력 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송 오류!!!");
    		}
    	});
    }
    
    // 댓글삭제
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : 'post',
        url : '${ctp}/board/boardReplyDelete',
        data : {replyIdx : idx},
        success : function(res) {
          if(res == '1') {
           alert('댓글이 삭제되었습니다.');
           location.reload();
          }
          else {
           alert('댓글이 삭제되지 않았습니다.');
          }
        },
        error : function() {
          alert('전송실패~~');
        }
      });
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">글 내 용 보 기</h2>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td class="text-right">접속IP : ${vo.hostIp}</td>
    </tr>
  </table>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>
      <th>전자메일</th>
      <td>${vo.email}</td>
      <th>조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>홈페이지</th>
      <td>${vo.homePage}</td>
      <th>좋아요</th>
      <td>
        ${vo.good} /
        <a href="javascript:goodSwitchCheck(${sGFlag})">
          <c:if test="${sSw == '1'}"><font color="#f00" size="5">♥</font></c:if>
          <c:if test="${sSw != '1'}"><font color="#000" size="5">♥</font></c:if>
        </a> /
        <a href="javascript:goodCheckPlus()">👍</a>
        <a href="javascript:goodCheckMinus()">👎</a> /
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4" class="text-center">
        <c:if test="${flag == 'search'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardSearch?search=${search}&searchString=${searchString}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
        <c:if test="${flag == 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardSearchMember?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
        <c:if test="${flag != 'search' && flag != 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
        &nbsp;
      	<c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="수정하기" onclick="location.href='${ctp}/board/boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning"/> &nbsp;
        	<input type="button" value="삭제하기" onclick="boardDelete()" class="btn btn-danger"/>
      	</c:if>
      </td>
    </tr>
  </table>
  
  <c:if test="${flag != 'search' && flag != 'searchMember'}">
	  <!-- 이전글/ 다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
	          ☝ <a href="${ctp}/board/boardContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx < pnVos[0].idx}">
	        	☝ <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx > pnVos[0].idx}">
	        	👇 <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  </c:if>
  
  <!-- 댓글 리스트보여주기 -->
  <div class="container">
    <table class="table table-hover text-left">
      <tr>
        <th> &nbsp;작성자</th>
        <th>댓글내용</th>
        <th>작성일자</th>
        <th>접속IP</th>
      </tr>
      <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
        <tr>
          <td class="text-center">${replyVo.nickName}
            <c:if test="${sMid == replyVo.mid || sLevel == 0}">
              (<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제"><b>x</b></a>)
            </c:if>
          </td>
          <td>${fn:replace(replyVo.content, newLine, "<br/>")}</td>
          <td class="text-center">${fn:substring(replyVo.WDate,0,10)}</td>
          <td class="text-center">${replyVo.hostIp}</td>
        </tr>
      </c:forEach>
    </table>
  </div>
  
  <!-- 댓글 입력창 -->
  <form name="replyForm">
  	<table class="table tbale-center">
  	  <tr>
  	    <td style="width:85%" class="text-left">
  	      글내용 :
  	      <textarea rows="4" name="content" id="content" class="form-control"></textarea>
  	    </td>
  	    <td style="width:15%">
  	    	<br/>
  	      <p>작성자 : ${sNickName}</p>
  	      <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
  	    </td>
  	  </tr>
  	</table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>