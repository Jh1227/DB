show user;

-- 테이블 목록 확인
select * from tab;

-- 테이블 구조 확인
-- desc 테이블명;
-- : 테이블의 컬럼이름, 데이터 타입, 길이, NULL 허용 유무 등과 같은 특정 데이터 정보를 알려줍니다
desc dept;
-- DEPT 테이블 : 부서 정보
-- DEPTNO NOT NULL NUMBER(2)    - 부서번호
-- DNAME           VARCHAR2(14) - 부서명
-- LOC             VARCHAR2(13) - 부서 지역

desc emp;
-- EMP 테이블 : 사원 정보
-- EMPNO    NOT NULL NUMBER(4)    - 사원번호
-- ENAME             VARCHAR2(10) - 사원이름
-- JOB               VARCHAR2(9)  - 담당업무
-- MGR               NUMBER(4)    - 상사 사원번호
-- HIREDATE          DATE         - 입사일
-- SAL               NUMBER(7,2)  - 급여
-- COMM              NUMBER(7,2)  - 커미션
-- DEPTNO            NUMBER(2)    - 부서번호


/*
오라클 자료형
- NUMBER : 숫자 데이터를 저장
  > NUMBER ( precision, scale )
    : precision 은 소수점을 포함한 전체 자릿수를 의미하며, scale 은 소수점 이하 자릿수를 지정합니다
    EX) 정수 - NUMBER(5)
        실수 - NUMBER(10, 2) -> 10 : 소수점을 포함한 전체 자릿수
                                 2 : 소수점 자릿수
                        
- VARCHAR2 : 가변길이의 문자열 저장
  > VARCHAR2 ( 가변형 )
    EX) VARCHAR2(10) -> 최대 10글자까지 가능하고, 저장되는 문자수 만큼 공간 사용
  
- CHAR : 고정길이의 문자 데이터 저장
  > CHAR ( 고정형 )
    EX) CHAR(10) -> 10 글자 확정
    
- DATE : 날짜 및 시간    
*/


/*
# SELECT
  : 데이터를 조회하기 위한 SQL 명령어 입니다
  
# 형식
- SELECT [DISTINCT] { *, column, .... }
  FROM table_name;
  > SELECT 문은 반드시 SELECT 와 FROM 이라는 2개의 키워드로 구성되어야 합니다
    SELECT 절 뒤에는 출력하고자 하는 컬럼 이름을 기술합니다
    특정 컬럼 이름 대신 '*' 을 기술할 수 있는데, '*' 은 테이블 내의 모든 컬럼을 출력하고자 하는 경우에 사용합니다
    FROM 절 다음에는 조회하고자하는 테이블 이름을 기술합니다
*/


-- DEPT 테이블의 전체 목록
select * from dept;

-- 특정 데이터만 보기
-- : DEPT 테이블의 부서번호, 부서이름 조회
SELECT DEPTNO, DNAME
FROM DEPT;

SELECT * FROM emp;


-- 산술 연산
SELECT sal + comm FROM emp;  -- NULL 값은 계산 X
SELECT sal - 100 FROM emp;
SELECT sal * 12 FROM emp;
SELECT sal / 12 FROM emp;


/*
# NULL
- 행의 특정 열에 데이터 값이 없는 경우, 해당 값이 null 이거나 null 을 포함한다고 합니다
- 모든 데이터 유형은 null 을 포함할 수 있습니다
- 0(zero) 도 아니고, 빈 공간도 아닙니다
  미확정(해당 사항 없음), 알수 없는 값을 의미합니다
  ? 혹은 무한의 의미이므로 연산, 할당, 비교가 불가능 합니다
*/

SELECT ename, sal, job, comm, sal*12, sal*12+comm FROM emp;


/*
NVL 함수
- 컬럼의 값이 null 인 경우 지정한 값으로 출력하고, null 이 아니면 원래 값을 그대로 출력합니다
- NVL( 컬럼명, 지정값 )
*/
SELECT ename, comm, sal*12+comm, NVL(comm, 0), sal*12+NVL(comm, 0) FROM emp;


/*
# alias
- 열 머리글의 이름을 변경할 때 사용합니다
- 컬럼 이름 대신 별칭을 출력하고자 하면 컬럼을 기술한 바로 뒤에 AS 키워드를 사용한 후 별칭을 기술합니다
- 별칭을 부여할 때 대소문자를 섞어서 기술하면, 결과는 대문자로 출력됩니다
  이때, 대소문자를 구별하고 싶으면 " " 를 사용합니다
*/
SELECT ename, sal*12+NVL(comm, 0) AS Annsal FROM emp;

SELECT ename, sal*12+NVL(comm, 0) AS "A n n s a l" FROM emp;

SELECT ename, sal*12+NVL(comm, 0) AS "연봉" FROM emp;


/*
연결 연산자 - ||
- 여러개의 컬럼을 연결할 때 사용합니다
- 리터럴 SELECT 리스트에 포함된 문자, 숫자 또는 날짜 입니다
  숫자 리터럴은 그냥 사용해도 되지만, 문자 및 날짜 리터럴은 외따옴표(' ')로 작성해야 합니다
*/
SELECT ename || ' is a ' || job FROM emp;

SELECT ename || ' 은(는) ' || job || ' 이다' AS "업무" FROM emp;


/*
DISTINCT
- 기본적으로 쿼리 결과에는 중복 행을 포함한 모든 행이 표시됩니다
  이때, 중복행을 제거하려면 SELECT 키워드 바로 뒤에 DISTINCT 키워드를 사용합니다
*/
SELECT deptno FROM emp;

SELECT DISTINCT deptno FROM emp;


