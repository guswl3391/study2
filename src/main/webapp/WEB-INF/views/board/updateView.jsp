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

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>


<script type="text/javascript">

/* function update_btn() {
	if(confirm('수정하시겠습니까?')){
		alert("ok");
		location.href="readView?bno=${update.bno}"
	} else {
		alert("cancle");
	}
}
 */
	function check(){
		var form = document.form;
		
		if(document.form.title.value.trim() == ""){
			alert("제목은 필수 입력입니다.");
			return document.form.title.focus(); 
		} else if(document.form.content.value.trim() == ""){
			alert("내용은 필수 입력입니다.");
			return document.form.content.focus();
		} 
		
		if(confirm('수정하시겠습니까?')) {
			
			form.submit();
		}
 	}
 
function cancle_btn(){
	if(confirm('수정 취소하시겠습니까? 목록으로 돌아갑니다.')){
		location.href="/board/list"
		} 
	}
 
	//글자 수 제한
	$(document).ready(function() {
	    $('#test').on('input', function() {
	        $('#test_cnt').html("("+$(this).val().length+" / 1000)");
	 		
	        if($(this).val().length > 1000) {
        		alert("내용은 1000자로 이내로 제한됩니다.");
	            $(this).val($(this).val().substring(0, 1000));
	            $('#test_cnt').html("(1000 / 1000)");
	            
	          
	        }
	    });
	});
	
	//글자 수 제한
	$(document).ready(function() {
	    $('#test01').on('input', function() {
	        $('#test_cnt_01').html("("+$(this).val().length+" / 50)");
	 
	        if($(this).val().length > 50) {
	        	alert("제목은 50자로 이내로 제한됩니다.");
	            $(this).val($(this).val().substring(0, 50));  //글자수 자르는 곳인가
	            $('#test_cnt_01').html("(50 / 50)");
	        }
	    });
	});
 
 
    // 첫 글자 공백만 사용 못 하게
    //onkeyup="noSpaceForm2(this);" onchange="noSpaceForm2(this);" onkeydown="noSpaceForm2(this);"
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

    
 	
/* 	 
	  function resize(obj) {
				 
   	  	obj.style.height = '1px';
   	 	obj.style.height = (12 + obj.scrollHeight)+'px';
   	  
   	}
	 
	  */
	 
	 
	  /* function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
		 */
	  	// function fn_del(value, name){
  		function fn_del(buttonObject) {
			//삭제 버튼을 눌렀을 때, 파일이 삭제 되기를 원함
			//파일이 삭제된다는 것은 db에서 없애야 한다는 것-> 서버와의 통신이 필요 
			//이용자는 다시 파일 첨부라는 버튼이 보여야 함 -> 페이지가 새로고침 되면 안 된다 -> submit으로 하면 안 됨 --> ajax로 해야 함
			//ajax로 해야 한다는 것은 여기서 화면도 js로 다시 그려줘야 한다는 것임
			//submit하면 jsp로 하면 됨 하지만 ajax로 하면 화면 변화 하나하나 다 내가 그려줘야 함
			
			// 1. 화면 처리
  			const div = buttonObject.parentElement;
  			div.remove();
  			fn_addFile_count--;
  			
  			// 2. 서버에 전송될 삭제시킬 파일 번호 추가
  			const file_no = buttonObject.getAttribute('data-file-no');
  			// 참고
  			/*
  				<div id="divFileNoDel">
					<input type="hidden" name="fileNoDel[]" value="29">
				</div>
  			*/
  			const divFileNoDel = document.getElementById('divFileNoDel');
  			const input = document.createElement('input');
  			input.type = 'hidden';
  			input.name = 'fileNoDel[]';
  			input.value = file_no;
  			divFileNoDel.append(input);
		}

		
		
		let fn_addFile_count = <c:out value="${file.size()}"/>;
        function fn_addFile(){
			if (fn_addFile_count >= 5) {
				alert('파일 첨부는 5개까지 가능합니다.');
				return false;// early return
			}
			
			fn_addFile_count++;

			const tr_fileAdd_btn = document.getElementById('tr_fileAdd_btn');

        	tr_fileAdd_btn.insertAdjacentHTML('beforebegin', 
	        	`<tr>
					<td>
						<input type="file" name="file[]" onchange="fn_changeFile(this);" />
						<button onclick="fn_removeFile(this);">삭제</button>
					</td>
				</tr>
			`);
        }
        
        function fn_removeFile(buttonObject) {
        	const td = buttonObject.parentElement;
        	const tr = td.parentElement;
        	tr.remove();
        	
        	fn_addFile_count--;
        }
        
        function fn_changeFile(inputObject) {
        	const isValidate = (inputObject.files.length > 0); // 0: onchange는 일어났지만, 파일은 들어오지 않았다.
        	if (isValidate == false) {
        		return false; // early return
        	}
        	
        	const bytes = inputObject.files[0].size;
        	const maxUploadSize = 100000000; // =100MB
        	// https://docs.spring.io/spring-framework/docs/3.0.0.M3/reference/html/ch16s08.html
        	if (maxUploadSize <= bytes) {
        		alert("100MB 이하의 파일만 첨부가 가능합니다.");
        		inputObject.value = '';
        	}
        }
        
		
	 
