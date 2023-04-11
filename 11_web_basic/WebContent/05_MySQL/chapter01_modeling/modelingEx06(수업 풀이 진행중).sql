/*

	# 제약 조건
	
		- NOT NULL : NULL 금지
		- UNIQUE   : 중복값입력 금지(NULL은 중복가능)
		- DEFAULT  : 초깃값 입력
		- PRIMARY KEY(PK) : 
							테이블에 유일하게 구분되는 키로 주 식별자, 주키 등으로 불린다.
							PRIMARY KEY는 유일한 값이기 때문에 중복된 값을 가질 수 없으며 NULL 값이 입력될 수 없다. (NOT NULL과 UNIQUE 제약 조건의 특징을 모두 가진다.)
							
		 - FOREIGN KEY(FK)  :
							외부키, 참조키, 외부 식별자 등으로 불린다.
							FOREIGN KEY 는 외부 테이블에서 참고하려는 주 키 (primary key) 를 의미한며 테이블으을 연결해주는 역할을 한다.
							FOREIGN KEY 는 참조관계의 기본 키와 같은 속성을 가진다.
							'외래 키 테이블'에 데이터를 입력할 때는 꼭 '기준 테이블'을 참조해서 입력하므로 반드시 '기준 테이블'에 존재하는 데이터만 입력이 가능하다.
							'외래 키 테이블'이 참조하는 '기준 테이블'의 열은 반드시 PK이거나 UNIQUE 제약 조건이 설정되어 있어야 한다.
		
        [ 형식 ]
	
		  (CONSTRAINT [CONSTRAINT_NAME]생략가능) FOREIGN KEY (자식 테이블 컬럼 명) REFERENCES 참조테이블(부모 테이블 기본키명) 
		  ON UPDATE 옵션 ON DELETE 옵션
		  
            - 옵션 상세
          
			 CASCADE     : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블에서도 삭제와 수정이 같이 이루어짐
			 SET NULL    : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블의 데이터는 NULL로 변경됨
			 RESTRICT    : 참조하는 테이블에 데이터가 남아 있으면 참조되는 테이블의 데이터를 삭제하거나 수정할 수 없음(기본설정)
             NO ACTION   : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블의 데이터는 변경되지 않음


	 # ERD Diagram 생성하기
	 
	 	- Database태그 > Reverse Engineer > Stored Connection 선택 및 username , password 인증 > schemas 선택

*/

CREATE DATABASE CONSTRAINTS_TEST;
USE CONSTRAINTS_TEST;



# 0) 제약사항 없음
CREATE TABLE TEST0 (
	PRODUCT_CD INT,
    PRODUCT_NM VARCHAR(20),
    PRICE	   INT,
    REG_DT     TIMESTAMP
);

INSERT INTO TEST0 VALUES(1, '상품1', 1000 , NOW()); 		# SUCCESS				  	
INSERT INTO TEST0(PRODUCT_NM , PRICE , REG_DT) VALUES('상품2', 2000 , NOW()); # SUCCESS 
INSERT INTO TEST0(PRODUCT_CD , PRICE , REG_DT) VALUES(3, 3000 , NOW()); # SUCCESS     
INSERT INTO TEST0(PRICE , REG_DT) VALUES(4000 , NOW()); # SUCCESS     				  
INSERT INTO TEST0(REG_DT) VALUES(NOW()); # SUCCESS									  
SELECT * FROM TEST0;


# 1) NOT NULL : NULL 입력 금지
CREATE TABLE TEST1 (
	PRODUCT_CD INT		NOT NULL, #무조건 데이터가 들어가야 한다.
    PRODUCT_NM VARCHAR(20)     	NOT NULL,
    PRICE	   INT,
    REG_DT     TIMESTAMP
);

INSERT INTO TEST1 VALUES(1, '상품1', 1000 , NOW()); # SUCCESS							 
INSERT INTO TEST1(PRODUCT_NM , PRICE , REG_DT) VALUES('상품2', 2000 , NOW()); # ERROR
INSERT INTO TEST1(PRODUCT_CD , PRICE , REG_DT) VALUES(3, 3000 , NOW());   #ERROR 
INSERT INTO TEST1(PRICE , REG_DT) VALUES(4000 , NOW());    #ERROR  				
INSERT INTO TEST1(REG_DT) VALUES(NOW()); #ERROR					 
INSERT INTO TEST1(PRODUCT_CD , PRODUCT_NM) VALUES(6 , '상품6'); 	#SUCCESS		 

SELECT * FROM TEST1;


# 2) UNIQUE : 중복데이터 입력 금지 ( NULL 값은 중복으로 인식하지 않는다. )
CREATE TABLE TEST2 (
	PRODUCT_CD INT		UNIQUE,		
    PRODUCT_NM VARCHAR(20)   	UNIQUE, 
    PRICE	   INT,
    REG_DT     TIMESTAMP
);

