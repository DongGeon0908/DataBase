use Hotel;

/* 타입 data type
- 테이블을 정의할 때는 필드별로 저장할 수 있는 타입까지 명시

- 기본 타입
1. 숫자 타입
2. 문자열 타입
3. 날짜와 시간 타입

- 숫자 타입 numeric types
1. 정수 타입(integer types)
2. 고정 소수점 타입(fixed-point types)
3. 부동 소수점 타입(floating-point types)
4. 비트값 타입(bit-value type)
*/

/* 정수 타입 integer types
- 각 정수 타입에 따라 요구되는 저장 공간과 표현할 수 있는 최댓값과 최솟값이 달라짐

1. TINYINT
2. SMALLINT
3. MEDIUMINT
4. INT
5. BIGINT
*/

# Reservation 테이블에 4바이트의 정수를 저장할 수 있는 Price 필드를 추가
alter table Reservation add price int;

/* 고정 소수점 타입 fixed-point types
- 고정 소수점 타입인 DECIMAL은 실수의 값을 정확하게 표현하기 위해 사용
- 소수부의 자릿수를 미리 정해 놓고, 고정된 자릿수로만 소수 부분을 표현하는 방식
*/

#  ALTER TABLE 문을 사용하여 Reservation 테이블의 RoomNum 필드 타입을 고정 소수점 타입으로 변경
alter table Reservation modify column RoomNum decimal(7, 2);

/* 부동 소수점 타입 floating-point types
- 부동 소수점 타입인 FLOAT과 DOUBLE은 실수의 값을 대략적으로 표현하기 위해 사용
- FLOAT는 정밀도에 필요한 최소한의 비트 수를 명시
*/

# Reservation 테이블의 RoomNum 필드 타입을 부동 소수점 타입으로 변경
alter table Reservation modify column RoomNum float(7, 2);

/* 비트값 타입 bit-value type
- 비트값 타입인 BIT는 비트의 값을 저장
- 0과 1로 구성되는 바이너리 `binary` 값을 저장
*/

# Reservation 테이블에 BIT(7) 타입을 저장할 수 있는 Code 필드를 추가
alter table Reservation add Code BIT(7);

/* BIN()
- 바이너리 값을 출력하기 위해 사용하는 변환 함수
*/

/* 문자열 타입
1. CHAR와 VARCHAR
2. BINARY와 VARBINARY
3. BLOB과 TEXT
4. ENUM
5. SET
*/

/* CHAR
- 문자열을 길이가 한 번 설정되면 그대로 고정되는 고정 길이의 문자열
- 설정한 크기보다 작은 길이의 문자열이 입력되면, 나머지 공간을 공백으로 채워 길이를 같게 만듬
*/

ALTER TABLE Reservation ADD Note CHAR(4);
INSERT INTO Reservation(Note) VALUES(' ');
INSERT INTO Reservation(Note) VALUES('ab');
INSERT INTO Reservation(Note) VALUES('abcd');
INSERT INTO Reservation(Note) VALUES('abcdefgh');

/* VARCHAR
- 문자열을 길이가 고정되지 않는 가변 길이의 문자열
- 실제 입력된 문자열의 길이만큼만 저장하고 사용
*/

ALTER TABLE Reservation MODIFY COLUMN Note VARCHAR(4);
INSERT INTO Reservation(Note) VALUES(' ');
INSERT INTO Reservation(Note) VALUES('ab');
INSERT INTO Reservation(Note) VALUES('abcd');
INSERT INTO Reservation(Note) VALUES('abcdefgh');

# BINARY와 VARBINARY는 문자 집합이 아닌 바이너리(binary) 데이터를 저장할 때 사용

/* BLOB binary large object
- 다양한 크기의 바이너리 데이터를 저장할 수 있는 타입
- 저장할 수 있는 데이터의 최대 크기에 따라 TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB로 구분
*/

/* TEXT
- ARCHAR와 비슷하지만, VARCHAR와는 달리 기본값을 가질 수 없음
- BLOB과는 달리 문자열의 대소문자를 구분
- 저장할 수 있는 데이터의 최대 크기에 따라 TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT로 구분
*/

# Reservation 테이블에 TEXT 타입인 Note 필드를 추가
alter table Reservation add column Note text;

/* ENUM
- 미리 정의한 집합 안의 요소 중 하나만을 저장할 수 있는 타입
- 독성을 높일 수 있으며, 특정 숫자에 문자열로 의미를 부여
*/

# Reservation 테이블에 4개의 값 중 하나를 가질 수 있는 ENUM 형인 RoomType 필드를 추가
alter table Reservation add column RoomType enum("Single", "Twin", "Double", "Triple");

/* SET
- 미리 정의한 집합 안의 요소 중 여러 개를 동시에 저장할 수 있는 타입
*/

# Reservation 테이블에 3개의 값 중 여러 개를 가질 수 있는 SET 형인 Request 필드를 추가
alter table Reservation add column Request set("Breakfast", "Extra Bed", "Non-Smoking");

/* 날짜와 시간 타입
1. DATE, DATETIME, TIMESTAMP
2. TIME
3. YEAR
*/

/* DATE
- 짜를 저장할 수 있는 타입
- YYYY-MM-DD
*/

/* DATETIME
- 날짜와 함께 시간까지 저장할 수 있는 타입
- YYYY-MM-DD HH:MM:SS
*/

/* TIMESTAMP
- 날짜와 시간을 나타내는 타임스탬프를 저장할 수 있는 타입
- 사용자가 별다른 입력을 주지 않으면, 데이터가 마지막으로 입력되거나 변경된 시간이 저장
- 저장할 수 있는 범위는 '1970-01-01 00:00:01' UTC부터 '2038-01-19 03:14:07' UTC까지
*/

# Reservation 테이블의 ReserveDate 필드의 타입을 DATETIME 타입으로 변경
alter table Reservation modify column ReserveDate datetime;

/* TIME
- 시간을 저장할 수 있는 타입
- HH:MM:SS
- HHH:MM:SS
- 저장할 수 있는 시간의 범위는 -838:59:59 부터 838:59:59 까지
*/

# Reservation 테이블에 TIME 타입인 CheckIn 필드를 추가
alter table Reservation add column Checkin time;

/* YEAR
- 연도를 저장할 수 있는 타입
- YEAR(2)는 2자리의 연도를 저장
- YEAR(4)는 4자리의 연도를 저장
- 4자리 숫자로 저장하면, 저장할 수 있는 범위는 1901년부터 2155년까지
- 유효하지 않은 연도는 0000 으로 저장
*/

# Reservation 테이블에 YEAR 타입인 ThisYear 필드를 추가
alter table Reservation add column ThisYear year;