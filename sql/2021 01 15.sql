# SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

# safe mode 해제
SET SQL_SAFE_UPDATES =0;

/* 공유락
- 데이터를 검색하는 select문을 실행하기 위한 읽기 전용 락
- 수정 불가
*/

/* 독점락
- insert, update, delete문과 같은 데이터 변경을 위한 배타적락
- 특정 데이터에 대해 하나의 트랜잭션만 독점 락 설정 가능
- 데이터에 대한 모든 공유 락과 독점 락이 해제된 이후에만 독점 락 설정 가능
*/

/* 락 단위 lock granularity
- 락 잠금 대상의 크기
- 테이블 행 단위나 테이블, 데이터베이스 단위로 락 설정 가능
*/

/* 락 양립성 lock compatability
- 독점 락과 공유 락 사이에서 서로 추가 잠금 허용 여부를 결정

트랜잭션 읽기 -> 공유락 설정

트랜잭션 수정 -> 독점락 설정
*/

/* 2단계 락킹 규약과 락 해제
- 각 트랜잭션별로 락을 설정하는 과정과 락을 해제하는 과정 2단계로 진행
- 필요한 순간까지 획득한 락을 유지하는 규칙

1단계 : 락 확장 단계
- 접근하고자 하는 데이터에 대한 모든 락을 획들할 때까지 새로운 락을 지속적으로 요청하여 잠금 설정
- 보유하고 있는 락을 해제할 수 없음
- 락을 추가로 획득 가능

2단계 : 락 축소 단계
- 락 포인트에서 보유하고 있던 락을 점차적으로 해제
- 하나라도 락을 해제하면 새로운 락 요청 불가
*/

/* 교착 상태
- 둘 이상의 트랜잭션의 락이 서로 얽혀서 영원히 풀리지 않은 상태
- 두 쪽 모두가 기다림 상태로 어느 쪽도 완료할 수 없는 상태

교착 상태가 발생한 경우
트랜잭션 중 처리 시간이 가장 적게 소요된 트랜잭션을 교착 상태의 희생자로 지정해 강제로 롤백할 필요 존재
*/

/* 트랜잭션의 고립 수준
트랜잭션이 다른 트랜잭션과 고립되는 정도

오손 데이터 읽기 문제
커밋되지 않은 트랜잭션 T1의 수정된 중간 결과를 읽어오는 것이 허용된다면 발생할 수 있는 문제

반복 불가능 읽기 문제
트랜잭션 T1 읽어서 처리중인 데이터를 트랜잭션 T2가 자유롭게 변경하는 것이 허용된다면 발생할 수 있는 문제

유령 데이터 읽기 문제
트랜잭션 T1이 읽어서 처리중인 데이터를 트랜잭션 T2가 변경하는 것을 방지하더라고 트랜잭션 T2의 데이터 추가가 허용된다면 발생할 수 있는 문제

고립 수중이 높음
- 동시 수행성 제한 
- 트랜잭션 처리의 성능 저하 
- 데이터의 정확성 높아짐

허용 가능한 고립 수준을 선택함으로써 가능한 범주 안에서 성능을 향상시킴
*/

# 고립수준 0
set transaction isolation level read uncommitted;

# 고립수준 1
set transaction isolation level read committed;

# 고립수준 2
set transaction isolation level repeatable read;

# 고립수준 3
set transaction isolation level serializable;

# 트랜잭션 고립 수준 적용 준비
use univDB;
create table 고객 select 이름, 나이, 성별 from 학생;
select * from 고객;

# 트랜잭션 고립 수준 적용 예 - 사용자1
set sql_safe_updates = 0;
use univDB;
set transaction isolation level read committed;

start transaction;
select * from 고객;
select * from 고객;
update 고객 set 나이 = 나이 + 100;
select * from 고객;
rollback;

select * from 고객;

# 트랜잭션 고립 수준 적용 예 - 사용자2
set sql_safe_updates = 0;
use univDB;
set transaction isolation level read committed;

start transaction;
select * from 고객;
update 고객 set 나이 = 10 where 성별 = '여';
select * from 고객;
commit;