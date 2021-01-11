# SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

/* 데이터 정의어
데이터 정의를 위한 SQL문
create, alter,drop
*/

/* create
테이블 이름은 중복되지 않음
테이블의 열 이름, 데이터 유형은 반복해서 정의alter

null / not null
열마다 널 값 입력 허용 여부 정의
null -> 각 열의 데이터 유형 입력 값으로 null 허용
not null
각 열의 데이터 유형 입력 값으로 null 허용하지 않음
도메인 무결성 제약

default
입력 값을 생략하는 경우 자동으로 입력될 기본 값alter
도메인 무결성 제약

primary key
기본키를 정의
널값 허용하지 않음
개체 무결성 제약

unique
대체키=후보키를 정의
널값 허용 가능
유일성 제약

foreign key
외래키 정의
참조 무결성 제약
*/

# 학생2 테이블 생성
create table 학생2(
	학번 char(4) not null,
    이름 varchar(20) not null,
    주소 varchar(50) null default '미정',
    학년 int not null,
    나이 int null,
    성별 char(1) not null,
    휴대폰번호 char(14) null,
    소속학과 varchar(20) null,
    primary key (학번)
);

# 과목2 테이블 생성
create table 과목2(
	과목번호 char(4) not null primary key,
    이름 varchar(20) not null,
    강의실 char(3) not null,
    개설학과 varchar(20) not null,
    시수 int not null
);

# 학번, 과목번호, 신청날짜, 중간성적, 기말성적, 평가학점 열로 구성된 수강2 테이블 생성
create table 수강2
(
	학번 char(6) not null,
    과목번호 char(4) not null,
    신청날짜 date not null,
    중간성적 int null default 0,
    기말성적 int null default 0,
    평가학점 char(1) null,
    primary key(학번, 과목번호),
    foreign key(학번) references 학생2(학번),
    foreign key(과목번호) reference 과목2(과목번호)
);

/* 외래키
부모 테이블 - 외래키가 참조하는 기본키를 찾는 테이블
자식 테이블 - 외래키를 갖는 테이블
*/

/* alter
새로운 열이나 제약조건을 추가하거나 기존 열이나 제약 조건의 변경
*/

# 학생2 테이블에 새로운 등록날짜 열을 추가
alter table 학생2 add 등록날짜 datetime not null default '2019-12-30';

# 학생2 테이블의 등록날짜 열을 삭제
alter table 학생2 drop column 등록날짜;

# 학생2 테이블의 학생 열을 학생이름 열로 변경
alter table 학생2 change 이름 학생이름 varchar(20);

# 학생2 테이블의 이름 변경
alter table 학생2 rename to 재학생2;

/* drop
생성된 테이블 삭제
참조하는 테이블이 있다면 테이블 삭제 거절
다른 테이블에서 외래키로 참조하고 있다면 삭제 불가능-> 외래키 관계 해제후 삭제 가능
*/

# 과목2 테이블 삭제
drop table 과목2;

/* 사용자 및 권한 관리
사용자 계정, 비밀번호, 권한, 스키마 등에 대한 데이터 관리
*/

/* create user
mysql에 접속하기 위한 사용자 계정 생성
root -> 슈퍼 사용자
*/

# 사용자 계정 만들기 - 로컬 호스트
create user 'user1'@'127.1.1.1' identified by '1111';
create user 'user2'@'localhost' identified by '2222';

# 사용자 계정 만들기 - 특정 주소
create user 'user3'@'192.182.10.2' identified by '3333';

# 사용자 계정 만들기 - 전체
create user 'user4'@'%' identified by '4444';

# 생성된 사용자 계정 정보 확인
select host, user from mysql.user;

/* grant
사용자 계정에 여러 권한 부여 가능
입력, 수정, 삭제, 검색 권한
*/

# 권한 부여 예제
grant insert, update, delete on univDB.* to 'user1'@'127.1.1.1';
grant all on *.* to 'user4'@'%' with grant option;
grant select on univdb.학생 to 'user2'@'localhost';

# 사용자 계정의 권한 확인
show grants for 'user1'@'127.1.1.1';

# 현재 접속 사용자의 권한 표시
show grants;

/* revoke
권한 철회
사용자 계정에게 부여한 권한을 철회
*/

# 삭제 권한 철회
revoke delete on univDB.* from 'user1'@'127.1.1.1';

/* drop user
등록된 사용자를 삭제
*/

# user1 사용자 삭제
drop user 'user1'@'127.1.1.1';

# 접속 중인 사용자 계정
show processlist;

