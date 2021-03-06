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

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>글 조회</title>

<style type="text/css">
	
	
	/* 가운데로 */
	.replyCenter{
  		 display: grid;
 		 place-items: center;
	}

	
	h2 {text-align:center;}
	
	
	
	/*  div{
    	height:100%; 
    	overflow:hidden;} */
</style>
</head>



<body>

		<div id="root">
			<br>

			<header>
				<h2>게시판 - 디테일</h2>
			</header>
			
			<br>
			
			
			
			<section id="container">
				<form role="form" name="form"  method="post">
					<div align="center" class="main">
					<table>
						<tbody>
							<%-- <input type = "hidden" id="uuid" name="uuid" value="${read.uuid}"/> --%>
							<input type = "hidden" id="bno" name="bno" value="${read.bno}"/>
							<input type="hidden" id="FILE_NO" name="FILE_NO" value=""/>
							
							 
							<tr>
								<td>
									<label for="bno"></label><p id="rnum" name="rnum"><b>번호 </b> <c:out value="${rnum}"/></p>
									<%-- <input type="text" id="rnum" name="rnum" value="${rnum}" readonly="readonly"/> --%>
								</td>
							</tr>
							<tr>
								<td>
									<label for="regdate">작성 날짜</label>
									<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd"/>					
								</td>
							</tr>	
							<tr>
								<td>
									<label for="title"></label>
									<p id="title" name="title" style="width:800px; height:30px;"><b><big>제목: <c:out value="${read.title}" escapeXml="true" /></big></b></p>
									<%-- <input type="text" id="title" name="title" value="${read.title}" readonly="readonly" style="width:800px; height:30px;"/> --%>
								</td>
							</tr>	
							<tr>
								<td>
								<span><b>파일 목록</b></span>
								<div class="form-group" style="border: 1px solid #dbdbdb;">
									<c:forEach var="file" items="${file}">
										<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br/>
									</c:forEach>
								</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="content" >내용</label>
									<br/> <!-- overflow:auto;  min-height:600px;-->
									<div id="content" name="content" class="form-control" style="width:800px; height: auto; min-height:600px; white-space: pre-wrap; padding: 7px; border: 1px solid black; " ><c:out escapeXml="false" value="${read.content}" ></c:out></div>
									
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer"></label><p id="writer" name="writer"><b>작성자 </b> <c:out value="${read.writer}"/></p>
									<%-- <input type="text" id="writer" name="writer" value="${read.writer}" readonly="readonly" style="width:300px; height:30px;"/> --%>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pw">비밀번호　</label><input type="password" id="test03" name="pw" class="chk" placeholder="비밀번호를 입력하세요. 필수 입력 부분입니다." style="width:300px; height:30px;"/>
									<p>*최소 8자 ~ 최대 10자, 숫자/영어(소문자)/특수문자를 모두 포함해야 합니다.</p>									
									<!-- <div id="test_cnt_03">(0 / 10)</div> -->
								</td>
							</tr>	
								
						</tbody>			
					</table>
					
					
					<div>
					<%-- <input type="button" onclick="location.href='updateView?bno=${read.bno}'" value="수정"></button> --%>
					<input type="button"  class="replyUpdateBtn btn btn-warning" onclick="update_btn()" value="수정">
					<%-- <input type="button" onclick="location.href='delete?bno=${read.bno}'" value="삭제"></button> --%>
					<input type="button" class="btn btn-danger wrn-btn" onclick="delete_btn()" value="삭제">
					<!-- <input type="button" onclick="location.href='list';" value="목록"></button>  -->
					<input type="button" class="list_btn btn btn-primary" onclick="answer_btn()" value="답글">
					<input type="button" class="list_btn btn btn-primary" onclick="list_btn()" value="목록">  
					</div>
					</div>
					
				</form>
				
				<hr>
				
				<!-- 댓글 -->
				<div class="replyCenter" >
				
				<form name="replyForm" method="post">
				  <input type="hidden" id="replybno" name="bno" value="${read.bno}" />
				  <input type="hidden" id="replypage" name="page" value="${scri.page}"> 
				  <input type="hidden" id="replyperPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				  <input type="hidden" id="replysearchType" name="searchType" value="${scri.searchType}"> 
				  <input type="hidden" id="replykeyword" name="keyword" value="${scri.keyword}"> 
					
					
					<br/>
				  <div style="border:1px solid black; width:800px; text-align: left; padding: 20px;" >
				  	<br/>
				  	<h4><b>댓글 작성</b></h4>
				    <label for="writer">작성자　　</label><input type="text" id="replywriter" name="writer" onkeyup="noSpaceForm2(this);" onchange="noSpaceForm2(this);"
				     style="width:300px; height:30px;" placeholder="작성자명을 입력하세요. 필수 입력 부분입니다."/> <span id="replywriterlength">(0 / 10)</span>
				    <br/>
				    <label for="pw">비밀번호　</label><input type="password" id="replypw" name="pw"  onkeyup="noSpaceForm2(this);" onchange="noSpaceForm2(this);"
				    style="width:300px; height:30px;" placeholder="비밀번호를 입력하세요. 필수 입력 부분입니다." /> <span id="replypwlength">(0 / 10)</span>
				    <p>*최소 8자 ~ 최대 10자, 숫자/영어(소문자)/특수문자를 모두 포함해야 합니다.</p>
				    <br/>
				    <label for="content">댓글 내용 <span id="replycontentlength">(0 / 500)</span></label>
				    <br/>
				    <textarea id="replycontent" name="content" style="width:750px; height: 150px; resize:none;" placeholder="댓글 내용을 입력하세요. 필수 입력 부분입니다."></textarea>
				  <div>
				 	 <input type="button" onclick="replyWriteBtn()" value="댓글 작성" class="list_btn btn btn-primary">	  
				  </div>
					<br/>
				  </div>
				  
				</form>
		
				<br/>
				<div id="reply" style="border:0px solid black; width:800px; " >
				  <ul class="replyList" style="list-style:none;">
				    <c:forEach items="${replyList}" var="replyList" varStatus="status">
				      
				      <li id="read${status.count}">
				        <p>
				        <br/>
				   	  	<b>댓글 작성자: </b><c:out value="${replyList.writer}"></c:out> <br />
				      	<b>작성 날짜: </b>  <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd" />
				        </p>
						<b>댓글 내용: </b>
						<br/>
				        <%-- <p id="replycontent${status.count }"><c:out value="${replyList.content}" escapeXml="false"></c:out></p> --%>
				        <%-- <div id="replycontent${status.count }"><c:out value="${replyList.content}"  ></c:out></div> --%>
				        <div id="replycontent${status.count }" style="width:700px; white-space:pre-wrap; "><c:out value="${replyList.content}" /></div>
				        
				        <div align="right">
				        <label for="pw">비밀번호　</label><input type="password" id="replypw${status.count }" name="pw${status.count }" placeholder="비밀번호 입력해 주세요."/> 
						    <br/>
						  <button type="button"  class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno}" onclick="replyUpdateButton(${status.count},${replyList.rno});">수정</button>
						  <button type="button" id="replyDeleteBtn" class="btn btn-danger wrn-btn" data-rno="${replyList.rno}" onclick="replyDeleteBtn(${replyList.rno}, ${status.count});">삭제</button>
						  <hr/>
						</div>
				      </li>
				      <li id="update${status.count}" hidden>
				      	<div>
						    <%-- <label for="pw">비밀번호</label><input type="password" id="replypw${status.count }" name="pw${status.count }" />
						    <br/> --%>
						    <br/>
						    <label for="content">댓글 내용 <span id="replyinputlength${status.count}" class="replyinputlength_cnt">(0 / 500)</span></label>
						    <br/>
						    <textarea id="input${status.count }" name="content" class="replyinputlength" style="width:700px; height: 130px; resize:none;"><c:out value="${replyList.content}"></c:out></textarea>
						  </div>
						<!-- 	<script>
				      			document.getElementById('input'+count).addEventListener('input', function(e){ }
				    	  	</script>  -->
						  
						  <div>
						 	 <input type="button" onclick="replayWWWButton(${replyList.rno}, ${status.count})" value="댓글 수정"  class="replyUpdateBtn btn btn-warning">
						 	 <input type="button" onclick="replayCancelButton(${status.count})" value="취소" class="btn btn-danger wrn-btn"> 
						  	 <hr/>
						  </div>
				      </li>
				    </c:forEach>   
				  </ul>
				</div>
				
				
				<%-- <!-- 댓글 페이징 -->
				<div class="paging">
					<div class="paging-body">
						<div class="text-center mt-5 mb-5">
						 <ul class="pagination">
		                     <li><a href="readView?bno=${read.bno}${replyPageMaker.makeSearch(replyPageMaker.startPage )}">[처음]</a></li> 
		                     <li><a href="readView?bno=${read.bno}${replyPageMaker.makeSearch(replyPageMaker.prev)}">[이전]</a></li>
							    
						 <c:forEach begin="${replyPageMaker.startPageList}" end="${replyPageMaker.endPageList}" var="idx" >
							 <li><a href="readView?bno=${read.bno}${replyPageMaker.makeSearch(idx)}"> ${idx}</a></li>
						 </c:forEach>
							
						   	 <li><a href="readView?bno=${read.bno}${replyPageMaker.makeSearch(replyPageMaker.next)}">[다음]</a></li>
						   	 <li><a href="readView?bno=${read.bno}${replyPageMaker.makeSearch(replyPageMaker.endPage)}">[끝]</a></li> 
	                 	 </ul>
	                 	</div>
					</div>
				</div>
 --%>
				</div>
			</section>
			<!-- <hr /> -->
		</div>		
		
	
		<script type="text/javascript">
		// 스크립트를 맨 아래로 내린 이유는 스크립트에서 html 태그를 가져와야 하는데, 스크립트가 먼저 실행해 버리면, 아직 html 태그가 해석되지 않았으므로 가져올 게 없어서 에러가 남
		// 그래서 브라우저 보고 html 태그들부터 해석을 하고 자바스크립트를 실행하도록 한다.
			
			function update_btn() {				
				//컨트롤러에 요청하는 ajax
				$.ajax({
					url: "/board/pwcheck", //이 주소로 ajax 호출을 한다
					type: "get",
					dataType: "JSON",
					data: {
						pw: $('#test03').val(),
						//uuid: $('#uuid').val(),
						bno: $('#bno').val()
						
					},
					success: function(data){ //ajax 호출이 성공한다면, 그 결과를 받아와서 success에 있는 함수를 호출하고 첫 번째 파라미터로 넣어준다
						/* console.debug('data -> ', data) */
						if (data.pwcheck) {
							/* if(confirm('수정하시겠습니까?')){ */
								location.href="updateView?bno=${read.bno}"
							/* } 			 */
						} else {
							alert("비밀번호를 확인해 주세요.");
							return document.form.pw.focus();
						}
						
					},
					error: function (request, status, error){
					}
					});

			}
			
			function replyDeleteBtn(rno, index){				
				//컨트롤러에 요청하는 ajax
				$.ajax({
					url: "/board/replyDelete",
					type: "get",
					dataType: "JSON",
					data: {
						pw: $('#replypw' + index).val(),
						rno: rno
					},
					success: function(data){
						if (data.pwcheck) {
							
							if(confirm('삭제하시겠습니까?')){
							$('#read' + index).remove();
							$('#update' + index).remove();
							
							
							}
	
						} else {
							alert("비밀번호를 확인해 주세요.");
							return document.getElementById('replypw' + index).focus();
	
							}
						
						 
					},
					error: function (request, status, error){
									
						
					}
								
					});
				
			}
			
			
			
			function replyWriteBtn(){
				 
				 // 검증을 하는 이유는 검증이 안 됐을 경우에 실행을 멈추기 위함이며 함수의 실행을 멈추는 방법 중에서 가장 간단한 방법은 if(false)도 있겠지만 더 간단한 방법은 return
				 // 검증에서는 early return을 많이 쓴다.

				 
				 // 검증하기: 작성자, 비밀번호, 내용
				 if(validate_writer() == false) {
					 return false; // early return
					 // early return 패턴을 쓰면 검증 로직을 함수로 따로 분리해 사용이 가능하다. 따로 분리하면 수정이 편리했음! 
				 }
				 
				 if(validate_pw() == false) {
					 return false; // early return
				 }
				 
				 if(validate_content() == false){
					 return false; //early return
				 }
				
				
				 // alert('검증 완료!');
				 // 검증 완료
				 replyWriteBtnSuccess();
				
			}
				
			
				function validate_writer() {
					const replywriter = document.getElementById("replywriter");
					
					// 작성자가 입력 되었는가?
					if (replywriter.value.trim() == '') {
						// 만약 안 되었다면...
						// 1. 얼럿 띄우기
						alert("작성자는 필수 입력입니다.");
						// 2. 포커스 가기!
						replywriter.focus();
						return false; // for early return
					}
					
					// 글자 수 제한 - 10글자 이하
					
					if (replywriter.value.length > 10) {
						// 만약 10글자 초과라면..
						// 1. 얼럿 띄우기
						alert("10글자 이내로 작성해 주세요.");
						// 2. 포커스 가기!
						replywriter.focus();
						return false; // for early return
					}
							
					return true; // 모든 테스트를 성공적으로 완료함!
				}
				
				function validate_pw() {
					const replypw = document.getElementById("replypw");
				
					//A. 비번이 입력되었는가?				
					if (replypw.value.trim() == '') {
						// 만약 안 되었다면...
						// 1. 얼럿 띄우기
						alert("비밀번호는 필수 입력입니다.");
						// 2. 포커스 가기!
						replypw.focus();
						return false; // for early return
					}
					
					
					
					//B. 비번 조건(비밀번호는 최소 8자 ~ 최대 10자이어야 하며, 숫자/영어(소문자)/특수문자를 모두 포함해야 합니다.)
					var reg = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/; // regex: 정규 표현식
					if (false === reg.test(replypw.value.trim())) {
						// 만약 안 되었다면...
						// 1. 얼럿 띄우기
						alert("비밀번호는 최소 8자 ~ 최대 10자이어야 하며, 숫자/영어(소문자)/특수문자를 모두 포함해야 합니다.");
						// 2. 포커스 가기!
						replypw.focus();
						return false; // for early return
					}
					
					return true; //모든 테스트를 성공적으로 완료함!
				}
				
				
				function validate_content() {
					const replycontent = document.getElementById("replycontent");
					
					// 내용이 입력 되었는가?
					if (replycontent.value.trim() == '') {
						// 만약 안 되었다면...
						// 1. 얼럿 띄우기
						alert("내용은 필수 입력입니다.");
						// 2. 포커스 가기!
						replycontent.focus();
						return false; // for early return
					}
					
					// 글자 수 제한 - 500글자 이하
					
					if (replycontent.value.length > 500) {
						// 만약 500글자 초과라면..
						// 1. 얼럿 띄우기
						alert("500글자 이내로 작성해 주세요.");
						// 2. 포커스 가기!
						replycontent.focus();
						return false; // for early return
					}
							
					return true; // 모든 테스트를 성공적으로 완료함!
				}
				
				
				
				
				
			function replyWriteBtnSuccess() {
				//컨트롤러에 요청하는 ajax
				$.ajax({
					url: "/board/replyWrite", //이 주소로 ajax 호출을 한다
					type: "post",
					dataType: "JSON",
					data: {
						writer: $('#replywriter').val(),
						//uuid: $('#uuid').val(),
						content: $('#replycontent').val(),
						bno: $('#replybno').val(),
						pw: $('#replypw').val()
						
					},
					success: function(data){ 
						console.log('data ->', data);
			/*  			if (data.replyWrite) {
			 				alert('여기여기여기') */
							location.reload();
			
			 			/* } else {
							alert("비밀번호 작성하세요");
							return document.form.pw.focus();
						} */
						
					},
					error: function (request, status, error){
						console.log('error data ->');
					},
					complete: function() {
						console.log('complete data ->');
					}
					
					
					
				});
			}
			
			function delete_btn() {
				 
				//컨트롤러에 요청하는 ajax
				$.ajax({
					url: "/board/pwcheck",
					type: "get",
					dataType: "JSON",
					data: {
						pw: $('#test03').val(),
						bno: $("#bno").val()
					},
					success: function(data){
						if (data.pwcheck) {
							if(confirm('삭제하시겠습니까?')){
								location.href="delete?bno=${read.bno}&boardYN=Y" 
							} 			
						} else {
							alert("비밀번호를 확인해 주세요.");
							return document.form.pw.focus();
						}
						
					},
					error: function (request, status, error){
					}
						
					
					});
				
				}
			
			//게시판 삭제 요청 여부 location.href="delete?bno=${read.bno}&boardYN=Y" 
			// -->&boardYN=Y 이게 같이 오면 무조건 게시판에서 온 거니까 게시물을 삭제하도록
			
			//목록 버튼 
			function list_btn(){
					location.href="/board/list"
			}
			
			//답변 글 쓰러 이동~!
			function answer_btn(){
				location.href="/board/answerView?bno=${read.bno}"
			}
			

			function resize(obj) {
				  obj.style.height = '1px';
				  obj.style.height = (12 + obj.scrollHeight)+'px';
				}
			
			function replyUpdateButton(count, rno) { 
				// count: 이 함수를 호출할 때, 첫 번째 파라미터 값으로 전달된 값을 count라는 변수를 여기서 새로 만들어서 그 값을 담는다.변수명은 아무런 의미가 없다.
				// 하지만 변수명이 맞아야 잘 보임..!
			
				// $('#read' + count).hide();
				// $('#update' + count).show();
				
				
				//컨트롤러에 요청하는 ajax
				$.ajax({
					url: "/board/replyPwcheck",
					type: "get",
					dataType: "JSON",
					data: {
						bno:$("#bno").val(),
						rno: rno,
						pw:$("#replypw" + count).val()
					},
					success: function(data){
						if(data.pwcheck){
							replyUpdatePasswordSuccess(count); 
						} else {
							replyUpdatePasswordFail(count);
						}
						
					
						
					},
					error: function (request, status, error){
					}
						
					
				});
				
				// replyUpdatePasswordSuccess(count); 
				// 함수를 호출할 때, 첫 번째 파라미터 "값"으로 count라는 변수의 값을 전달하고 있음. 이것을 어떤 변수명으로 받아서 쓸지는 여기서 호출한 함수에 달려 있음!

				//replyUpdatePasswordFail();
			
			}
			
			function replyUpdatePasswordSuccess(count) {
				 $('#read' + count).hide();
				 // Uncaught ReferenceError: // 예상하지 못한(Uncaught) 참조 에러가 발생했다
				 // index is not defined // index가 정의되지 않았다
				 // 이름 = identifier = 함수명 혹은 변수명
				 
				 $('#update' + count).show();
					
			}
			
			
			function replyUpdatePasswordFail(count){
				
				alert("비밀번호를 확인해 주세요.");
				
				document.getElementById("replypw" + count).focus();
				
			}
			
			function replayWWWButton(rno, index) {
				console.debug('rno -> ', rno)
				console.debug('index -> ', index)
				
				
				
				//컨트롤러에 요청하는 ajax
				$.ajax({
					url: "/board/replyUpdate",
					type: "get",
					dataType: "JSON",
					data: {
						pw: $('#replypw' + index).val(),
						content: $('#input' + index).val(),
						rno: rno
					},
					success: function(data){
						if (data.pwcheck) {
							
							/* 성공 시 */			
							$('#read' + index).show();
							$('#update' + index).hide();
							$('#replycontent' + index).text($('#input' + index).val());
							$('#replypw' + index).val(''); // 비밀번호 초기화
							
						
						} else {
							alert("비밀번호가 다릅니다.");
							return document.form.pw.focus();
						}
						
					},
					error: function (request, status, error){
					}			
					
					});

			}
			
			function replayCancelButton(index) {
				$('#read' + index).show();
				$('#update' + index).hide();
				$('#replypw' + index).val(''); // 비밀번호 초기화
			}
			

			//글자 수 제한 - 댓글 작성자 창
			$(document).ready(function() {

			    $('#replywriter').on('input', function() {
			       $('#replywriterlength').html("("+$(this).val().length+" / 10)"); 
					
			       if($(this).val().length > 10) {
			    	
			    		setTimeout(function(){alert("작성자는 10자로 이내로 제한됩니다.")}, 100);
			    	   
			            $(this).val($(this).val().substring(0, 10));  //글자수 자르는 곳인가
			            $('#replywriterlength').html("(10 / 10)");
			            
			            
			        }
			    });
			     
			}); 
			 
			 
			//글자 수 제한 - 댓글 비번 창
			$(document).ready(function() {

			    $('#replypw').on('input', function() {
			       $('#replypwlength').html("("+$(this).val().length+" / 10)"); 
					
			       if($(this).val().length > 10) {
			    	   
			    	   setTimeout(function(){alert("비밀번호는 10자로 이내로 제한됩니다.")}, 100);
			        	
			            $(this).val($(this).val().substring(0, 10));  //글자수 자르는 곳인가
			            $('#replypwlength').html("(10 / 10)");
			            
			            
			        }
			    });
			     
			}); 
			

			
			document.getElementById('replycontent').addEventListener('input', function(e) {
				const length = e.target.value.length;
				
				console.log(length);
				// 만약 length가 500자 초과면 
				if(length > 500) {
					// 1. alert창
					setTimeout(function(){alert("최대 500자까지 입력 가능합니다.")}, 100);
					// 2. 앞에서부터 500자만 남긴다.
					e.target.value = e.target.value.substr(0, 500);
					replycontentlength.innerHTML = '(500 / 500)'; // 살짝 느리기 때문에 잠깐이지만 500자를 넘게 되어서 500/500으로 해둠
				
				} else {
					const replycontentlength = document.getElementById('replycontentlength');
					replycontentlength.innerHTML = '(' + length + ' / 500)';
				}
				
				
				
			});


			//글자 수 제한 - 댓글 수정창(야매.. 다시 해..)
			$(document).ready(function() {

			    $('.replyinputlength').on('input', function() {
			       $('.replyinputlength_cnt').html("("+$(this).val().length+" / 500)"); 
					
			       if($(this).val().length > 500) {
			        	
			            $(this).val($(this).val().substring(0, 500));  //글자수 자르는 곳인가
			            $('.replyinputlength_cnt').html("(500 / 500)");
			            
			            
			            setTimeout(function(){alert("글자 수는 500자로 이내로 제한됩니다.")}, 100);
			        }
			    });
			    
			 
			}); 
			
			
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
			
	        
	        function fn_fileDown(fileNo){ // 함수 파라미터를 통해서 함수 인자값을 통해 파일 넘버를 받아오고 있음
	        	
				// http://localhost:8080/board/fileDown?FILE_NO=10 
				// 진짜 파일이 다운이 되는지 안 되는지 알 수 있음 이걸 알 수 있었으므로 어디서 문제가 되는지 알 수 있었음 -->js코드의 문제 
				location.href="/board/fileDown?FILE_NO=" + fileNo;
			}
			
			</script> 
	</body>
</html>