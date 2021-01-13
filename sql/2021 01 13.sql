# SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

/* 트리거 trigger
- 데이터 변경 등의 명세된 이벤트가 발생할 때 이를 감지해 자동 실행되는 사용자 정의 프로시저
- insert, update, delete 실행 직후 자동으로 호출
- 트리거가 정의된 테이블 또는 쿼리는 DBMS에 의해 자동 호출
- 무결성 제약 조건을 유지하거나 업무 규칙 등을 적용하기 위해 사용
- 기본값 설정, 릴레이션 간의 데이터 제약, 뷰 수정, 참조 무결성 강화 등을 위해 활용

사전 트리거
특정 삽입, 수정, 삭제 용청이 처리된 직후에 작업할 내용 정의

사후 트리거
특정 삽입, 수정, 삭제 요청이 처리된 직후에 작업할 내용 정의

변경된 데이터를 SQL 명령문에 의해 접근 가능

OLD.열이름 -> 변경 전의 값

NEW.열이름 -> 변경 후의 값
*/

# 예제 테이블 생성
create table 남녀학생총수
( 성별 char(1) not null default 0,
인원수 int not null default 0,
primary key (성별));

# 예제 데이터 삽입
insert into 남녀학생총수 select '남', count(*) from 학생 where 성별 = '남';
insert into 남녀학생총수 select '여', count(*) from 학생 where 성별 = '여';

# 학생 테이블에 행이 삽입되면 남녀학생총수 테이블의 남학생 또는 여학생의 인원수를 1만큼씩 자동으로 증가시키는 트리거 작성
delimiter //
create trigger AfterInsertStu
after insert on 학생 for each row
begin
if(new.성별 = '남') then
	update 남녀학생총수 set 인원수 = 인원수 + 1 where 성별 = '남';
elseif(new.성별 = '여') then
	update 남녀학생총수 set 인원수 = 인원수 + 1 where 성별 = '여';
end if ;
end ;
//
delimiter ;

# 트리거 내용 확인
show triggers;

# 트리거 삭제
drop trigger AfterInsertStu;

/* 사용자 정의 함수
- 사용자가 직접 정의한 함수로 DBMS 안에 독립된 데이터베이스 객체로 저장
- select문이나 프로시저 안에서 호출되어 특정 기능 수행
- 결과 값을 반환하는 용도로 사용

스칼라 함수
하나의 값 또는 null 반환

테이블 함수
각 행이 하나 이상의 열로 구성된 테이블을 반환
*/

/* create function
함수명, 매개변수, 매개변수의 자료형, 반환 값의 자료형 지정 필요
*/

delimiter //
create function Fn_Grade( grade char(1) )
returns varchar(10)
begin
	declare ret_grade varchar(10) ;
	if (grade = 'a') then
		set ret_grade = '최우수';
	elseif (grade = 'b') then
		set ret_grade = '우수' ;
	elseif (grade = 'c') then
		set ret_grade = '보통' ;
	elseif ( grade = 'd' or grade = 'f' ) then
		set ret_grade = '미흡' ;
	end if ;
	return ret_grade ;
end
//
delimiter ;

# 사용자 정의 함수 내용 표시
show create function Fn_Grade;

# 사용자 정의 함수 Fn_Grade() 삭제
drop function Fn_grade ;


/* 저장 프로시저
 - 처리의 일관성 높임
 - 보안 강화
 - 반복적인 처리의 경우 성능 향상
*/

/* 트리거
- 복잡한 데이터 무결성 강화
- 다양한 데이터 처리 업무 규칙 구현
- 성능 다소 저하
*/

/* 사용자 정의 함수
- 특정 값뿐만 아니라 테이블 반환 가능
- 제한된 sql 명령문 기능 확장
- 명령문 작성의 편의성 향상
*/