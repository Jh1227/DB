
/*  10_view.sql  */

/*
# VIEW
- 물리적인 테이블을 이용한 논리적인 가상 테이블이라고 할 수 있습니다
- 실질적인 데이터를 저장하고 있지는 않더라도 사용자는 마치 테이블을 사용하는 것과 동일하게
  VIEW 를 사용할 수 있습니다
- VIEW 는 기본 테이블에 대한 하나의 쿼리문이고, 실제 테이블에 저장된 데이터를 VIEW 를 통해서 볼 수 있습니다
- VIEW 를 생성하기 위해서는 실질적인 데이터를 저장하고 있는 물리적인 테이블이 존재해야 하는데,
  해당 테이블을 기본 테이블이라고 합니다
- VIEW 정의
  CREATE VIEW view_name [(alias, ...)]
  AS
  SUBQUERY;
*/

/*
# 단순 뷰               복합 뷰
  하나의 테이블로 생성   여러개의 테이블로 생성
  그룹 함수 사용 가능    그룹 함수 사용 불가
  DML 사용 가능          DML 사용 불가
*/

-- VIEW 생성 권한 부여
-- SYSTEM 계정
-- GRANT CREATE VIEW TO 계정명;
GRANT CREATE VIEW TO SCOTT;


/*
# 단순 뷰
*/

-- 연습용 테이블
CREATE TABLE dept_copy AS SELECT * FROM dept;
CREATE TABLE emp_copy AS SELECT * FROM emp;

SELECT * FROM dept_copy;
SELECT * FROM emp_copy;

-- 부서번호 30번에 소속된 사원의 사원번호, 사원이름, 부서번호 확인
SELECT empno, ename, deptno
FROM emp_copy
WHERE deptno = 30;

-- 부서번호 30번에 소속된 사원의 사원번호, 사원이름, 부서번호 확인하는 SELECT 문을 하나의 VIEW 로 정의
CREATE VIEW emp_deptno30
AS
SELECT empno, ename, deptno
FROM emp_copy
WHERE deptno = 30;

SELECT * FROM emp_deptno30;

-- emp_deptno30 뷰를 사용해서 데이터 추가
INSERT INTO emp_deptno30
VALUES (7001, 'GPT_2', 30);

SELECT * FROM emp_deptno30;

SELECT * FROM emp_copy;

-- 부서별 급여 총액과 평균을 구하는 VIEW
DROP TABLE emp_sal; --> TABLE 삭제
DROP VIEW emp_sal; --> VIEW 삭제

CREATE VIEW emp_sal
AS
SELECT deptno, SUM(sal) AS "SAL SUM", TRUNC(AVG(sal), 1) AS "SAL AVG"
FROM emp_copy
GROUP BY deptno;

SELECT * FROM emp_sal;


/*
# 복합뷰
- 
*/

-- 사원 테이블과 부서 테이블을 조인한 복합뷰 생성
-- 사원번호, 이름, 급여, 부서번호, 부서명, 지역명을 출력
CREATE VIEW emp_dept_view
AS
SELECT E.empno, E.ename, E.sal, E.deptno, D.dname, D.loc
FROM dept E, dept D
WHERE E.deptno = D.deptno
ORDER BY empno DESC;

SELECT * FROM emp_dept_view;


/*
# VIEW 수정
- CREATE OR REPLACE VIEW 를 사용하면 존재하지 않는 뷰이면 새로운 뷰를 생성하고,
  기존에 존재하는 뷰이면 그 내용을 변경합니다
*/

SELECT * FROM emp_deptno30;

-- emp_deptno30 뷰에 급여, 커미션 추가
CREATE OR REPLACE VIEW emp_deptno30
AS
SELECT empno, ename, sal, comm, deptno
FROM emp_copy
WHERE deptno = 30;

SELECT * FROM emp_deptno30;


/*
# ROWNUM 컬럼
- 조회된 값에 번호를 부여할 때 사용합니다
*/

SELECT ROWNUM empno, ename, hiredate
FROM emp;

SELECT ROWNUM empno, ename, hiredate
FROM emp
ORDER BY hiredate;

-- 입사일을 기준으로 오름차순 정렬한 VIEW 생성
CREATE OR REPLACE VIEW hiredate_view
AS
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate;

SELECT * FROM hiredate_view;

-- 입사일이 빠른 사람 순서로 5명 조회
SELECT ROWNUM, empno, ename, hiredate
FROM hiredate_view
WHERE ROWNUM <= 5;


/*
# 인라인 뷰
- 메인 쿼리의 SELECT 문의 FROM 절 내부에 사용된 서브 쿼리 입니다
*/

SELECT ROWNUM, empno, ename, hiredate
FROM (SELECT empno, ename, hiredate FROM emp ORDER BY hiredate)
WHERE ROWNUM <= 5;


/* Quiz */

-- 각 부서별 최대 급여와 최소 급여를 출력하는 SAL_MAX_MIN VIEW 를 생성하세요
CREATE OR REPLACE VIEW sal_max_min_view
AS
SELECT D.dname 부서명, MAX(E.sal) 최대급여, MIN(E.sal) 최소급여
FROM emp E, dept D
WHERE E.deptno = D.deptno
GROUP BY D.dname;

SELECT * FROM sal_max_min_view;

-- 인라인 뷰를 사용해서 급여를 많이 받는 순서대로 5명을 출력하세요
SELECT ROWNUM, ename, sal
FROM (SELECT ename, sal FROM emp ORDER BY sal DESC)
WHERE ROWNUM <= 5;

