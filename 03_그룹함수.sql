

/*  03_그룹함수.sql  */

/*
# 그룹 함수
- 하나 이상의 행을 그룹으로 묶어서 결과를 나타냅니다
- SELECT 문 뒤에 작성하고, 여러 그룹 함수를 쉼표로 구분하여 함께 사용할 수 있습니다
  Ex) SELECT group_function( column ), ....
      FROM table_name;
- 그룹 함수는 해당 컬럼 값이 null 인 것을 제외하고 계산합니다
*/

/*
SUM
- SUM 함수는 해당 컬럼 값들에 대한 총합을 구합니다
*/

-- 급여 총액
SELECT SUM(sal) FROM emp;


/*
AVG
- AVG 함수는 해당 컬럼 값들에 대한 평균을 구합니다
*/

-- 급여 평균
SELECT AVG(sal) FROM emp;
SELECT TRUNC(AVG(sal), 2) FROM emp;


/*
MAX, MIN
- 지정한 컬럼 값 중에서 최대값, 최소값을 구합니다
*/

-- 가장 높은 급여와 낮은 급여
SELECT MAX(sal), MIN(sal) FROM emp;


/*
COUNT
- 행의 갯수를 반환합니다
*/

-- 전체 사원수와 커미션 받는 사원수
SELECT COUNT(*), COUNT(comm) FROM emp;

-- 업무의 수
SELECT COUNT(job) AS "업무 수" FROM emp; -- 중복처리 X
SELECT COUNT(DISTINCT job) AS "업무 수" FROM emp; -- 중복처리 O


/*
# GROUP BY
- 어떤 컬럼 값을 기준으로 그룹 함수를 적용할 수 있습니다
  Ex) SELECT 컬럼명, 그룹함수
      FROM 테이블명
      WHERE 조건
      GROUP BY 컬럼명;
- GROUP BY 절 다음에는 컬럼의 별칭을 사용할 수 없고, 반드시 컬럼명을 사용해야 합니다
*/

-- 부서번호로 그룹
SELECT deptno FROM emp GROUP BY deptno;

-- 부서별 평균 급여
SELECT deptno, AVG(sal) FROM emp GROUP BY deptno;
SELECT deptno, TRUNC(AVG(sal), 2) FROM emp GROUP BY deptno;

-- 부서별 최대, 최소 급여 / 직급별 최대, 최소 급여
SELECT deptno, MAX(sal), MIN(sal) FROM emp GROUP BY deptno;
SELECT job, MAX(sal), MIN(sal) FROM emp GROUP BY job;

-- ORDER BY 절은 항상 마지막에 작성합니다
SELECT deptno, COUNT(*), COUNT(comm) FROM emp GROUP BY deptno ORDER BY deptno;


/*
# HAVING
- 그룹의 결과를 제한할 때 HAVING 절을 사용합니다
*/

-- 부서별 평균 급여를 구해서, 부서별 평균 급여가 2000 이상인 부서만 출력
SELECT deptno, TRUNC(AVG(sal), 1) FROM emp GROUP BY deptno HAVING AVG(sal) >= 2000;


/* Quiz */

-- 가장 최근에 입사한 사원의 입사일과 가장 오래된 사원의 입사일을 출력하세요
SELECT MAX(hiredate) AS "최근 입사한 사원", MIN(hiredate) AS "오래된 사원" FROM emp;

-- 부서별 커미션을 받는 사원의 수를 출력하세요
SELECT deptno, COUNT(comm) FROM emp GROUP BY deptno;

-- SALESMAN 의 급여에 대해서 평균, 최고액, 최저액, 합계를 출력하세요
SELECT TRUNC(AVG(sal), 1), MAX(sal), MIN(sal), SUM(sal) FROM emp WHERE job = 'SALESMAN';
SELECT TRUNC(AVG(sal), 1), MAX(sal), MIN(sal), SUM(sal) FROM emp WHERE job LIKE 'SALESMAN';

-- 각 부서별로 인원수, 급여 평균, 최저 급여, 최고 급여, 급여의 합을 구하고
-- 급여의 합이 높은 순서로 출력하세요
SELECT deptno, COUNT(*), TRUNC(AVG(sal), 1), MIN(sal), MAX(sal), SUM(sal) FROM emp GROUP BY deptno ORDER BY SUM(sal) DESC;

-- 직급별 급여의 평균이 3000 이상인 직급에 대해서 직급, 평균 급여, 급여의 합을 출력하세요
SELECT job, TRUNC(AVG(sal), 1), SUM(sal) FROM emp GROUP BY job HAVING AVG(sal) >= 3000;

-- 전체 월급이 4000을 초과하는 각 업무에 대해서 업무와 월급여 합계를 출력하세요
-- 단, SALESMAN 은 제외하고 월급여 합계로 내림차순 정렬합니다
SELECT job, SUM(sal) FROM emp WHERE job NOT LIKE 'SALESMAN' GROUP BY job HAVING SUM(sal) >= 4000 ORDER BY SUM(sal) DESC;




