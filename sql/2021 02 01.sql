use Hotel;

/* drop 
- drop database
데이터베이스를 삭제

- drop table
테이블을 삭제
테이블을 삭제하면 해당 테이블의 모든 데이터도 다 같이 삭제
*/

# Hotel 데이터베이스를 삭제
drop database Hotel;

/* truncate table
테이블 자체는 그대로 남게 되며, 해당 테이블에 저장된 데이터만이 모두 삭제
*/

# Reservation 테이블의 모든 데이터만을 삭제하
truncate table Reservation;

# Reservation 테이블의 모든 데이터뿐만 아니라 테이블 그 자체도 삭제
drop table Reservation;

/* IF EXISTS
- 삭제하려는 데이터베이스나 테이블이 존재하지 않아서 발생하는 에러를 미리 방지
*/

drop database if exists Hotel;
drop table if exists Reservation;

/* INSERT INTO
- 테이블에 새로운 레코드를 추가
- VALUES 절을 사용하여 해당 테이블에 새로운 레코드를 추가

- 필드의 이름을 생략할 수 있으며, 이 경우에는 데이터베이스의 스키마와 같은 순서대로 필드의 값이 자동 대입
1. NULL을 저장할 수 있도록 설정된 필드
2. DEFAULT 제약 조건이 설정된 필드
3. AUTO_INCREMENT 키워드가 설정된 필드
*/

# Reservation 테이블에 새로운 레코드를 추가
insert into Reservation(ID, Name, ReserveDate, RoomNum) Values(5, '이순신', '2020-02-01', 1108);

# 추가하는 레코드가 반드시 모든 필드의 값을 가져야 할 필요는 없음
insert into reservation(ID, Name) values(6, '김유신');

/* update
- 레코드의 내용을 수정
- 해당 테이블에서 WHERE 절의 조건을 만족하는 레코드의 값만을 수정
*/

# Reservation 테이블에서 Name 필드의 값이 '홍길동'인 모든 레코드의 RoomNum 값을 2002로 변경
update Reservation set RoomNum = 2002 where Name = "홍길동";

# where절이 없다면, 해당 테이블의 모든 레코드의 RoomNum 필드값이 변경됨
update Reservation set RoomNum = 2002;

/* delete
- 테이블의 레코드 삭제
- where절을 생략하면, 해당 테이블에 저장된 모든 데이터 삭제
*/

# Reservation 테이블에서 Name 필드의 값이 '홍길동'인 모든 레코드를 삭제
delete from Reservation where Name = "홍길동";

/* select
- 테이블의 레코드 선택alter
*/

# Reservation 테이블의 모든 필드를 선택
select * from Reservation;

# Name 필드의 값이 '홍길동'인 레코드만을 선택
select * from Reservation where Name = "홍길동";

# 여러 개의 조건은 And 또는 Or 연산자를 통해 연결

# ID 값이 3 이하이면서 ReserveDate 필드의 값이 2016년 2월 1일 이후인 레코드만을 선택
select * from Reservation where ID <= 3 and ReserveDate > "2016-02-01";

# 쉼표(,)를 사용하여 여러 개의 필드 이름을 한 번에 명시

# Reservation 테이블에서 Name 필드와 RoomNum 필드만을 선택
select Name, RoomNum from Reservation;

# WHERE 문을 사용하여 특정 조건을 만족하는 레코드만을 선택

# ID 값이 3 이하이면서 ReserveDate 필드의 값이 2016년 2월 1일 이후인 레코드의 Name 필드와 ReserveDate 필드만을 선택
select Name, ReserveDate from Reservation where ID <= 3 and ReserveDate > '2016-02-01';

/* DISTINCT
- 그 값이 한 번만 선택되도록 설정
- 중복 제거
*/

# Reservation 테이블에서 Name 필드를 선택
select distinct Name from Reservation;

/* ORDER BY 
- ORDER BY 절의 기본 설정은 오름차순이며, ASC 키워드를 사용하여 직접 오름차순을 명시
- 내림차순으로 정렬하고자 할 때는 맨 마지막에 DESC 키워드를 추가
*/

# Reservation 테이블의 모든 레코드를 ReserveDate 필드의 오름차순으로 정렬하여 선택
select * from Reservation order by ReserveDate;

# Reservation 테이블의 모든 레코드를 ReserveDate 필드의 내림차순으로 정렬하여 선택
select * from Reservation order by ReserveDate desc;

/* ORDER BY BINARY
- 대소문자까지 구분하여 정렬
*/

# Reservation 테이블의 모든 레코드를 먼저 ReserveDate 필드의 내림차순으로 정렬한 뒤에, 또다시 RoomNum 필드의 내림차순으로 정렬하여 선택
select * from Reservation order by ReserveDate desc, RoomNum asc;

/* alias
- 테이블과 필드에 임시로 별칭을 부여
- 별칭을 SELECT 문에서 사용 가능
*/

# Reservation 테이블의 RoomNum 필드와 Name 필드에 하나의 새로운 별칭을 부여
select ReserveDate, concat(RoomNum, " : ", Name) as ReserveInfo from Reservation;

/* CONCAT() 
- 함수는 인수로 전달받은 문자열을 모두 결합하여 하나의 문자열로 반환하는 함수
*/