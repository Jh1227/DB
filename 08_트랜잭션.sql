
/*  08_트랜잭션.sql  */

/*
# 트랜잭션 ( transaction )
- 데이터 베이스 내에서 하나의 그룹으로 처리되어야 하는 명령문들을 모아 놓은 작업 단위 입니다
- 여러개의 명령어의 집합이 정상적으로 처리되면 정상 종료하도록 하고,
  여러개의 명령어 중에서 하나의 명령어라도 잘못 되었다면 전체를 취소해 버리게 됩니다
  
# 트랜잭션 명령어
- COMMIT
  ROLLBACK
  SAVEPOINT
*/

/*
# COMMIT
- 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어 입니다
- 트랜잭션의 처리 과정을 데이터 베이스에 반영하기 위해서 변경된 내용을 모두 영구 저장합니다
- COMMIT 을 수행하면 하나의 트랜잭션 과정을 완료하게 됩니다
- Transaction( INSERT, UPDATE, DELETE ) 작업 내용을 실제 DB 에 저장합니다
*/

/*
# ROLLBACK
- 작업중 문제가 발생했을 때, 트랜잭션의 처리 과정에서 발생한 변경 사항을 취소하고 트랜잭션 과정을 종료합니다
- 이전 COMMIT 한 곳까지만 복구됩니다
*/

-- 연습 테이블
DROP TABLE dept01;

CREATE TABLE dept01 AS SELECT * FROM dept;

SELECT * FROM dept01;

-- dept01 테이블 내용 삭제
DELETE FROM dept01;

SELECT * FROM dept01;

-- ROLLBACK 을 수행해서 데이터 복구
ROLLBACK;

SELECT * FROM dept01;

-- 부서번호 20번 삭제
DELETE FROM dept01
WHERE deptno = 20;

SELECT * FROM dept01;

-- 데이터 삭제한 결과를 영구 저장하기 위해서 COMMIT 수행
COMMIT;

SELECT * FROM dept01;

-- COMMIT 을 수행해서 영구 저장하면, ROLLBACK 을 해서 삭제 이전의 상태로 되돌릴 수 없습니다
ROLLBACK;

SELECT * FROM dept01;

/*
# AUTO COMMIT
- DDL 문( ALTER, DROP, RENAME ... ) 은 자동으로 COMMIT 을 실행합니다
*/

-- 연습 테이블
DROP TABLE dept02;

CREATE TABLE dept02 AS SELECT * FROM dept;

SELECT * FROM dept02;

-- 부서번호 40번 삭제
DELETE FROM dept02
WHERE deptno = 40;

SELECT * FROM dept02;

-- dept 테이블과 동일한 내용을 갖는 dept03 테이블 생성
CREATE TABLE dept03 AS SELECT * FROM dept;

SELECT * FROM dept03;

ROLLBACK;

-- ROLLBACK 명령문을 실행했지만, DDL 문이 수행되었기 때문에 자동 COMMIT 이 발생해서 복구 되지 않습니다
SELECT * FROM dept02;

/*
# SAVEPOINT
- 현재의 트랜잭션을 분할하는 명령어 입니다
- 저장된 SAVEPOINT 는 'ROLLBACK TO SAVEPOINT' 문을 사용해서, 표시한 곳까지 ROLLBACK 할 수 있습니다
*/

-- 연습 테이블
DROP TABLE dept01;

CREATE TABLE dept01 AS SELECT * FROM dept;

SELECT * FROM dept01;

-- 40번 부서 삭제 -> COMMIT
DELETE FROM dept01 WHERE deptno = 40;

COMMIT;

SELECT * FROM dept01;

-- 30번 부서 삭제 -> SAVEPOINT D30
DELETE FROM dept01 WHERE deptno = 30;

SELECT * FROM dept01;

SAVEPOINT D30;

-- 20번 부서 삭제 -> SAVEPOINT D20
DELETE FROM dept01 WHERE deptno = 20;

SELECT * FROM dept01;

SAVEPOINT D20;

-- 10번 부서 삭제 
DELETE FROM dept01 WHERE deptno = 10;

SELECT * FROM dept01;

-- SAVEPOINT D30 까지 ROLLBACK 수행
ROLLBACK TO D30;

SELECT * FROM dept01;

-- SAVEPOINT D20 까지 ROLLBACK 수행
ROLLBACK TO D20;

SELECT * FROM dept01;