</script>

<title>글 수정</title>
<meta charset="UTF-8">

<style type="text/css">
	textarea{ resize: none; height: 500px; overflow-y: auto;}

	h2 {text-align:center;}
	
</style>

</head>



<body>
	
		<div id="root">
			<br>

			<header>
				<h2>게시판 - 글 수정</h2>
			</header>
			
			<br>
			
			
			<section id="container">
				<form role="form" name="form" method="post" action="/board/update" enctype="multipart/form-data">
					<%-- <input type="hidden" name="uuid" value="${update.uuid}" readonly="readonly"/> --%>
					<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
					
					
					<div id="divFileNoDel">
						<!-- <input type="hidden" name="fileNoDel[]" value="29"> -->
					</div>
					
					
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value=""> 
				
					
					
					<div align="center" class="main">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="title">제목</label>
									<br/>
									<input type="text" id="test01" name="title"  maxlength=51  value="<c:out value="${update.title}"/>" 
									placeholder="제목을 입력하세요. 필수 입력 부분입니다." onkeyup="noSpaceForm2(this);" onchange="noSpaceForm2(this);" onkeydown="noSpaceForm2(this);" style="width:800px; height:30px;">
									<div id="test_cnt_01">(0 / 50)</div>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="regdate">작성날짜</label>
									<fmt:formatDate value="${update.regdate}" pattern="yyyy-MM-dd"/>					
								</td>
							</tr>
							<tr>
								<td>
									<label for="content">내용</label>
									<br/>
									<textarea id="test" name="content" placeholder="내용을 입력하세요. 필수 입력 부분입니다." maxlength=4001 style="width:800px;"><c:out value="${update.content}" /></textarea>
									 <!-- onkeydown="resize(this)" onkeyup="resize(this)"  -->
									<div id="test_cnt">(0 / 1000)</div>
								</td>
							</tr>
							<tr>
								<td id="fileIndex">
									<c:forEach var="file" items="${file}" varStatus="var">
									<div>
										<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
										<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
										<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
<%-- 										<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button">삭제</button> --%>
										<button onclick="fn_del(this);" data-file-no="${file.FILE_NO}" type="button">삭제</button>
										<br>
									</div>
									</c:forEach>
								</td>
							</tr>
							<tr id="tr_fileAdd_btn">
								<td>	
									<button class="fileAdd_btn" type="button" onclick="fn_addFile()">파일 추가</button>	
								</td>
							</tr>	
							
							
							
							
							
							<tr>
								<td>
									<label for="writer"></label>
									<p id="writer" name="writer"><b>작성자 </b> <c:out value="${update.writer}"/></p>
									<%-- <input type="text" id="writer" name="writer" value="${update.writer}" required="required" readonly="readonly" style="width:300px; height:30px;" /> --%>
								</td>
							</tr>

							
						</tbody>			
					</table>
					<div>
						<!-- <button type="submit" class="update_btn">저장</button> -->
						<input type="button" class="list_btn btn btn-primary" value="저장" onclick="check()">
						<input type="button" onclick="cancle_btn()" class="btn btn-danger wrn-btn" value="취소"></button>
					</div>
					</div>
				</form>
			</section>
			<hr />
		</div>
		

<!-- <script type="text/javascript" src="resources/js/updateView.js?ver=1.3"></script>		 -->
		
	</body>
</html>