<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax 예시</title>
<script src="04_jQuery/js/jquery-3.6.1.min.js"></script>
<script>

	$().ready(function(){
		
		$("#loginBtn").click(function(){
			
			var param ={
				
				"id" : $("[name='id']").val(),
				"passwd" : $("[name='passwd']").val()
					
					
			}
			
			
			$.ajax({
				
					url : "ajaxEx05",
					type : "post",
					data : param,//post로 넘김(give)
					success : function(data){ //post에서 끝난 결과를 받아줌(take)
						
						if(data == "true"){
							$("#msg").html("<span style='color:green;'>로그인 되었습니다.</span>");
							$("[name='id']").prop("disabled", true);
							$("[name='passwd']").prop("disabled", true);
						}
						else{
							$("#msg").html("<span style='color:red;'>아이디와 패스워드를 확인하세요.</span>");
							$("[name='id']").prop("disabled", false);
							$("[name='passwd']").prop("disabled", false);
							
						}
					}
				
			});
			
		});	
		
	});
	
</script>
</head>
<body>

	<div>
		<h3>비동기 로그인</h3>
		<p>id : <input type="text" name="id"></p>
		<p>pwd : <input type="password" name="passwd"></p>
		<input type="button" id="loginBtn" value="비동기 로그인">
	</div>
	<h5 id="msg"></h5>
	 
</body>
</html>