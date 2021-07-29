<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<link rel="stylesheet" href="resources/css/list.css?ver=1.3">

<!-- jquery: jquery.com download> -->
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<script type="text/javascript"> 

 		// 첫 글자 공백만 사용 못 하게
        //onkeyup="noSpaceForm2(this);" onchange="noSpaceForm2(this);"
        function noSpaceForm2(obj) 
        {                        
            if(obj.value == " ") // 공백 체크
            {              
                alert("첫 글자 공백을 사용할 수 없습니다.\n\n공백 제거됩니다.");
                obj.focus();
                obj.value = obj.value.replace(' ','');  // 공백 제거
                return false;
            }
        } 
        
        
/*         function check(){
			var form = document.form;
			
    		if(document.form.keyword.value.trim() == ""){
				alert("키워드는 필수 입력입니다.");
				return document.form.keyword.focus(); 
			} 
        } */

</script>

<meta charset="UTF-8">
<title>목록</title>
	<style type="text/css">
		li {
			list-style: none; 
			float: left; 
			padding: 6px;
		}
		
		.search{
        	display: inline;
        	/* margin: 18rem;
  			padding: 5; */
   		 }
   		 
   		h2 {text-align:center;}
   		
   		.paging{
   			float: left;
   			width: 90%;
   			text-align: center;
   		}
   		
   		.paging-body{
   			display: inline-block;
   		}
   		
/*    		#searchbox{
   			height: 34px;
   		}
   		 */
		 .inline-block{
		  display: inline-block;
		}
		
		#mydiv1{
			  display: inline;
		}

		.search01{
			display:inline-block;
			margin: 0px;
			padding: 0px;
		}
	</style>

</head>
<body>
<div id="root" class="container">
			<br>

			<header>
				<h2>[LIST]</h2>
			</header>
			
			<br>

			 
<%-- 		<div>
				<%@include file="nav.jsp" %>
			</div>
			 --%>

			
			<section id="container">
				<form role="form" name="form" method="get" action="/board/write">
					
					<!-- 검색 시작 -->			
					
					
					<div align="right" classs="search01">
						 
						<!-- select-box -->
						<div class="search row" >
						<div class="" style="display: inline-block;">
					    <select name="searchType" class="form-control search-slt" style="width: 100px;"  aria-label="Default select example">
					      <%--  <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option> --%>
					      <option selected value="t">제목</option>
					      <option value="c">내용</option>
					      <option value="w">작성자</option>
					      <option value="tc">제목+내용</option>
					    </select>
					    </div>
					
						<!-- search-box -->
						<div class="" id="mydiv1" style="display: inline-block;">
					    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"  placeholder="검색어를 입력하세요." class="form-control search-slt" onkeyup="noSpaceForm2(this);" onkeydown="noSpaceForm2(this);" onchange="noSpaceForm2(this);"/>
					    </div>
					    
					    <!-- search 버튼 + script -->
					    <div class="" id="mydiv1" style="display: inline-block;">
					    <!--  <button id="searchBtn" type="button" class="btn btn-danger wrn-btn">검색</button> -->
					     <input type="button" value="검색" id="searchBtn" class="btn btn-danger wrn-btn" onclick="check()">
						</div>		    
						    <script>
						      $(function(){
						        $('#searchBtn').click(function() {
						          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
						        });
						      });   
						    </script>
					  	</div>
				    </div>	
				    
				   
				   
				  <br>
					
					<div align="center" class="main">
					<table class="table table-hover" >
						<colgroup>
							<col width="60px;">
							<col width="630px;">
							<col width="170px;">
							<col width="95px;">
						</colgroup>
										
						<tr >
							<th style="text-align: center;">번호</th>
							<th style="text-align: center;">제목</th>
							<th style="text-align: center;">작성자</th>
							<th style="text-align: center;">등록일</th>
							
						</tr>
						
						<c:forEach items="${list}" var = "list">

							<tr >
								<td style="text-align: center;">
