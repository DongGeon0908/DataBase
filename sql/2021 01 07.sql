# SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

/* GROUP BY
각 그룹에 대한 검색 결과 반환
집계 함수는 항상 그룹을 대상으로 적용
*/

# 전체 학생의 성별 최고 나이와 최저 나이 검색
select 성별, Max(나이) as '최고 나이', Min(나이) as '최저 나이'
from 학생
group by 성별;

# 20대 학생만을 대상으로 나이별 학생수 검색
select 나이, count(*) as '나이별 학생수'
from 학생
where 나이 >= 20 and 나이 < 30
group by 나이;

/* Having
그룹이 만족해야 하는 제한 조건 명세
특정 조건을 만족하는 그룹만을 검색을 제한
Group by의 조건
*/

# 각 학년별로 2명 이상의 학생을 갖는 학년에 대해서만 학년별 학생수 검색
select 학년, count(*) as '학년별 학생수'
from 학생
group by 학년
having count(*) >=2;

/* like
부분 문자열 포함 여부를 검색하기 위해 where절 검색 조건식에 사용되는 비교 연산자
- -> 1개의 모든 문자
% -> 0개 이상의 모든 문자
*/

# 이씨성을 가진 학생들의 학번과 학생 이름 검색
select 학번, 이름 from 학생 where 이름 like '이%';

# 주소지가 서울인 학생의 이름 주소 학년을 학년순(내림차순)으로 검색
select 이름, 주소, 학년 from 학생 where 주소 like '%서울%' order by 학년 desc;

/* NULL
is null
is not null
*/

# 휴대폰 번호가 등록되지 않은 학생의 이름과 휴대폰번호 검색
select 이름, 휴대폰번호 from 학생 where 휴대폰번호 is null;

/* UNION
여러  select 명령문의 검색 결과 결합
*/

# 여학생이거나 A학점을 받은 학생의 학번 검색
select 학번 from 학생 where 성별="여" union select 학번 from 수강 where 평가학점 ="A";

/* 부 질의문
질의문 안에 중첩되어 포함된 또 단른 select 검색문
반복해서 부 질의문이 중첩되어 포함 가능
*/

/* In
괄호 안에 나열된 값들 중에서 하나라도 일차하는 경우 참 반환
내부 질의 : 안쪽에 위치한 부 질의문
주 질의, 외부 질의 : 바깥쪽 주 질의문
*/

# 과목번호가 c002인 과목을 수강한 학생의 이름 검색
select 이름 from 학생 where 학번 in ('s001', 's003', 's004');
select 이름 from 학생 where 학번 in (select 학번 from 수강 where 과목번호='c002');

/* 중첩 부 질의문
가장 안쪽의 부 질의문은 단일 값을 반환하므로 '=' 비교 연산자 사용
이후의 부 질의문은 다중 값을 반환하므로 IN 연산자 사용
*/

# 정보보호 과목을 수강한 학생의 이름 검색
select 이름 from 학생 where 학번 in (select 학번 from 수강 where 과목번호 = (select 과목번호 from 과목 where 이름 = "정보보호"));

/* EXISTS 연산자
부 질의문의 실행 결과로 반환되는 행이 존재하는지 존재 유무를 확인하는 연산자
결과가 공집합이면 거짓
공집합이 아니면 참
*/

# 과목번호 c002인 과목을 수강한 학생의 이름을 검색
select 이름 from 학생 where exists ( select * from 수강 where 수강.학번 = 학생.학번 and 과목번호 = 'c002');

/* 상호연관(상관) 질의문
중첩 질의문 중에서 내부 질의의 where절 검색 조건식이 외부 질의에 선언된 테이블의 일부 열을 참조하는 질의
*/

# 힉셍 중에서 한 과목도 수강하지 않은 학생의 이름을 검색
select 이름 from 학생 where not exists (select * from 수강 where 수강.학번 = 학생.학번);

/* 부 질의문
스칼라 부 질의문
인라인 뷰
*/






