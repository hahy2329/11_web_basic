<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSON 기초</title>
<script src="../js/jquery-3.6.1.min.js"></script>
<script>

	/*
	
		# JSON(JavaScript Object Notation)
		
		- JavaScript에서 객체를 만들 때 사용하는 표현식
		- 사람도 이해하기 쉽고 기계도 이해하기 쉬우면서 데이터의 용량이 작다.
		- AJAX로 전송가능한 형식		 
	    - 사용 가능한 자료형은 숫자(number) , 문자열(string) , 불리언(boolean) , 객체(object) , 배열(array) , NULL이 있다.
		 
			[형식]
	
			{ name1 : value2 , name2 : value2 , name3 : value3... }
	
			1) 중괄호로 오브젝트를 묶는다.
			2) 데이터는 name/value 쌍으로 생성한다.
			3) 복수의 데이터는 ‘,’로 분리한다.
			4) 배열은 대괄호를 사용한다. (예시 [1,2,3,4,5])
			
		- JSON.parse()메서드 	 : (파싱)	   문자열을 자바스크립트의 데이터로 변환한다.
		- JSON.stringify()메서드 : (문자열화)  자바스크립트의 데이터를 문자열로 변환한다.
		
	*/

	      
    $(document).ready(function(){
    	var product={
    		"productCode" : "000-1362",
    		"productName" : "samsung smart TV",
    		"stock" : 777,
    		"isSoldout" : false,
    		"size" : [30,50,70]
    			
    	};
    	
    	console.log(product);
    	console.log("");
    	
    	var member = {
    			"memberId" : "admin",
    			"memberAge" : 20,
    			"mameberAddress" :"강남구 역삼동",
    			"memberContact" : "010-1234-5678"
    			
    			
    	};
    	console.log(member);
    	console.log("");
    	
    	
    	var orderList = {
    			
    		"orderList" : [
    			{"code" : "0x001","name" : "스마트 TV"} , 
    			{"code" : "0x002", "name" : "스마트 냉장고"} , 
    			{"code" : "0x003", "name" : "스마트 세탁기"}
    			
    		]	
    			
    	};
    	console.log(orderList);
    	console.log("");
    	
    	
    	
    	JSON.stringify(); // 문자열화 시키다.
    	
    	
    	
    });
	
</script>
</head>
<body>
</body>
</html>