INSERT INTO TEST2 VALUES(1, '상품1', 1000 , NOW());  # SUCCESS	 
INSERT INTO TEST2(PRODUCT_NM , PRICE , REG_DT) VALUES('상품2', 2000 , NOW()); # SUCCESS
INSERT INTO TEST2(PRODUCT_CD , PRICE , REG_DT) VALUES(3, 3000 , NOW());  # SUCCESS   
INSERT INTO TEST2(PRICE , REG_DT) VALUES(4000 , NOW());  # SUCCESS     				
INSERT INTO TEST2(REG_DT) VALUES(NOW()); 	#SUCCESS					
INSERT INTO TEST2(PRODUCT_CD , PRODUCT_NM) VALUES(1 , '상품6'); # ERROR				
INSERT INTO TEST2(PRODUCT_CD , PRODUCT_NM) VALUES(7 , '상품1'); # ERROR		
SELECT * FROM TEST2;



# 3) DEFAULT : 초깃값 지정
CREATE TABLE TEST3 (
	PRODUCT_CD INT,
    PRODUCT_NM VARCHAR(20),
    PRICE	   INT		DEFAULT 0,		
    REG_DT     TIMESTAMP DEFAULT '2023-01-01'
);

INSERT INTO TEST3 VALUES(1, '상품1', 1000 , NOW()); 	#SUCCESS						 
INSERT INTO TEST3(PRODUCT_CD , PRODUCT_NM) VALUES(2 , '상품2'); #SUCCESS 				
INSERT INTO TEST3(PRODUCT_CD , PRODUCT_NM) VALUES(3 , '상품3'); 	#SUCCESS		
INSERT INTO TEST3 VALUES(4 , '상품4' , 4000 , '2022-12-31');	#SUCCESS		
SELECT * FROM TEST3;




# 4) AUTO_INCREMENT : 인덱스 자동증가 (PRIMARY KEY 속성과 같이 사용한다.)
CREATE TABLE TEST4 (
	PRODUCT_CD INT AUTO_INCREMENT PRIMARY KEY, 
    PRODUCT_NM VARCHAR(20),
    PRICE	   INT,
    REG_DT     TIMESTAMP 
);

INSERT INTO TEST4 VALUES(1, '상품1', 1000 , NOW()); # SUCCESS 			     
INSERT INTO TEST4(PRODUCT_NM) VALUES('상품2'); # SUCCESS 				     
INSERT INTO TEST4(PRODUCT_NM) VALUES('상품3'); # SUCCESS				    
INSERT INTO TEST4 VALUES(10 , '상품10' , 10000 , '2022-12-31');	# SUCCESS 성공은 하지만 순서가 깨지게 된다.
INSERT INTO TEST4(PRODUCT_NM) VALUES('상품11');			# SUCCESS이지만 11로 인덱스 증가 순차 깨짐.....

SELECT * FROM TEST4;




# 5) PRIMARY KEY  : NOT NULL + UNIQUE
CREATE TABLE TEST5 (
	PRODUCT_CD INT, 		# 1.번째 방법 PRIMARY KEY,	
    PRODUCT_NM VARCHAR(20),
    PRICE	   INT,
    REG_DT     TIMESTAMP
    # 2.번째 방법 PRIMARY KEY(PRODUCT_CD)
);

# --------4.11일 기준 수업 풀이 여기까지 나감

INSERT INTO TEST5 VALUES(1, '상품1', 1000 , NOW()); 							 
INSERT INTO TEST5(PRODUCT_NM , PRICE , REG_DT) VALUES('상품2', 2000 , NOW()); 
INSERT INTO TEST5(PRODUCT_CD , PRICE , REG_DT) VALUES(3, 3000 , NOW());      
INSERT INTO TEST5(PRICE , REG_DT) VALUES(4000 , NOW());      				 
INSERT INTO TEST5(REG_DT) VALUES(NOW()); 									
INSERT INTO TEST5(PRODUCT_CD , PRODUCT_NM) VALUES(6 , '상품6'); 				 
INSERT INTO TEST5(PRODUCT_CD , PRODUCT_NM) VALUES(6 , '상품7'); 				
SELECT * FROM TEST5;


# 6~8) PRIMARY KEY , FOREIGN KEY

# 6) 메인키와 참조키를 사용하지 않았을 경우의 예시
CREATE TABLE TEST6_1(
	PRODUCT_CD INT,
    PRODUCT_NM VARCHAR(20),
    PRICE      INT 			   DEFAULT 0,
    REG_DT     TIMESTAMP	   DEFAULT '2023-01-01'
); 

INSERT INTO TEST6_1(PRODUCT_CD , PRODUCT_NM) VALUES (1 , '상품1'); 
INSERT INTO TEST6_1(PRODUCT_CD , PRODUCT_NM) VALUES (2 , '상품2'); 
INSERT INTO TEST6_1(PRODUCT_CD , PRODUCT_NM) VALUES (3 , '상품3'); 

