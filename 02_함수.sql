show user;

/*
# 함수
- 단일행 함수 : 여러건의 데이터를 한번에 하나씩만 처리하는 함수입니다
  여러행 함수 : 여러건의 데이터를 입력받아서 결과값 한건을 만들어주는 함수입니다
*/

-- DUAL 테이블
-- 한행으로 결과를 출력하기 위한 테이블 입니다

-- 결과를 한줄로 얻기 위해서 오라클에서 제공하는 테이블 입니다
SELECT 24*12 FROM DUAL;

-- DUAL 테이블은 DUMMY 라는 하나의 컬럼으로 구성되어 있습니다
DESC DUAL;

-- DUAL 테이블은 DUMMY 라는 하나의 칼럼에 X 라는 하나의 로우만을 저장하고 있지만 의미없는 값입니다
-- 쿼리문의 수행 결과를 하나의 로우로 출력되게 하기 위해서 하나의 로우를 구성하고 있는 것입니다
SELECT * FROM DUAL;



/*
    숫자 함수
*/

-- ABS
-- 절대값을 구하는 함수입니다
SELECT -10, ABS(-10) FROM DUAL;

-- FLOOR
-- 소수점 아래를 버리는 함수입니다
SELECT 12.1234, FLOOR(12.1234) FROM DUAL;

-- ROUND
-- 반올림하는 함수입니다
SELECT 34.5678, ROUND(34.5678) FROM DUAL;
SELECT 34.5678, ROUND(34.5678, 2) FROM DUAL;

-- TRUNC
-- 지정한 자릿수 이하를 버린 결과입니다
-- 함수의 2번째 인자값이 2이면, 소수점 이하 세번째 자리에서 버림 연산을 합니다
SELECT TRUNC(34.5678, 2), TRUNC(34.5678) FROM DUAL;

-- MOD
-- 나눗셈 연산을 한 후에 나온 나머지를 구하는 함수입니다
SELECT MOD(10, 3), MOD(10, 4) FROM DUAL;



/*
    문자 함수
*/

-- UPPER
-- 대문자로 변환하는 함수입니다
SELECT 'Hello Oracle', UPPER('Hello Oracle') FROM DUAL;

-- LOWER
-- 소문자로 변환하는 함수입니다
SELECT 'Hello Oracle', LOWER('Hello Oracle') FROM DUAL;

-- INITCAP
-- 문자열의 이니셜(단어의 첫 글자)만 대문자로 변경합니다
SELECT 'hello oracle', INITCAP('hello oracle') FROM DUAL;

-- LENGTH
-- 칼럼에 저장된 데이터의 값이 몇개의 문자로 되어있는지 계산합니다
SELECT LENGTH('ORACLE'), LENGTH('오라클') FROM DUAL;

-- LENGTHB
-- 문자열의 길이를 byte 단위로 처리합니다
SELECT LENGTHB('ORACLE'), LENGTHB('오라클') FROM DUAL;

-- SUBSTR
-- 문자열의 시작 위치부터 선택 개수만큼의 문자를 추출합니다
-- : SUBSTR( 대상, 시작위치, 추출할 갯수 )
--   오라클에서 index 는 1부터 시작
SELECT SUBSTR('oracle string test', 8, 6) FROM DUAL;

-- 시작 위치 인자값에 음수를 적용할 수 있는데, 이때는 문자열의 뒤에서부터 시작 위치가 적용됩니다
SELECT SUBSTR('oracle string test', -4, 4) FROM DUAL;

DESC emp;
SELECT hiredate FROM emp;

-- emp 테이블에서 입사년도, 월만 출력
SELECT SUBSTR(hiredate, 1, 2) 년도, SUBSTR(hiredate, 4, 2) 월 FROM emp;

-- 12월에 입사한 사원을 출력
SELECT * FROM emp WHERE SUBSTR(hiredate, 4, 2) = '12';
SELECT * FROM emp WHERE SUBSTR(hiredate, 1, 2) = '81' AND SUBSTR(hiredate, 4, 2) = '12';

-- INSTR
-- 특정 문자가 있는 위치를 알려줍니다
-- : INSTR( 대상, 검색글자, 시작위치, 몇번째 검색 )
SELECT INSTR('step by step', 't') FROM DUAL;        -- 대상, 검색글자
SELECT INSTR('step by step', 't', 3) FROM DUAL;     -- 대상, 검색글자, 시작위치
SELECT INSTR('step by step', 'e', 2, 2) FROM DUAL;  -- 대상, 검색글자, 시작위치, 몇번째 검색
SELECT INSTR('데이터베이스', '이') FROM DUAL;
SELECT INSTR('데이터베이스', '이', 3) FROM DUAL;

-- LPAD
-- 대상 문자열을 명시된 자릿수에서 오른쪽에 표시하고, 남은 왼쪽 자리들은 기호로 채웁니다
-- : LPAD( 대상, 자릿수, 기호 )
SELECT LPAD('padding', 10, '#') FROM DUAL;

-- LTRIM
-- 문자열의 왼쪽(앞)의 공백 문자들을 제거합니다
SELECT LTRIM('     trim test     ') FROM DUAL;

