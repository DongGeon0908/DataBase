use Hotel;
show tables;

/* JOIN
데이터베이스 내의 여러 테이블에서 가져온 레코드를 조합하여 하나의 테이블이나 결과 집합으로 표현
1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN

ON 절에서는 WHERE 절에서 사용할 수 있는 모든 조건을 사용
*/

# Reservation 테이블의 Name 필드와 Customer 테이블의 Name 필드가 서로 일치하는 레코드만을 INNER JOIN으로 가져오는 예제
SELECT *
FROM Reservation
INNER JOIN Customer
ON Reservation.Name = Customer.Name;

SELECT *
FROM Reservation
JOIN Customer
ON Reservation.Name = Customer.Name;

SELECT *
FROM Reservation, Customer
WHERE Reservation.Name = Customer.Name;

# 별칭 alias 을 사용하여 SQL 구문을 간략화
SELECT *
FROM Reservation AS r, Customer AS c
WHERE r.Name = c.Name;

/* LEFT JOIN
첫 번째 테이블을 기준으로, 두 번째 테이블을 조합하는 JOIN
- ON 절의 조건을 만족하지 않는 경우에는 첫 번째 테이블의 필드 값은 그대로 가져옴
- 해당 레코드의 두 번째 테이블의 필드 값은 모두 NULL로 표시
*/

# Reservation 테이블의 Name 필드를 기준으로 Customer 테이블의 Name 필드와 일치하는 레코드만을 LEFT JOIN으로 가져온 후, 그 중에서 ReserveDate 필드의 값이 2016년 02월 01일 이후인 레코드만을 선택
SELECT *
FROM Reservation
LEFT JOIN Customer
ON Reservation.Name = Customer.Name
WHERE ReserveDate > '2016-02-01';

/* RIGHT JOIN
LEFT 조인과는 반대로 두 번째 테이블을 기준으로, 첫 번째 테이블을 조합하는 JOIN 
*/

# Customer 테이블의 Name 필드를 기준으로 Reservation 테이블의 Name 필드와 일치하는 레코드만을 RIGHT JOIN으로 가져옴
SELECT *
FROM Reservation
RIGHT JOIN Customer
ON Reservation.Name = Customer.Name;

/* UNION 
여러 개의 SELECT 문의 결과를 하나의 테이블이나 결과 집합으로 표현할 때 사용
- 각각의 SELECT 문으로 선택된 필드의 개수와 타입은 모두 같아야함
- 필드의 순서가 같아야함
*/

# SELECT 문의 결과를 UNION을 이용하여 하나의 테이블로 출력
SELECT Name
FROM Reservation
UNION
SELECT Name
FROM Customer;

/* UNION ALL
중복되는 레코드까지 모두 출력
*/

# 두 SELECT 문의 결과를 UNION ALL을 이용하여 하나의 테이블로 출력
SELECT Name
FROM Reservation
UNION ALL 
SELECT Name
FROM Customer;

/* 서브쿼리(subquery)
다른 쿼리 내부에 포함되어 있는 SELETE 문

외부쿼리(outer query)
- 서브쿼리를 포함하고 있는 쿼리

내부쿼리(inner query)
- 서브쿼리

- 쿼리의 각 부분을 명확히 구분
- 복잡한 JOIN이나 UNION과 같은 동작을 수행할 수 있는 또 다른 방법을 제공
- 해석 편리
*/

# 주소가 서울인 고객이 예약한 예약 정보만을 선택하는 예제
SELECT ID, ReserveDate, RoomNum
FROM Reservation
WHERE Name IN (SELECT Name FROM Customer WHERE Address = '서울');

# JOIN을 사용하여 표현
SELECT r.ID, r.ReserveDate, r.RoomNum
FROM Reservation AS r, Customer AS c
WHERE c.Address = '서울' AND r.Name = c.Name;

# FROM 절의 서브쿼리
SELECT Name, ReservedRoom
FROM (SELECT Name, ReserveDate, (RoomNum + 1) AS ReservedRoom
FROM Reservation
WHERE RoomNum > 1001) AS ReservationInfo;

/* 인덱스 index 
- 테이블에서 원하는 데이터를 쉽고 빠르게 찾기 위해 사용
- 자주 사용되는 필드 값으로 만들어진 원본 테이블의 사본
- 사용자가 직접 접근할 수는 없으며, 검색과 질의에 대한 처리에서만 사용
*/

# Reservation 테이블의 Name 필드에 NameIdx라는 인덱스를 설정
CREATE INDEX NameIdx
On Reservation (Name);

/* 인덱스 정보 1. Table : 테이블의 이름을 표시함.
2. Non_unique : 인덱스가 중복된 값을 저장할 수 있으면 1, 저장할 수 없으면 0을 표시함.
3. Key_name : 인덱스의 이름을 표시하며, 인덱스가 해당 테이블의 기본 키라면 PRIMARY로 표시함.
4. Seq_in_index : 인덱스에서의 해당 필드의 순서를 표시함.
5. Column_name : 해당 필드의 이름을 표시함.
6. Collation : 인덱스에서 해당 필드가 정렬되는 방법을 표시함.
7. Cardinality : 인덱스에 저장된 유일한 값들의 수를 표시함.
8. Sub_part : 인덱스 접두어를 표시함.
9. Packed : 키가 압축되는(packed) 방법을 표시함.
10. Null : 해당 필드가 NULL을 저장할 수 있으면 YES를 표시하고, 저장할 수 없으면 ''를 표시함.
11. Index_type : 인덱스에 사용되는 메소드(method)를 표시함.
12. Comment : 해당 필드를 설명하는 것이 아닌 인덱스에 관한 기타 정보를 표시함.
13. Index_comment : 인덱스에 관한 모든 기타 정보를 표시함.
*/
SHOW INDEX
FROM 테이블이름;

/* UNIQUE INDEX
- 중복 값을 허용하지 않는 인덱스
*/

# Reservation 테이블의 ID 필드에 IdIdx라는 UNIQUE INDEX를 설정
CREATE UNIQUE INDEX IdIdx
On Reservation (ID);

/* 인덱스 정렬
DESC 키워드를 사용하면 내림차순으로 정렬
ASC 키워드를 사용하면 오름차순으로 정렬
*/

# Reservation 테이블의 Name 필드에 NameDescIdx라는 인덱스를 설정
CREATE INDEX NameDescIdx
On Reservation (Name DESC);

# Reservation 테이블의 Name 필드에 기본 인덱스를 추가
ALTER TABLE Reservation
ADD INDEX NameIdx (Name);

# Reservation 테이블의 ID 필드에 UNIQUE INDEX를 추가
ALTER TABLE Reservation
ADD UNIQUE IdIdx (ID);

# Reservation 테이블의 Name 필드에 FULLTEXT INDEX를 추가
ALTER TABLE Reservation
ADD FULLTEXT NameFtIdx (Name);

# Reservation 테이블에서 NameIdx라는 이름의 인덱스를 삭제
ALTER TABLE Reservation
DROP INDEX NameIdx;

# Reservation 테이블에서 IdIdx라는 이름의 인덱스를 삭제
DROP INDEX IdIdx
ON Reservation;