CREATE TABLE TEST6_2(
	ORDER_CD  VARCHAR(10),
    MEMBER_ID VARCHAR(20),
    PRODUCT_CD INT
);

INSERT INTO TEST6_2 VALUES ('O1' , '유저1' , 1); 
INSERT INTO TEST6_2 VALUES ('O2' , '유저2' , 2); 
INSERT INTO TEST6_2 VALUES ('O3' , '유저3' , 3);
INSERT INTO TEST6_2 VALUES ('O4' , '유저3' , 3); 
INSERT INTO TEST6_2 VALUES ('O5' , '유저3' , 3);  
INSERT INTO TEST6_2 VALUES ('O6' , '유저1' , 4); 
INSERT INTO TEST6_2 VALUES ('O7' , '유저2' , 5);

UPDATE TEST6_1 SET PRODUCT_CD = 11 WHERE PRODUCT_CD = 1;
UPDATE TEST6_1 SET PRODUCT_CD = 22 WHERE PRODUCT_CD = 2;
DELETE FROM TEST6_1 WHERE PRODUCT_CD = 3;     

SELECT * FROM TEST6_1;
SELECT * FROM TEST6_2;



# 7) 메인키와 참조키 설정 예시
CREATE TABLE TEST7_1(
	PRODUCT_CD INT , 	
    PRODUCT_NM VARCHAR(20),
    PRICE      INT 			   DEFAULT 0,
    REG_DT     TIMESTAMP	   DEFAULT '2023-01-01'
); 

INSERT INTO TEST7_1(PRODUCT_CD , PRODUCT_NM) VALUES (1 , '상품1'); 
INSERT INTO TEST7_1(PRODUCT_CD , PRODUCT_NM) VALUES (2 , '상품2'); 
INSERT INTO TEST7_1(PRODUCT_CD , PRODUCT_NM) VALUES (3 , '상품3'); 

CREATE TABLE TEST7_2(
	ORDER_CD  VARCHAR(10),
    MEMBER_ID VARCHAR(20),
    PRODUCT_CD INT
);

INSERT INTO TEST7_2 VALUES ('O1' , '유저1' , 1); 
INSERT INTO TEST7_2 VALUES ('O2' , '유저2' , 2); 
INSERT INTO TEST7_2 VALUES ('O3' , '유저3' , 3);
INSERT INTO TEST7_2 VALUES ('O4' , '유저3' , 3); 
INSERT INTO TEST7_2 VALUES ('O5' , '유저3' , 3);  
INSERT INTO TEST7_2 VALUES ('O6' , '유저1' , 4); 	
INSERT INTO TEST7_2 VALUES ('O7' , '유저2' , 5); 

UPDATE TEST7_1 SET PRODUCT_CD = 11 WHERE PRODUCT_CD = 1;
UPDATE TEST7_1 SET PRODUCT_CD = 22 WHERE PRODUCT_CD = 2;
DELETE FROM TEST7_1 WHERE PRODUCT_CD = 3;              

SELECT * FROM TEST7_1;
SELECT * FROM TEST7_2;



# 8) 메인키와 참조키 옵션 적용 예시
CREATE TABLE TEST8_1(
	PRODUCT_CD INT,
    PRODUCT_NM VARCHAR(20),
    PRICE      INT 		   DEFAULT 10000,
    REG_DT     TIMESTAMP   DEFAULT NOW()
); 

INSERT INTO TEST8_1(PRODUCT_CD , PRODUCT_NM) VALUES (1 , '상품1'); 
INSERT INTO TEST8_1(PRODUCT_CD , PRODUCT_NM) VALUES (2 , '상품2'); 
INSERT INTO TEST8_1(PRODUCT_CD , PRODUCT_NM) VALUES (3 , '상품3'); 

CREATE TABLE TEST8_2(
	ORDER_CD  VARCHAR(10),
    MEMBER_ID VARCHAR(20),
    PRODUCT_CD INT
);

INSERT INTO TEST8_2 VALUES ('O1' , '유저1' , 1); 
INSERT INTO TEST8_2 VALUES ('O2' , '유저2' , 2); 
INSERT INTO TEST8_2 VALUES ('O3' , '유저3' , 3);
INSERT INTO TEST8_2 VALUES ('O4' , '유저3' , 3); 
INSERT INTO TEST8_2 VALUES ('O5' , '유저3' , 3);  
INSERT INTO TEST8_2 VALUES ('O6' , '유저1' , 4); 	
INSERT INTO TEST8_2 VALUES ('O7' , '유저2' , 5); 

UPDATE TEST8_1 SET PRODUCT_CD = 11 WHERE PRODUCT_CD = 1; 
UPDATE TEST8_1 SET PRODUCT_CD = 22 WHERE PRODUCT_CD = 2; 
DELETE FROM TEST8_1 WHERE PRODUCT_CD = 3;                

SELECT * FROM TEST8_1;
SELECT * FROM TEST8_2;
	 			
                
DROP DATABASE CONSTRAINTS_TEST;