-- RTRIM
-- 문자열의 오른쪽(뒤)의 공백 문자들을 제거합니다
SELECT RTRIM('     trim test     ') FROM DUAL;

-- TRIM
-- 문자열의 양쪽(앞,뒤)의 공백 문자들을 제거합니다
SELECT TRIM('     trim test     ') FROM DUAL;



/*
    날짜 함수
*/

-- SYSDATE
-- 시스템의 현재 날짜를 반환하는 함수입니다
SELECT SYSDATE FROM DUAL;

-- 날짜 연산
-- 날짜 + 숫자 : 해당 날짜부터 그 기간만큼 지난 날짜를 계산
-- 날짜 - 숫자 : 해당 날짜부터 그 기간만큼 이전 날짜를 계산
-- 날짜 - 날짜 : 두 날짜 사이의 기간을 계산
SELECT SYSDATE -1 어제, SYSDATE 오늘, SYSDATE +2 모레 FROM DUAL;
SELECT (SYSDATE -1) - (SYSDATE) FROM DUAL;


-- ROUND 에 포맷 모델 날짜를 사용해서, 날짜를 반올림 할 수 있습니다
-- : 포맷 모델       단위
--   DDD            일을 기준
--   HH             시를 기준
--   MONTH          월을 기준( 16일 기준 )

--  emp 테이블의 입사일자를 월을 기준으로 반올림
SELECT ename, hiredate, ROUND(hiredate, 'MONTH') FROM emp;


-- TRUNC 함수에 포맷 형식을 사용해서, 날짜를 잘라낼 수 있습니다

-- emp 테이블의 입사일자의 월을 기준으로 날짜 자르기
SELECT ename, hiredate, TRUNC(hiredate, 'MONTH') FROM emp;


-- MONTHS_BETWEEN
-- 날짜와 날짜 사이의 개월수를 구합니다
-- : MONTHS_BETWEEN( date_1, date_2 )

-- 직원들의 근무한 개월수
SELECT ename, sysdate, hiredate, MONTHS_BETWEEN( sysdate, hiredate ) FROM emp;
SELECT ename, sysdate, hiredate, TRUNC(MONTHS_BETWEEN( sysdate, hiredate )) FROM emp;


-- ADD_MONTHS
-- 특정 개월수를 더한 날짜를 구합니다
-- : ADD_MONTHS( date, number )

-- 입사일에 6개월을 더한 날짜
SELECT ename, hiredate, ADD_MONTHS(hiredate, 6) FROM emp;


-- NEXT_DAY
-- 날짜를 기준으로 최초로 돌아오는 요일에 해당하는 날짜를 반환하는 함수입니다
-- : NEXT_DAY( date, 요일 )

-- 오늘 기준으로 최초로 돌아오는 화요일
SELECT SYSDATE, NEXT_DAY( sysdate, '화요일') FROM DUAL;


-- LAST_DAY
-- 해당 날짜가 속한 달의 마지막 날짜를 반환하는 함수입니다

-- emp 테이블의 입사한 달의 마지막 날
SELECT hiredate, LAST_DAY(hiredate) FROM emp;


/*
# 형변환 함수
- 숫자, 문자, 날짜의 데이터 타입을 다른 데이터 타입으로 변환합니다
- TO_CHAR    : 날짜 또는 숫자 타입을 문자형으로 변환
  TO_DATE    : 문자 타입을 날짜 타입으로 변환
  TO_NUMBER  : 문자 타입을 숫자 타입으로 변환
*/

/*
TO_CHAR( 날짜 데이터, '출력형식' )
- 출력형식 종류      의미
  YYYY              년도(4자리)
  YY                년도(2자리)
  MM                월을 숫자로 표현
  MON               월을 알파벳으로 표현
  DAY               요일 표현
*/
-- 현재 날짜를 다른 형태로 출력
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;

-- emp 테이블 사원 입사일의 요일 출력
SELECT hiredate, TO_CHAR(hiredate, 'YYYY.MM.DD DAY') FROM emp;

/*
시간 종류 출력       의미
AM or PM            오전(AM), 오후(PM)
HH or HH12          시간(1 ~ 12)
HH24                24시간
MI                  분
SS                  초
*/
-- 현재 날짜와 시간 출력
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH24:MI:SS') "현재 시간" FROM DUAL;

/*
숫자 출력 형식
구분     의미
0       자릿수를 나타내며, 자릿수가 맞지 않을 경우 0 으로 채운다
9       자릿수를 나타내며, 자릿수가 맞지 않을 경우 채우지 않는다
L       통화 기호를 앞에 표시
.       소수점
,       천단위 자리 구분
*/
-- 숫자 12300 을 문자 형태로 변환
SELECT TO_CHAR(12300) FROM DUAL;

-- 자리 채우기 
SELECT TO_CHAR(123456, '00000000'), TO_CHAR(123456, '99999999') FROM DUAL;

-- 통화기호를 붙이면서, 천단위마다 ',' 출력
SELECT ename, sal, TO_CHAR(sal, 'L999,999') FROM emp;