/* Quiz */
-- emp 테이블에서 사원의 이름, 급여, 입사일자만 출력하세요
SELECT ename, sal, hiredate FROM emp;

-- 부서정보 테이블의 deptno 는 부서번호, dname 은 부서명으로 별칭을 부여해서 출력하세요
SELECT deptno AS "부서번호", dname AS "부서명" FROM dept;

-- 사원정보 테이블의 직급이 중복되지 않고, 한번씩 나열되도록 출력하세요
SELECT DISTINCT job FROM emp;


/*
where 조건
- 원하는 행만 검색 할 때에는 행을 제한하는 조건을 SELECT 문에 WHERE 절을 추가합니다
- 형식
  SELECT * [ column, .... ]
  FROM table_name
  WHERE 조건식;
- = , > , < , >= , <= , !=
*/
SELECT * FROM emp;

-- 부서번호 10 인 항목
SELECT * FROM emp WHERE deptno = 10;

-- 이름이 ford 인 사원의 사원번호, 사원이름, 급여 확인
-- SQL 에서 문자열이나 날짜는 반드시 외따옴표 안에 작성해야 합니다
-- 테이블 내에 저장된 값은 대소문자를 구분합니다
SELECT empno, ename, sal FROM emp WHERE ename = 'FORD';

-- 1982년도 1월 1일 이전에 입사한 사원 확인
SELECT * FROM emp WHERE hiredate < '1982/01/01';


/*
논리연산자
- and, of, not
*/
-- 부서번호가 10번이면서, 직급이 MANAGER 인 사람 확인
SELECT * FROM emp WHERE deptno = 10 AND job = 'MANAGER';

-- 부서번호가 10번이거나, 직급이 MANAGER 인 직원 확인
SELECT * FROM emp WHERE deptno = 10 OR job = 'MANAGER';

-- 부서번호가 10번이 아닌 직원 확인
SELECT * FROM emp WHERE NOT deptno = 10;
SELECT * FROM emp WHERE deptno != 10;           

-- 2000 ~ 4000 사이의 급여를 받는 사원 확인
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 4000;

-- BETWEEN AND 연산자
-- 특정 범위의 값 확인
-- column_name BETWEEN a AND b
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 4000;

-- 1981년도에 입사한 사원 확인
SELECT * FROM emp WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31';


/*
IN 연산자
- 테이블의 값을 확인합니다
- column_name IN(a, b, c)
*/
SELECT * FROM emp;

-- 커미션이 300 이거나, 500 인 사원 확인
SELECT * FROM emp WHERE comm IN(300, 500);


/*
LIKE 연산자와 와일드 카드
- 검색하는 값을 정확히 모를 때에 검색이 가능합니다
- column_name LIKE pattern
  > % : 0 개 이상의 문자
    _ : 임의의 단일문자
*/
SELECT * FROM emp;

-- emp 테이블에서 이름이 M 으로 시작하는 모든 사원 확인
SELECT * FROM emp WHERE ename LIKE 'M%';

-- emp 테이블에서 이름에 O 가 들어있는 모든 사원 확인
SELECT * FROM emp WHERE ename LIKE '%O%';

-- emp 테이블에서 이름이 K 로 시작하면서 4글자인 사원 확인
SELECT * FROM emp WHERE ename LIKE 'K___';

-- 이름에 A 를 포함하지 않는 사원 확인
SELECT * FROM emp WHERE ename NOT LIKE '%A%';

-- emp 테이블에 comm 컬럼의 값이 null 인 항목 확인
SELECT * FROM emp WHERE comm IS null;


/*
# ORDER BY
- 데이터를 정렬할 때 사용합니다
- 정렬방식을 지정하지 않으면, 기본적으로 오름차순 정렬합니다
*/
SELECT * FROM emp;

-- emp 테이블의 급여를 기준으로 오름차순 정렬
SELECT sal FROM emp;
SELECT * FROM emp ORDER BY sal ASC;

-- emp 테이블의 급여를 기준으로 내림차순 정렬
SELECT * FROM emp ORDER BY sal DESC;

-- emp 테이블의 급여를 기준으로 내림차순 정렬하고, 급여가 같으면 이름을 기준으로 오름차순 정렬
SELECT * FROM emp ORDER BY sal DESC, ename ASC;


/* Quiz */
-- emp 테이블에서 급여가 3000 이상인 사원의 사원번호, 이름, 직급, 급여를 출력하세요
SELECT empno, ename, job, sal FROM emp WHERE sal >= 3000;

-- emp 테이블에서 직급이 MANAGER 인 사원의 사원번호, 이름, 직급, 급여, 부서번호를 출력하세요
SELECT empno, ename, job, sal, deptno FROM emp WHERE job = 'MANAGER';

-- emp 테이블에서 사원번호가 7902, 7782, 7566 인 사원의 사원번호, 성명, 직급, 급여, 입사일자를 출력하세요
SELECT empno, ename, job, sal, hiredate FROM emp WHERE empno IN(7902, 7782, 7566);

-- emp 테이블에서 직급이 MANAGER, CLERK 이 아닌 사원의 사원번호, 성명, 직급, 급여, 부서번호를 출력하세요
SELECT empno, ename, job, sal, deptno FROM emp WHERE job != 'MANAGER' AND job != 'CLERK';
SELECT empno, ename, job, sal, deptno FROM emp WHERE job NOT IN('MANAGER', 'CLERK');

-- emp 테이블에서 부서번호로 오름차순 정렬한 후에,
-- 부서번호가 같으면 급여가 많은 순서로 정렬하여 사원번호, 성명, 직급, 부서번호, 급여를 출력하세요
SELECT empno, ename, job, deptno, sal FROM emp ORDER BY deptno ASC, sal DESC;



