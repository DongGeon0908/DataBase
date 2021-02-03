use Hotel;
show tables;
select * from reservation;

# 연산자 operator

/* 산술 연산자 arithmetic operator
- +
- -
- *
- /
- div
- % or mod
*/

SELECT 504.7 + 13,
504.7 * 0.9,
504.7 / 2,
504.7 DIV 2,
504.7 % 2;

/* 연산자의 우선순위 operator precedence
1	INTERVAL
2	BINARY, COLLATE
3	!
4	- (단항 연산자), ~ (비트 연산자)
5	^
6	*, /, DIV, %, MOD
7	- (이항 연산자), +
8	<<, >>
9	&
10	|
11	= (관계 연산자), <=>, >=, >, <=, <, <>, !=, IS, LIKE, REGEXP, IN
12	BETWEEN, CASE, WHEN, THEN, ELSE
13	NOT
14	AND, &&
15	XOR
16	OR, ||
17	= (대입 연산자), :=
*/

/* 대입 연산자 assignment operator
- 변수에 값을 대입할 때 사용하는 이항 연산자
- =
- :=
*/

update reservation set RoomNum = 504;

/* 비교 연산자 comparison operator
- 피연산자 사이의 상대적인 크기를 판단하여
- 참(true)이면 1을 반환하고 거짓(false)이면 0을 반환

- =	
- !=, <>	
- <
- <=	
- >	
- >=	
- <=>	
- IS	
- IS NOT	
- IS NULL	
- IS NOT NULL
- BETWEEN min AND max	
- NOT BETWEEN min AND max	
- IN()	
- NOT IN()	
*/

SELECT 3 = 3,     
0 = NULL,        
1 IS TRUE,        
1 IS NULL, 
3 BETWEEN 2 AND 7, 
5 IN (2, 3, 4, 5); 

/* 논리 연산자 logical operator
- 논리식을 판단하여, 참(true)이면 1을 반환하고 거짓(false)이면 0을 반환
- AND	
- &&	
- OR	
- ||	
- XOR	
- NOT	
- !	
*/

SELECT NOT 0,
1 AND 1,      
0 OR 0,     
1 XOR 0;     

/* 비트 연산자 bitwise operator
- 논리 연산자와 비슷하지만, 비트(bit) 단위로 논리 연산을 수행
- 비트 단위로 전체 비트를 왼쪽이나 오른쪽으로 이동시킬 때도 사용

- &	
- |	
- ^	
- ~	
- <<	
- >>
*/

SELECT b'1000' & b'1111', 
b'1000' | b'1111',        
b'1000' ^ b'1111',       
b'1100' >> 1,             
b'1100' >> 2;            

/* 흐름 제어
- CASE
- IF()
- IFNULL()\
- NULLIF()
*/

/* CASE
- 값을 서로 비교하거나, 표현식의 논리값에 따라 다른 값을 반환
*/

SELECT CASE 0
    WHEN 0 THEN 'zero'
    WHEN 1 THEN 'one'
    ELSE 'more'
END;

/* IF()
-  첫 번째 인수로 전달받은 표현식의 논리값에 따라 다른 값을 반환
*/

SELECT IF(0 < 1, 'yes', 'no');

/* IFNULL()
- 첫 번째 인수로 전달받은 값이 NULL인지 아닌지를 검사하여 다른 값을 반환
*/

SELECT IFNULL(NULL, '전달받은 값이 null입니다.');

/* NULLIF()
- 인수로 전달받은 두 값이 서로 같은지를 검사하여 다른 값을 반환
*/

SELECT NULLIF(3, 3);

/* 패턴 매칭 pattern matching
- LIKE
- REGEXP
*/

/* LIKE
- 특정 패턴을 포함하는 데이터만을 검색하기 위해 사용
*/

SELECT * FROM Reservation WHERE Name LIKE '장%';

/* NOT LIKE
- 만약 특정 패턴을 포함하지 않는 데이터를 검색하고 싶을 때
*/

SELECT * FROM Reservation WHERE Name NOT LIKE '장%';

/* 와일드카드 wildcard
-  문자열 내에서 임의의 문자나 문자열을 대체하기 위해 사용되는 기호
- %
- _
*/

SELECT * FROM Reservation WHERE RoomNum LIKE '20__';

/* REGEXP
- 정규 표현식을 토대로 하는 패턴 매칭 연산을 제공

- .	줄 바꿈 문자(\n)를 제외한 임의의 한 문자를 의미함.
- *	해당 문자 패턴이 0번 이상 반복됨.
- +	해당 문자 패턴이 1번 이상 반복됨.
- ^	문자열의 처음을 의미함.
- $	문자열의 끝을 의미함.
- |	선택을 의미함.(OR)
- [...]	괄호([]) 안에 있는 어떠한 문자를 의미함.
- [^...]	괄호([]) 안에 있지 않은 어떠한 문자를 의미함.
- {n}	반복되는 횟수를 지정함.
- {m,n} 반복되는 횟수의 최솟값과 최댓값을 지정함.	
*/

SELECT * FROM Reservation WHERE Name REGEXP '^홍|산$';

/* NOT REGEXP
- 해당 패턴과 일치하지 않는 데이터를 찾고 싶을 때
*/

SELECT * FROM Reservation WHERE Name NOT REGEXP '^홍|산$';

/* 타입 변환 type casting
- 비교나 검색을 수행할 때 데이터의 타입이 서로 다를 경우, 내부적으로 타입이 같아지도록 자동 변환하여 처리
- BINARY
- CAST()
- CONVERT()
*/

/* BINARY
- 문자열을 바이너리 문자열로 변환
- 문자가 아닌 바이트를 기준으로 하여 비교나 검색 작업을 수행
*/

SELECT BINARY 'a' = 'A', 'a' = 'A';

/* CAST()
- 인수로 전달받은 값을 명시된 타입으로 변환하여 반환
- 변환하고자 하는 타입을 AS 절을 이용하여 직접 명시

AS 절에서 사용할 수 있는 타입
1. BINARY
2. CHAR
3. DATE
4. DATETIME
5. TIME
6. DECIMAL
7. JSON (MySQL 5.7.8부터 제공됨)
8. NCHAR
9. SIGNED [INTEGER]
10. UNSIGNED [INTEGER]
*/

SELECT 4 / '2', 4 / 2, 4 / CAST('2' AS UNSIGNED);

/* CONVERT()
- CAST() 함수처럼 인수로 전달받은 값을 명시된 타입으로 변환하여 반환
- 두 번째 인수로 변환하고자 하는 타입을 직접 전달
*/

SELECT CONVERT('abc' USING utf8);