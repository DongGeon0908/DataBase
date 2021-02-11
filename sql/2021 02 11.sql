use Hotel;
show tables;

/* 제약 조건 constraint 
- 데이터의 무결성을 지키기 위해, 데이터를 입력받을 때 실행되는 검사 규칙

1. NOT NULL
2. UNIQUE
3. PRIMARY KEY
4. FOREIGN KEY
5. DEFAULT

- create, insert에서 사용
*/

/* NOT NULL
- 해당 필드는 NULL 값을 저장할 수 없음
- 해당 필드는 무조건 데이터를 가지고 있어야함
*/

# create 문에서
CREATE TABLE Test
(
    ID INT NOT NULL,
    Name VARCHAR(30),
    ReserveDate DATE,
    RoomNum INT
);

INSERT INTO Test (Name, ReserveDate, RoomNum)
VALUES('이순신', '2016-02-16', 1108);

# alter 문에서
ALTER TABLE Reservation 
MODIFY COLUMN Name VARCHAR(30) NOT NULL;

/* UNIQUE
- 중복된 값을 저장할 수 없음
*/

# create 문에서
CREATE TABLE Test 
(
    ID INT UNIQUE,
    Name VARCHAR(30),
    ReserveDate DATE,
    RoomNum INT
);

# alter 문에서
ALTER TABLE Reservation ADD CONSTRAINT reservedRoom UNIQUE (RoomNum);

# reservedRoom이라는 UNIQUE 제약 조건의 이름을 사용하여, 해당 제약 조건을 삭제
ALTER TABLE Reservation DROP INDEX reservedRoom;

/* 기본 키 PRIMARY KEY
- 해당 필드는 NOT NULL과 UNIQUE 제약 조건의 특징  모두 가짐
- NULL 값을 가질 수 없으며, 또한 중복된 값을 갖지 않음
*/

# create문에서 Test 테이블에서 ID를 기본키로
CREATE TABLE Test 
(
    ID INT PRIMARY KEY,
    Name VARCHAR(30),
    ReserveDate DATE,
    RoomNum INT
);

# alter문에서 Test 테이블에서 ID를 기본키로
ALTER TABLE Reservation CONSTRAINT CustomerID ADD PRIMARY KEY (ID);

# reservation 테이블에서 PRIMARY KEY 제약 조건을 삭제
ALTER TABLE Reservation DROP PRIMARY KEY;

/* 외래 키 FOREIGN KEY
- 한 테이블을 다른 테이블과 연결해주는 역할
- 하나의 테이블을 다른 테이블에 의존하게 만듭
*/

# Test2 테이블의 ParentID 필드에 Test1 테이블의 ID 필드를 참조하는 FOREIGN KEY 제약 조건을 설정
CREATE TABLE Test2
(
    ID INT,
    ParentID INT,
    FOREIGN KEY (ParentID)
    REFERENCES Test1(ID) ON UPDATE CASCADE
);

# Reservation 테이블의 ID 필드에 Customer 테이블의 ID 필드를 참조하는 FOREIGN KEY 제약 조건을 설정하는 예제
ALTER TABLE Reservation
ADD CONSTRAINT CustomerID
FOREIGN KEY (ID)
REFERENCES Customer (ID);

# Reservation 테이블의 ID 필드에 설정된 FOREIGN KEY 제약 조건을 삭제
ALTER TABLE Reservation
DROP FOREIGN KEY CustomerID;

/* ON DELETE
- 참조되는 테이블의 값이 삭제될 경우의 동작
*/

/* ON UPDATE
- 참조되는 테이블의 값이 수정될 경우의 동작
*/

/*
1. CASCADE : 참조되는 테이블에서 데이터를 삭제하거나 수정하면, 참조하는 테이블에서도 삭제와 수정이 같이 이뤄짐
2. SET NULL : 참조되는 테이블에서 데이터를 삭제하거나 수정하면, 참조하는 테이블의 데이터는 NULL로 변경
3. NO ACTION : 참조되는 테이블에서 데이터를 삭제하거나 수정해도, 참조하는 테이블의 데이터는 변경되지 않음
4. SET DEFAULT : 참조되는 테이블에서 데이터를 삭제하거나 수정하면, 참조하는 테이블의 데이터는 필드의 기본값으로 설정
5. RESTRICT : 참조하는 테이블에 데이터가 남아 있으면, 참조되는 테이블의 데이터를 삭제하거나 수정할 수 없음
*/

# Test 테이블의 ID 필드를 Customer 테이블의 ID 필드를 참조하는 외래 키로 설정하는 예제
CREATE TABLE Test2
(
    ID INT,
    ParentID INT, 
    FOREIGN KEY (ParentID)
    REFERENCES Test1(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);

/* DEFAULT
- 해당 필드의 기본값을 설정
- 레코드를 입력할 때 해당 필드 값을 전달하지 않으면, 자동으로 설정된 기본값을 저장
*/

# CREATE TABLE 문을 사용하여 Test 테이블을 생성하면서 Name 필드에 DEFAULT 제약 조건을 이용하여 기본값을 설정
CREATE TABLE Test
(
    ID INT,
    Name VARCHAR(30) DEFAULT 'Anonymous',
    ReserveDate DATE,
    RoomNum INT
);

# ALTER TABLE 문을 사용하여 Reservation 테이블의 Name 필드에 DEFAULT 제약 조건을 이용하여 기본값을 설정
ALTER TABLE Reservation
ALTER Name SET DEFAULT 'Anonymous';

# Reservation 테이블의 Name 필드에 설정된 DEFAULT 제약 조건을 삭제
ALTER TABLE Reservation
ALTER Name DROP DEFAULT;