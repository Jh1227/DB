

/*  04_join.sql  */

/*
# join
- 하나 이상의 테이블에서, 한번의 질의문으로 원하는 자료를 검색할 때 사용합니다
*/

/*
# equi join
- 가장 많이 사용되는 조인 방식으로 조인 대상이 되는 두 테이블에서
  공통적으로 존재하는 컬럼의 값이 일치되는 행을 연결해서 결과를 생성합니다
*/
SELECT * FROM dept; 
SELECT * FROM emp;

SELECT * FROM emp, dept; -- 중복처리 X (보기 불편하다)

-- 사원 정보 출력시에 각 사원들이 소속된 부서의 상세 정보 확인
SELECT * FROM emp, dept WHERE emp.deptno = dept.deptno; -- 중복처리 O (보기 편하다)

-- 위 결과에서 특정 컬럼만 확인
SELECT ename, dname FROM emp, dept WHERE emp.deptno = dept.deptno;

-- 이름이 james 인 사람의 부서명 확인
SELECT ename, dname FROM emp, dept WHERE emp.deptno = dept.deptno AND ename = 'JAMES';

-- 두개의 테이블에서 동일하게 존재하는 컬럼을 확일할 때에는, 컬럼명 앞에 테이블 명을 명시합니다
SELECT ename, dname, emp.deptno FROM emp, dept WHERE emp.deptno = dept.deptno AND ename = 'JAMES';

-- 테이블에 별칭 지정
-- FROM 절 뒤에 테이블 이름을 명시하고, 공백을 작성한 다음에 별칭을 지정합니다
SELECT E.ename, D.dname, E.deptno FROM emp E, dept D WHERE E.deptno = D.deptno AND E.ename = 'JAMES';


/*
# Non-Equi join
- 조인 조건에 특정 범위 내에 있는지를 비교연산자를 사용해서 join 합니다
*/
SELECT * FROM tab;

-- salgrade : 급여 등급 테이블
DESC salgrade;
SELECT * FROM salgrade;

-- 각 사원의 급여 등급 확인
SELECT ename, sal, grade 
FROM emp, salgrade 
WHERE sal BETWEEN losal AND hisal;

-- 사원 이름과 소속 부서, 급여의 등급 확인
SELECT E.ename, D.dname, E.sal, S.grade 
FROM emp E, dept D, salgrade S 
WHERE E.deptno = D.deptno AND E.sal BETWEEN losal AND hisal;


/*
# Self join
- 하나의 테이블 내에서 조인을 해서 원하는 결과를 얻을 수 있습니다
*/
SELECT * FROM emp;

-- 사원의 담당 manager 확인
SELECT employee.ename || ' 의 MANAGER 는 ' || manager.ename || ' 입니다' 
FROM emp employee, emp manager 
WHERE employee.mgr = manager.empno;

SELECT employee.ename || ' 의 MANAGER 는 ' || manager.ename || ' 입니다' 
FROM emp employee, emp manager 
WHERE employee.mgr = manager.empno
AND manager.ename = 'KING';


/*
# Outer join
- 조인 조건에 만족하지 않는 행도 나타내는 조인입니다
- 조인될 때, 어느 한쪽의 테이블에는 해당하는 데이터가 있지만,
  다른쪽 테이블에는 데이터가 없을 경우 그 데이터가 출력되지 않는 것을 해결할 수 있습니다
- '+' 기호를 조인 조건에서 정보가 부족한 컬럼 이름 뒤에 붙입니다
*/

SELECT employee.ename || ' 의 MANAGER 는 ' || manager.ename || ' 입니다' 
FROM emp employee, emp manager 
WHERE employee.mgr = manager.empno(+);


/* quiz */
SELECT * FROM dept;
SELECT * FROM emp;
-- 'NEW YORK' 에서 근무하는 사원의 이름과 급여를 출력하세요
SELECT E.ename, D.loc, E.sal
FROM emp E, dept D
WHERE E.deptno = D.deptno
AND E.deptno = 10;

SELECT ename, sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND dept.loc = 'NEW YORK';

-- SMITH 사원과 동일한 근무지에서 근무하는 사원의 이름을 출력하세요
SELECT E.ename, D.loc, e.deptno
FROM emp E, dept D
WHERE E.deptno = D.deptno
AND E.deptno = 20;

SELECT EA.ename, EB.ename
FROM emp EA, emp EB
WHERE EA.deptno = EB.deptno
AND EA.ename = 'SMITH'
AND EA.ename != EB.ename; -- 왼쪽과 오른쪽에 같은 이름을 가진 컬럼 제거

-- 사원명, 부서번호, 부서명을 출력하세요
-- 단, 사원 테이블에는 부서 번호 40인 사원이 없지만,
-- 부서 테이블에 있는 부서 번호 40인 'OPERATION'이 출력되어야 합니다
SELECT E.ename, E.deptno, D.dname
FROM emp E, dept D
WHERE E.deptno(+) = D.deptno; 