/*
TO_DATE
- 문자열을 날짜 형식으로 변환합니다
- : TO_DATE( '문자', 'format' )
*/

-- 숫자를 날짜형으로 변환
SELECT ename, hiredate FROM emp WHERE hiredate = TO_DATE(19801217, 'YYYYMMDD');

-- 몇일이 지났는지 계산
SELECT TRUNC(SYSDATE - TO_DATE('2022/01/26', 'YYYY/MM/DD')) FROM DUAL;


/*
TO_NUMBER
- 데이터를 숫자형으로 변환
*/

SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('12,000', '99,999') FROM DUAL;


/* Quiz */
SELECT * FROM emp;

-- emp 테이블에서 사원번호가 홀수인 사원을 출력하세요
SELECT * FROM emp WHERE MOD(empno, 2) = 1;

-- 소문자 manager 로 직급 검색해서 출력하세요
SELECT * FROM emp WHERE job = UPPER('manager');

-- emp 테이블에서 조회하는 이름을 소문자로 사용해서 사원번호, 이름, 직급, 부서번호를 출력하세요
SELECT empno, ename, job, deptno, LOWER(empno), LOWER(ename), LOWER(job), LOWER(deptno) FROM emp;
SELECT empno, ename, job, deptno FROM emp WHERE LOWER(ename) = 'smith';

-- dept 테이블에서 첫글자만 대문자로 변환하여 모든 정보를 출력하세요
SELECT deptno, INITCAP(dname), INITCAP(loc) FROM dept;

-- SUBSTR 함수를 사용해서 emp 테이블의 ename 컬럼의 마지막 문자 하나만 추출해서 이름이 E 로 끝나는 사원을 출력하세요
SELECT * FROM emp WHERE SUBSTR(ename, -1, 1) = 'E' ;

-- emp 테이블에서 이름의 세번째 자리가 R 인 사원을 출력하세요
SELECT ename FROM emp WHERE INSTR(ename, 'R') = 3;
SELECT ename FROM emp WHERE SUBSTR(ename, 3, 1) = 'R';
SELECT ename FROM emp WHERE ename LIKE '__R%';

-- emp 테이블에서 20번 부서의 사원번호, 이름, 이름의 글자수, 급여, 급여의 자릿수를 출력하세요
SELECT empno, ename, LENGTH(ename), sal, LENGTH(sal) FROM emp WHERE deptno = 20;

-- emp 테이블에서 현재까지 근무일수가 몇일인지를 구하고, 근무일수가 많은 순서로 출력하세요
SELECT ename, hiredate, SYSDATE, TRUNC(SYSDATE - hiredate)"근무일수" FROM emp ORDER BY TRUNC(SYSDATE - hiredate) DESC;


/*
DECODE
- switch case 문과 같은 기능을 합니다
- DECODE ( 표현식, 조건_A, 결과_A
                   조건_B, 결과_B
                   기본결과 ) 
*/
SELECT * FROM emp;
SELECT * FROM dept;

-- emp 테이블에 부서번호에 해당되는 부서명을 구하기
SELECT ename, deptno,
    DECODE(deptno, 10, 'ACCOUNTING',
                   20, 'RESEARCH',
                   30, 'SALES')
AS "부서명" 
FROM emp ORDER BY "부서명";


/*
CASE
- 여러가지 경우에 대해서 하나를 선택하는 함수입니다
  다양한 비교 연산자를 사용해서 조건을 적용할 수 있습니다
  if ~ else if 와 유사합니다
- CASE 표현식 WHEN 조건_A THEN 결과_A
              WHEN 조건_B THEN 결과_B
              ELSE 결과
  END
*/

SELECT ename, deptno,
    CASE WHEN deptno <= 10 THEN '회계'
         WHEN deptno <= 20 THEN '마케팅'
         ELSE '영업'
    END AS "부서명" 
FROM emp;


/* quiz */

SELECT * FROM emp;
-- emp 테이블을 사용해서 직급(job)에 따라서 급여를 인상하는 쿼리문을 작성하세요
-- ANALYST  -> 5%
-- MANAGER  -> 10%
-- SALESMAN -> 15%
-- CLERK    -> 20%
SELECT ename, job, sal, CASE WHEN job = 'ANALYST' THEN '5%'
                             WHEN job = 'MANAGER' THEN '10%'
                             WHEN job = 'SALESMAN' THEN '15%'
                             WHEN job = 'CLERK' THEN '20%'
                             ELSE '0%'
                        END AS "급여인상"
FROM emp;

SELECT ename, job, sal, DECODE(job, 'ANALYST', sal+sal*0.05,
                                    'MANAGER', sal+sal*0.1,
                                    'SALESMAN', sal+sal*0.15,
                                    'CLERK', sal+sal*0.2)
                        AS "급여인상"
FROM emp;

-- emp 테이블을 사용해서 급여액에 따라 고액, 보통, 저액을 출력하는 쿼리문을 작성하세요
-- 3000이상 -> 고액
-- 1000이상 -> 보통
-- 그외     -> 저액
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN '고액'
                             WHEN sal >= 1000 THEN '보통'
                             ELSE '저액'
                        END AS "급여 등급"
FROM emp;



