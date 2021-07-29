<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

			
	 		function check(){
				var form = document.form;
				
	    		if(document.form.title.value.trim() == ""){
					alert("제목은 필수 입력입니다.");
					return document.form.title.focus(); 
				} else if(document.form.content.value.trim() == ""){
					alert("내용은 필수 입력입니다.");
					return document.form.content.focus();
				} else if(document.form.writer.value.trim() == ""){
					alert("작성자는 필수 입력입니다.");
					return document.form.writer.focus();
				} else if(document.form.pw.value.trim() == ""){
					alert("비밀번호는 필수 입력입니다.");
					return document.form.pw.focus();
				}
	    		
				 var pw = $("#test03").val();
				 
				 var reg = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

				 if(false === reg.test(pw)) {
					 alert('비밀번호는 최소 8자 ~ 최대 10자이어야 하며, 숫자/영어(소문자)/특수문자를 모두 포함해야 합니다.');
						
					 return document.form.pw.focus();
				 } 
					
					form.submit();
				
					
					
				 
	 		}
		
		//chk라는 클래스의 i번째가 공백이거나 null이면 alert로 i번째의 타이틀을 출력해주는 함수
 		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}  
		
		
		//글자 수 제한 - 4000글자
		$(document).ready(function() {
		    $('#test').on('input', function() {
		        $('#test_cnt').html("("+$(this).val().length+" / 1000)");
		 
		        if($(this).val().length > 1000) {
		        		
		            $(this).val($(this).val().substring(0, 1000));
		            $('#test_cnt').html("(1000 / 1000)");
		            setTimeout(function(){alert("내용은 1000자로 이내로 제한됩니다.")}, 100);
		        }
		        
		    });
		});
		
		
		
		//글자 수 제한 - 50글자
		$(document).ready(function() {
		    $('#test01').on('input', function() {
		        $('#test_cnt_01').html("("+$(this).val().length+" / 50)");
		 
		        if($(this).val().length > 50) {
		        	
		            $(this).val($(this).val().substring(0, 50));  //글자수 자르는 곳인가
		            $('#test_cnt_01').html("(50 / 50)");
		            setTimeout(function(){alert("제목은 50자로 이내로 제한됩니다.")}, 100);
		        }
		    });
		});

		
		//글자 수 제한 - 10글자
		$(document).ready(function() {
		    $('#test02').on('input', function() {
		        $('#test_cnt_02').html("("+$(this).val().length+" / 10)");
		 
		        if($(this).val().length > 10) {
		        	
		            $(this).val($(this).val().substring(0, 10));  //글자수 자르는 곳인가
		            $('#test_cnt_02').html("(10 / 10)");
		            setTimeout(function(){alert("작성자는 10자로 이내로 제한됩니다.")}, 100);
		        }
		    });
		});
		
		//글자 수 제한 - 10글자
		$(document).ready(function() {

		    $('#test03').on('input', function() {
		       $('#test_cnt_03').html("("+$(this).val().length+" / 10)"); 
				
		       if($(this).val().length > 10) {
		        	
		            $(this).val($(this).val().substring(0, 10));  //글자수 자르는 곳인가
		            $('#test_cnt_03').html("(10 / 10)");
		            
		            alert("작성자는 10자로 이내로 제한됩니다.");
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
 
        //목록 버튼
        function list_btn() {
     		location.href="/board/list"
    	 }
	
        
        function length(e) {
            if (e.value.length >= e.maxLength) {
                alert("최대 길이입니다.");
            }
        }

        
    	let fn_addFile_count = 1;
        function fn_addFile(){
// 			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			
// 			$(".fileAdd_btn").on("click", function(){
// 				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
// 			});
			
// 			$(document).on("click","#fileDelBtn", function(){
// 				$(this).parent().remove();
// 			});

			
			if (fn_addFile_count >= 5) {
				alert('파일 첨부는 5개까지 가능합니다.');
				return false;// early return
			}
			
			fn_addFile_count++;

			const tr_fileAdd_btn = document.getElementById('tr_fileAdd_btn');

        	tr_fileAdd_btn.insertAdjacentHTML(
        			'beforebegin', `
        			<tr>
						<td>
							<input type="file" name="file[]"/>
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
        
        
	</script>

<meta charset="UTF-8">
<title>답글 작성</title>

<style type="text/css">
	textarea{ resize: none; height: 500px; overflow-y: auto;}
	
	h2 {text-align:center;}
	
	#test01{
	 
		 white-space: nowrap;
		 }

</style>


</head>
<body>
<div id="root">
			<br>

			<header>
				<h2>게시판 - 답글 작성</h2>
			</header>
			
			<br>
			
			
			<section id="container">
				<form role="form" name="form" method="post" action="/board/answer">
				<input type="hidden" name="answerView" value="${answer.bno }">
				<input type="hidden" name="parent_bno" id="parent_bno" value="${answer.bno }"> <!-- 앞(전) 글의 bno임. 원글이 아님! -->
				<input type="hidden" name="beforedepth" value="${answer.depth}">
				<input type="hidden" name="depth" value="${answer.nextdepth}"> 
					<div align="center" class="main">
					
					<table>
						<tbody>
							<tr>
								<td>
									<label for="title">제목</label>
									<br/>
									<input type="text" id="test01" maxlength=51 name="title" class="chk"  placeholder="제목을 입력하세요. 필수 입력 부분입니다." onkeyup="noSpaceForm2(this);" onkeydown="noSpaceForm2(this);" onchange="noSpaceForm2(this);" style="width:800px; height:30px;"/>
									<div id="test_cnt_01">(0 / 50)</div>	
								</td>
							</tr>	
							<tr>
								<td>
									<label for="content">내용</label>
									<br/>
									<textarea id="test" name="content" class="chk" placeholder="내용을 입력하세요. 필수 입력 부분입니다." style="width:800px;" > </textarea>
									<!-- onkeypress="resize(this)" onkeydown="resize(this)" onkeyup="resize(this)" onmouseover="resize(this)" onmouseout="resize(this)" -->
									<div id="test_cnt">(0 / 1000)</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="file">첨부 파일</label>
									<br/>
									<input type="file" name="file[]"/>
								</td>
							</tr>
								<tr id="tr_fileAdd_btn">
									<td>						
										<button class="fileAdd_btn" type="button" onclick="fn_addFile()">파일 추가</button>	
									</td>
								</tr>	
							
							
							<tr>
								<td>
									<label for="writer">작성자</label> <input type="text" id="test02" name="writer" class="chk" maxlength=11 oninput="length(this)" onkeyup="noSpaceForm2(this);" onkeydown="noSpaceForm2(this);" onchange="noSpaceForm2(this);" placeholder="작성자를 입력하세요. 필수 입력 부분입니다." style="width:300px; height:30px;"/>
									
									<div id="test_cnt_02">(0 / 10)</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pw">비밀번호</label><input type="password" id="test03" name="pw" class="chk" 
									onkeyup="noSpaceForm2(this);" onkeydown="noSpaceForm2(this);" onchange="noSpaceForm2(this);" maxlength=11 placeholder="비밀번호를 입력하세요. 필수 입력 부분입니다." style="width:300px; height:30px;"/>
									 <p>*최소 8자 ~ 최대 10자, 숫자/영어(소문자)/특수문자를 모두 포함해야 합니다.</p>
									<!-- <button type="button" id="eye">SHOW</button>   --> 
									<!-- <input type="button" onClick="checkPasswordPattern(test03);" value="검사"/>  -->
									<!-- <div id="test_cnt_03">(0 / 10)</div> -->
								</td>
							</tr>	
							<tr>
								<td>						
									<input type="button" value="작성" class="list_btn btn btn-primary" onclick="check()">
									<input type="button" onclick="list_btn()" class="list_btn btn btn-primary" value="목록">
								</td>
							</tr>			
						</tbody>			
					</table>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>