# Mysql은 키워드와 구문에서 대소문자를 구분하지 않음

# 한 줄 주석

-- 한 줄 주석

/* 두 줄
   이상의
   주석 */
   
/* 주요구문
1. CREATE DATABASE
2. ALTER DATABASE
3. CREATE TABLE
4. ALTER TABLE
5. DROP TABLE
6. INSERT INTO
7. UPDATE
8. DELETE
9. SELECT
10. CREATE INDEX
11. DROP INDEX
*/ 

# 기본셋팅
CREATE TABLE Reservation(ID INT, Name VARCHAR(30), ReserveDate DATE, RoomNum INT);
CREATE TABLE Customer (ID INT, Name VARCHAR(30), Age INT, Address VARCHAR(20));

INSERT INTO Reservation(ID, Name, ReserveDate, RoomNum) VALUES(1, '홍길동', '2016-01-05', 2014);
INSERT INTO Reservation(ID, Name, ReserveDate, RoomNum) VALUES(2, '임꺽정', '2016-02-12', 918);
INSERT INTO Reservation(ID, Name, ReserveDate, RoomNum) VALUES(3, '장길산', '2016-01-16', 1208);
INSERT INTO Reservation(ID, Name, ReserveDate, RoomNum) VALUES(4, '홍길동', '2016-03-17', 504);
 
INSERT INTO Customer (ID, Name, Age, Address) VALUES (1, '홍길동', 17, '서울');
INSERT INTO Customer (ID, Name, Age, Address) VALUES (2, '임꺽정', 11, '인천');
INSERT INTO Customer (ID, Name, Age, Address) VALUES (3, '장길산', 13, '서울');
INSERT INTO Customer (ID, Name, Age, Address) VALUES (4, '전우치', 17, '수원');

# 새로운 데이터베이스 생성
create database Hotel;

# 데이터베이스 선택
use hotel;

# 테이블 생성
create table Test
(
    id int,
    Name varchar(30),
    ReserveDate date,
    RoomNum int
);

# 생성된 테이블 목록 확인
show tables;

# 테이블 상제 정보 확인
describe Test;
desc Test;

/* 제약조건 constraint
데이터의 무결성을 지키기 위해 데이터를 입력받을 때 실행되는 검사 규칙

CREATE TABLE 문에서 사용할 수 있는 제약 조건

1. NOT NULL : 해당 필드는 NULL 값을 저장할 수 없음
2. UNIQUE : 해당 필드는 서로 다른 값을 가져야함
3. PRIMARY KEY : 해당 필드가 NOT NULL과 UNIQUE 제약 조건의 특징을 모두 가짐
4. FOREIGN KEY : 하나의 테이블을 다른 테이블에 의존
5. DEFAULT : 해당 필드의 기본값을 설정
*/

/* ALTER
데이터베이스와 테이블의 내용을 수정
- add
- drop
- modify column
*/

# 데이터베이스의 특성은 데이터베이스 디렉터리의 db.opt 파일에 저장되어 있음

# 콜레이션(collation)이란 데이터베이스에서 검색이나 정렬과 같은 작업을 할 때 사용하는 비교를 위한 규칙의 집합을 의미

# Hotel 데이터베이스의 문자 집합과 콜레이션을 변경하는 예제
ALTER DATABASE Hotel CHARACTER SET=euckr_bin COLLATE=euckr_korean_ci;

/* CHARACTER SET
- utf8 : UTF-8 유니코드를 지원하는 문자셋 (1~3바이트)
- euckr : 한글을 지원하는 문자셋 (1~2바이트)
*/

/* COLLATE
- utf8_bin
- utf8_general_ci (기본 설정)
- euckr_bin
- euckr_korean_ci
*/

# Reservation 테이블에 타입이 INT인 Phone 필드를 추가
alter table Reservation add Phone int;

# Reservation 테이블에서 RoomNum 필드를 삭제
alter table Reservation drop RoomNum;

# Reservation 테이블의 ReserveDate 필드 타입을 DATE에서 VARCHAR(20)으로 변경
alter table Reservation modify column ReserveDate varchar(20);