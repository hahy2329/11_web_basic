<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>receive 예시</title>
<script src="04_jQuery/js/jquery-3.6.1.min.js"></script>
<script>

	$().ready(function(){
		
		$("#recvTest").click(function(){
			
			$.ajax({
				
				url : "ajaxEx03", // url을 틀리게 입력하면 error함수 쪽으로 실행하게 된다.
				type : "post",
				success : function(data, status, xhr){ //a,b,c 파라메타여도 상관없음 순서만 맞으면 된다.
					
					console.log("통신 성공 함수");
					console.log(data);
					console.log(status);
					console.log(xhr);
					console.log("");
					
					
				},//통신이 성공했을경우 실행되는 콜(call)백함수
				//기본 데이터는 스트링만 넘어간다.
				
				error: function(xhr, status, errorThrown){// 통신이 실패했을 경우 실행되는 콜(call)백함수!!
					console.log("통신 실패 함수");
					console.log(xhr.responseText); //메타정보
					console.log(status); // 상태는 error로 나오게 된다.
					console.log(errorThrown);
					console.log("");
					
				},
				
				complete : function(xhr, status){ //통신 성공 실패여부와 상관없이 항상 실행되는 콜(call)백 함수
					console.log("- 반드시 실행되는 함수 -");
					console.log(xhr);
					console.log(status);
					console.log("");
						
					
					
				}
				
				
				
				
			});
		});
		
	});
</script>
</head>
<body>
	<form>
		<p>
			<input type="button" id="recvTest" value="비동기통신"> 
		</p> 
	</form>
</body>
</html>