<%-- 									<c:out value="${(list.bno2 > 0) ? list.bno2 : '▶'}" /> --%>
									<c:out value="${list.bno2}" />
								</td>
								<!-- 전체 글의 수 - LIST.ORDERNUM(결국 ROWNUM) +1 -> 1을 더하는 이유는 전체 게시글 - ROWNUM을 하면 0이 되니까, 글은 1부터 시작해야 하므로 +1을 해 줌 -->
								<td style="text-align: left;">
									<!-- 원글 -->
									<c:if test ="${list.depth == 1 }">
									<c:choose>
										<c:when test="${'Y' eq list.delete_yn && 0 eq list.parent_bno}">
											<span><c:out value="${list.title}" escapeXml="true"/></span>
										</c:when>
										<c:otherwise>
											<a href="/board/readView?bno=${list.bno}&rnum=${list.rnum}">
												<c:out value="${list.title}" escapeXml="true"/>  <span style="color: gray;">[</span><span style="color: gray;">${list.reply_cnt }</span><span style="color: gray;">]</span>
												<c:if test ="${'Y' eq list.file_yn}">(*)</c:if>
											</a>
										</c:otherwise>
									</c:choose>
									</c:if>
									
									<!-- 답글 -->
									<c:if test ="${list.depth > 1 }">
									<c:choose>
										<c:when test="${'Y' eq list.delete_yn}">
											<span style="color: green; padding-left: ${list.depth * 10}px;">└ RE: </span><c:out value="${list.title}" escapeXml="true"/>
										</c:when>
										<c:otherwise>
											<a href="/board/readView?bno=${list.bno}&rnum=${list.rnum}&parent_bno=${list.parent_bno}">
												<span style="color: green; padding-left: ${list.depth * 10}px;">└ RE: </span><c:out value="${list.title}" escapeXml="true"/>   <span style="color: gray;">[</span><span style="color: gray;">${list.reply_cnt }</span><span style="color: gray;">]</span>
												<c:if test ="${'Y' eq list.file_yn}">(*)</c:if>
											</a>
										</c:otherwise>
									</c:choose>
									</c:if>
									
								</td>
								<td style="text-align: center;">
									<c:out value="${list.writer}" />
								</td>
								<td style="text-align: center;"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
						
					</table>
				
					</div>
					
					<br>
					
					<!-- 페이징 시작 -->
					<%-- <div class="paging" align="right">
					  <ul>
					    <c:if test="${pageMaker.prev }">
                        	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage )}">[처음]</a></li> 
                        </c:if>
					    <c:if test="${pageMaker.prev}">
					    	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">[이전]</a></li>
					    </c:if> 
					
					    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					    	<li><a href="list${pageMaker.makeSearch(idx)}"> ${idx}</a></li>
					    </c:forEach>
					
					    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					    	<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">[다음]</a></li>
					    </c:if> 
					    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                       		<li><a href="list${pageMaker.makeSearch(pageMaker.startPage)}">[끝]</a></li> 
                   		</c:if>
					  </ul>
					</div> --%>
					
					<div class="search" align="right">
<!-- 						<form action="/excel" method="post"> -->
				            <input type="button" onclick="location.href='/board/excel/download${pageMaker.makeSearch(pageMaker.curPage)}';" class="replyUpdateBtn btn btn-warning" value="Excel"/>
<!-- 				    	</form>  -->
						<input type="button" value="목록" onClick="location.href='/board/list'" class="btn btn-danger wrn-btn">
						<input type="button" value="글쓰기" onClick="location.href='/board/writeView'" class="btn btn-danger wrn-btn">	 
					</div>
					
					<div class="paging">
						<div class="paging-body">
							<div class="text-center mt-5 mb-5">
						 	<ul class="pagination">
		                       	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage )}">[처음]</a></li> 
		                       	<!-- list?page=1&perPageNum=10&searchType=&keyword= -->
		                       	<!-- list?page=1&perPageNum=10&searchType=t&keyword=%EC%9C%84%ED%95%9C -->
		                       	<li><a href="list${pageMaker.makeSearch(pageMaker.prev)}">[이전]</a></li>
							    
							    <c:forEach begin="${pageMaker.startPageList}" end="${pageMaker.endPageList}" var="idx" >
							    	<li><a href="list${pageMaker.makeSearch(idx)}"> ${idx}</a></li>
							    </c:forEach>
							
						    	<li><a href="list${pageMaker.makeSearch(pageMaker.next)}">[다음]</a></li>
						    	<li><a href="list${pageMaker.makeSearch(pageMaker.endPage)}">[끝]</a></li> 
						    	<!-- list?page=13&perPageNum=10&searchType=t&keyword=%EC%9C%84%ED%95%9C -->
	                 		</ul>
	                 		</div>
						</div>
					</div>
					

				</form>
			</section>
			<hr />
		</div>
	</body>
</html>
 