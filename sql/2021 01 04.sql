# 예제 데이터베이스 생성 

# mysql version 확인
select version();

# 한줄 주석

-- 한줄 주석'

/*
여러줄 주석
*/

# 계정 생성
create user 'manager'@'%' identified by '1234';

# root 권한 부여 select, insert, update, delete 등
grant all on *.* to 'manager'@'%' with grant option;

# 현재 Mysql 사용자 표시
select user();

# 현재 데이터베이스 목록 표시
show databases;

# 데이터베이스 생성
drop database if exists univDB;
create database if not exists univDB;

# SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

# 과목 테이블 생성
create table 과목(
	과목번호 char(4) not null primary key,
    이름 varchar(20) not null,
    강의실 char(3) not null,
    개설학과 varchar(20) not null,
    시수 int not null
);

# 학생 테이블 생성
create table 학생(
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

# 수강 테이블 생성
create table 수강(
	학번 char(6) not null,
    과목번호 char(4) not null,
    신청날짜 date not null,
    중간성적 int null default 0,
    기말성적 int null default 0,
    평가학점 char(1) null,
    primary key (학번, 과목번호)
);

# 학생 테이블 입력
insert into 학생 values('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-22222', '컴퓨터');
insert into 학생 values('s002', '홍길동', default, 1, 23, '남', null, '통계');
insert into 학생 values('s003', '이승엽', null, 3, 23, '남', null, '정보통신');
insert into 학생 values('s004', '이영애', '경기 분당', 2, 23, '여', '010-4444-5555', '정보통신');
insert into 학생 values('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터');
insert into 학생 values('s006', '홍길동', '서울 종로', 2, 23, '남', '010-8888-9999', '컴퓨터');
insert into 학생 values('s007', '이은찬', '경기 과천', 1, 23, '여', '010-2222-3333', '경영');

# 과목 테이블 입력
insert into 과목 values('c001', '데이터베이스', 126, '컴퓨터', 3);
insert into 과목 values('c002', '정보보호', 137, '정보통신', 3);
insert into 과목 values('c003', '모바일웹', 128, '컴퓨터', 3);
insert into 과목 values('c004', '철학개론', 117, '철학', 2);
insert into 과목 values('c005', '전공글쓰기', 120, '교양학부', 1);

# 수강 테이블 입력
insert into 수강 values('s001', 'c002', '2019-09-03', 93, 98, 'A');
insert into 수강 values('s004', 'c005', '2019-03-03', 72, 78, 'C');
insert into 수강 values('s003', 'c002', '2017-09-06', 85, 82, 'B');
insert into 수강 values('s002', 'c001', '2018-03-10', 31, 50, 'F');
insert into 수강 values('s001', 'c004', '2019-03-05', 82, 89, 'B');
insert into 수강 values('s004', 'c003', '2020-09-03', 91, 94, 'A');
insert into 수강 values('s001', 'c005', '2020-09-03', 74, 79, 'C');
insert into 수강 values('s003', 'c001', '2019-03-03', 81, 82, 'B');
insert into 수강 values('s004', 'c002', '2018-03-05', 92, 95, 'A');

# 작업 대상 데이터베이스 변경
use univDB;

# 현재 사용 데이터베이스 확인
select database();

# univDB 안의 생성 테이블 목록 확인
show tables;

# 학생 테이블 생성 정보 확인
desc 학생;


/*
검색문
최소 2개의 절 select from
최대 6개의 절 select from where group by having order by
*/

# 전체 학생의 이름과 주소 검색
select 이름, 주소 from 학생;

# 전체 학생의 모든 정보 검색
select * from 학생;
select 학번, 이름, 주소, 학년, 나이, 성별, 휴대폰번호, 소속학과 from 학생;

# distinct 중복 행 제거
# 전체 학생의 소속학과 정보를 중복없이 검색 
select distinct 소속학과 from 학생;

/* 연산자들의 실행 우선 순위
비교연산자 (1)
NOT (2)
AND (3)
OR (4)
*/

# 학생 중에서 2학년 이상인 '컴퓨터' 학과 학생의 이름, 학년, 소속학과, 휴대폰번호 정보 검색
select 이름, 학년, 소속학과, 휴대폰번호 from 학생 where 학년 >=2 and 소속학과 ='컴퓨터';

# 1,2,3학년 학생이거나 컴퓨터학과에 소속되지 않은 학생의 이름, 학년, 소속학과, 휴대폰번호 검색
select 이름, 학년, 소속학과, 휴대폰번호 from 학생 where (학년>= 1 and 학년 <=3) or not(소속학과='컴퓨터');
select 이름, 학년, 소속학과, 휴대폰번호 from 학생 where (학년 between 1 and 3) or not(소속학과='컴퓨터');

/* order by
asc 오름차순
desc 내림차순
*/

# 컴퓨터학과나 정보통신학과의 학생의 이름과 학년, 소속학과 정보를 학년의 오름차순으로 검색
select 이름, 학년, 소속학과 from 학생 where 소속학과 = '컴퓨터' or  소속학과 = '정보통신' order by 학년 asc;

# 전체 학생의 모든 정보를 검색하되 학년을 기준으로 먼저 1차 오름차순 정렬, 학년이 같은 경우에 이름을 기준으로 2차 내림차순 정렬
select * from 학생 order by 학년 asc, 이름 desc;

/* as
검색 반환되는 열에 대한 별칭
*/

/* count
null과 중복 값을 포함한 모든 행의 개수 반황
*/

# 학생 수1, 학생 수2, 학생 수3 별칭 부여 검색
select count(*) as 학생수1, count(주소) as 학생수2, count(distinct 주소) as 학생수3 from 학생;

/* avg
평균값
avg에서는 별칭문구 생략 가능
*/

# 여학생의 평균 나이 검색
select avg(나이) as '여학생 평균나이' from 학생 where 성별 = '여';
select avg(나이) '여학생 평균나이' from 학생 where 성별 = '여';