/* 뷰
개인 관점에서 필요로하는 접근 구조
데이터베이스에 저장된 테이블 구조를 각 사용자별로 서로 다르게 볼 수 있음
실제 데이터를 저장하지 않는 가상 테이블
필요할 때만 실제 테이블처럼 사용 가능한 데이터베이스 개체
뷰 생성을 위한 select문만 뷰 정의로 저장
뷰는 기반 테이블 또는 뷰 기반으로 정의 가능
*/

/* 기반 테이블
뷰를 정의하는데 사용되는 실제 데이터를 갖는 물리적 테이블
뷰에 대한 간단한 질의로 검색 가능
단일 SQL문으로 복잡한 검색 결과도 뷰를 이용 가능

편의성 - 뷰에 대한 간단한 질의문만으로도 원하는 내용 검색 가능
보안성 - 사용자별로 특정 뷰를 통해서만 접근하도록 하면 데이터 접근 제한 가능
재사용성 - 작성 빈도가 높은 검색 결과에 대해 뷰 정의시 재사용 가능
독립성 - 스키마 변경에도 뷰 질의문은 변경할 필요 없음
*/

/* create view
뷰 실체 생성
기반 테이블의 데이터 변경시 즉각적으로 반영
*/

# 3학년 혹은 4학년 학생의 학생이름, 나이, 성, 학년으로 구성된 뷰를 v1_고학년생이라는 이름으로 생성
create view v1_고학년생(학생이름, 나이, 성, 학년)
as select 이름, 나이, 성별, 학년
from 학생
where 학년 >= 3 and 학년 <=4;

# 뷰 데이터 확인
select * from v1_고학년생;
DESC v1_고학년생;

# 각 과목별 과목번호, 강의실, 수강 인원수로 구성된 뷰를 v2_과목수강현황이라는 이름으로 생성
create view v2_과목수강현황(과목번호, 강의실, 수강인원수)
as select 과목.과목번호, 강의실, count(과목.과목번호)
from 과목 join 수강 on 과목.과목번호 = 수강.과목번호
group by 과목.과목번호;

# v1_고학년생 뷰를 기반으로 여학생만으로 구성된 뷰를 v3_고학년여학생 이름으로 생성
create view v3_고학년여학생
as select *
from v1_고학년생
where 성 = '여';

/* 뷰를 통한 검색
뷰의 기반 테이블에 대한 검색으로 반환되어 수행
*/

# 생성된 뷰들을 통해 고학년여학생 정보 검색
select * from v1_고학년생 where 성 ='여';
select * from v3_고학년여학생;

# v2_과목수강현황 뷰에서 수강생 인원이 가장 많은 과목과 가장 적은 과목에 대한 과목번호, 강의실, 수강인원수 정보를 검색
select *
from v2_과목수강현황
where 수강인원수 = ( select max(수강인원수) from v2_과목수강현황) or
	  수강인원수 = ( select min(수강인원수) from v2_과목수강현황);

/* 뷰를 통한 데이터 변경
데이터의 입력, 수정, 삭제는 가능하지만, 제한있음
뷰검색은 제한 없이 가능하지만, 뷰 변경은 특정한 경우로 한정

- 기반 테이블의 기본키를 포함하지 않은 뷰
- 집계함수를 포함하는 뷰
- distinct 키워드를 적용한 결과
- group by절을 적용한 결과
- 다수의 기반 테이블의 조인을 통해 생성된 경우
- 뷰에 포함되지 않은 기반 테이블의 열이 not null인 경우
*/

/* 뷰 삭제
뷰 삭제 명령
drop view
*/

# v1_고학년생 뷰 삭제
drop view v1_고학년생;

/* 인덱스
대량의 데이터를 저장하는 데이터베이스로부터 필요로 하는 데이터를 빠르게 검색
테이블에 5개 미만의 적절한 인덱스 생성 필요
디스크 접근횟수 줄여 검색 속도 향상
B-Tree 구조 지원
*/

# 수강 테이블의 학번, 과목번호 열을 대상으로 인덱스 idx_수강 생성
create index idx_수강 on 수강 (학번, 과목번호);

# 생성된 인덱스 확인
show index from 수강;

/* 유일 인덱스
중복 제거 인덱스
*/

# 과목 테이블의 이름 열을 대상으로 유일한 값을 찾는 인덱스 idx_과목을 생성
create unique index idx_과목 on 과목 (이름 asc);

/* 인덱스 삭제
인덱스 삭제 sql
drop index
인덱스는 검색할때 효율적이지만, 데이터를 추가 또는 수정할때는 비효율적
*/

# 인덱스 idx_수강을 삭제하고 과목 테이블의 인덱스 idx_과목을 삭제
drop index idx_수강 on 수강;
alter table 과목 drop index idx_과목;

/* 인덱스 적용 고려사항
불필요한 인덱스는 성능을 저하시키고 저장공간을 낭비
부하가 큰 명령어를 인덱스에 사용하는 것은 지양
*/








