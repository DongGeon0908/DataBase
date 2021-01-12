# SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

/* SQL 함수
내장 함수
- 열 이름이나 상수 값을 입력받아 값 하나를 결과로 반환
- 기본 연산함수, 시스템 정보 제공 함수, 데이터 가공 함수
- select, where, update set

사용자 정의 함수
*/

/* 숫자함수
- +, -, *, /, %
숫자 함수 제공
숫자 함수 입력으로 상수 값 또는 열 이름 사용
여러 함수의 결합 사용 

ABS(값) 입력 값의 절대값 반환
CEIL(값) 입력 값보다 큰 정수 중에서 가장 작은 수 반환
FLOOR(값) 입력 값보다 작은 정수 중에서 가장 큰 수 반환
ROUND(값,자리수) 입력 값을 소수점이하 자리수까지 반올림값한 값 반환
FORMAT(값,형식) 입력 값을 형식에 맞게 반환
*/

select abs(+17), abs(-17), ceil(3.28), floor(4.259);

select 학번, sum(기말성적)/count(*), round(sum(기말성적)/count(*), 2) from 수강 group by 학번;

/* 문자함수
문자열을 원하는 형식으로 변환
문자열 상수 값이나 char, varchar 타입으로 선언된 열 이름이 문자 함수의 입력

length(문자열) 문자열 길이 반환 - 바이트수
char_length(문자열) 문자열 길이 반환 - 문자수
concat(문자열 리스트) 콤마로 구분된 문자열, 컬럼 값들의 결합 반환
left/right(문자열,길이) 문자열의 왼쪽/오른쪽부터 길이만큼만 반환
LTRIM/RTRIM(문자열) 문자열의 왼쪽/오른쪽 공백을 제거해 반환
substring(문자열,위치,길이) 문자열의 위치번째부터 길이 개수만큼의 부분 문자열 반환
replace(문자열,검색문자열,치환문자열) 문자열의 일부를 치환해 반환
repeat(문자열,반복횟수) 문자열을 반복 횟수만큼 반복해 반환
*/

select length(소속학과), right(학번,2), repeat('*', 나이), concat(소속학과, '학과') from 학생;

select substring(주소,1,2), replace(substring(휴대폰번호,5,9),'-'',',',') from 학생;

/* 날짜, 시간 함수
날짜형 데이터에 대한 다양한 변환과 연산 지원

sysdata(), now() 현재 날짜와 시간을 반환
current_date() 현재 날짜를 반환
current_time() 현재 시간을 반환
year(날짜), month(날짜), day(날짜) 입력 날짜의 연도/월/일 부분을 반환
hour(시간), minute(시간), second(시간) 입력 시간의 시/분/초 부분
last_day(날짜) 입력 날짜의 해당 월의 마지막 날짜 반환
date_add(날짜, interval, 중분값 day/month/year) 입력 날짜에서 증분값만큼 날/월/년을 더한 날짜 반환
date_sub(날짜, interval, 감소값 day/month/year) 입력 날짜에서 감소값만큼 날/월/년을 뺀 날짜 반환
date_format(날짜, '형식') 입력 날짜를 형식에 맞게 변환해 반환
*/

select 신청날짜, last_day(신청날짜)
from 수강
where year(신청날짜) = '2019';

select sysdate(), datediff(신청날짜, '2019-01-01')
from 수강;

select 신청날짜, date_format(신청날짜, '%b/%d/%y'), date_format(신청날짜, '%y년%c월%e일')
from 수강;

/* 저장 프로시저
미리 작성하여 데이터베이스 안에 저장한 SQL 문장들의 묶음
독립된 프로그램
데이터베이스 안에 하나의 객체로 저장
DBA가 데이터베이스 관리를 수행하기 위해 사용하는 기능들이 DBMS에 의해 저장 프로시저로 제공

직접 저장 프로시저
복잡한 조건의 SQL 작업을 함수처럼 인자만 전달해서 실행
필요할 때마다 호출해 반복 사용 가능
미리 최적화되어 저장

저장 프로시저
최적화된 SQL문을 미리 데이터베이스에 저장
네트워크 부하 줄어듬
응용 프로그램간의 공유 가능
*/

/* create procedure
저장 프로시저 정의
*/

# 과목 테이블에 데이터를 추가하는 저장 프로시저 
delimiter //
create procedure InsertOrUpdateCourse (
	in CourseNo varchar(4),
    in CourseName varchar(20),
    in CourseRoom char(3),
    in CourseDept varchar(20),
    in CourseCredit int)
begin
	declare Count int;
    select count(*) into Count from 과목 where 과목번호 = CourseNo;
    if (Count = 0) then
		insert into 과목(과목번호, 이름, 강의실, 개설학과, 시수)
        values(CourseNo, CourseName, CourseRoom, CourseDept, CourseCredit);
	else
		update 과목
        set 이름 = CourseName, 강의실 = CourseRoom, 개설학과 = CourseDept, 시수 = CourseCredit
        where 과목번호 = CourseNo;
	end if;
end //
delimiter ;

# 삽입 저장 프로시저
# InsertOfUpdateCourse 저장 프로시저를 호출해 과목 테이블에 연극학개론 과목을 등록
call InsertOrUpdateCourse('c006', '연극학개론', '310', '교양학부', 2);

# 수정 저장 프로시저
# InsertOrUpdateCourse 저장 프로시저를 호출해 과목 테이블의 연극학개론 과목 강의실을 410으로 수정
call InsertOrUpdateCourse('c006', '연극학개론', '410', '교약학부', 2);


/* 검색 저장 프로시저
여러 행이나 복수 열을 포함 가능

cursor 검색 결과 안의 행들을 한 번에 하나씩 처리하기 위해 테이블의 특정 행을 가리키는 객체, 포인터 역할
*/

# 수강 테이블에서 중간 성적 혹은 기말 성적으로 특정 점수 이상을 받은 학생수를 반환하는 SeletAverageOfBestScore 프로시저 작성
delimiter //
create procedure SelectAverageOfBestScore (
	in Score int,
    out Count int)
begin
	declare NoMoreData int default false;
    declare Midterm int;
    declare Final int;
    declare Best int;
    declare ScoreListCursor cursor for
		select 중간성적, 기말성적 from 수강;
	declare continue handler for not found set nomoredata = true;
		set Count = 0;
	open ScoreListCursor;
    repeat
		fetch ScoreListCursor into Midterm, Final;
        if  Midterm > Final then
			set Best = Midterm;
		else
			set Best = Final;
		end if;
        if (Best >= Score) then
			set Count = Count + 1;
		end if ;
	until NoMoreData end repeat;
    close ScoreListCursor;
end;
//
delimiter ;

# 검색 저장 프로시저의 호출
# SelectAverageOfBestScore 저장 프로시저를 호출해 중간 혹은 기말 성적 중 95점 이상 받은 학생수 검색
call SelectAverageOfBestScore(95, @Count);
select @Count;

# 삭제할 저장 프로시저의 내용 확인
show create procedure InsertOrUpdateCourse;

# 프로시저 삭제
drop procedure InsertOrUpdateCourse;