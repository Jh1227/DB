
/*  14_PL_SQL.sql  */

/*
# PL/SQL ( Oracle Procedural Language extension to SQL )
- SQL 문장에서 변수정의, 조건처리(IF), 반복처리(LOOP) 등을 지원하며,
  오라클 자체에 내장되어 있는 절차적 언어로써 SQL 문의 단점을 보완해 줍니다
- DECLARE ~ BEGIN ~ EXCEPTION ~ END 순서를 갖습니다
  > 선언부 ( DECLARE SECTION )
    : PL/SQL 에서 사용되는 변수, 상수를 선언
    
    실행부 ( EXECUTABLE SECTION )
    : 절차적 형식으로 SQL 문을 실행할 수 있도록 제어문, 반복문 등을 기술하는 부분으로
      BEGIN 으로 시작합니다
      
    예외처리 ( EXCEPTION SECTION )
    : PL/SQL 문이 실행되는 중에 에러가 발생할 수 있는데, 이를 예외라고 합니다
*/

/*
# PL/SQL 프로그램 작성
- PL/SQL 블록 내에서 한 문장이 종료될 때 마다 세미콜론(;)을 사용합니다
- END 뒤에 ; 을 사용하여 하나의 블록이 끝났다는 것을 알려줍니다
*/

-- 오라클에서 제공해주는 프로시저를 사용하여 출력해 주는 내용을 화면에 보여주도록 설정
SET SERVEROUTPUT  ON;

-- 메세지 출력
-- > 화면 출력을 위해서 PUT_LINE 프로시저를 이용합니다
--   오라클이 제공해주는 프로시저로 DBMS_OUTPUT 팩키지에 있습니다
BEGIN
    DBMS_OUTPUT.PUT_LINE('hello oracle~^^');
END;


/*
# 변수 선언
- 변수를 선언할 때에는 변수명 다음에 자료형을 기술합니다
*/

-- 변수 선언
VEMPNO NUMBER(4);
VENAME VARCHAR2(10);

-- 변수 값 지정
VEMPNO := 7890;
VENAME := 'TEST';

-- 변수 선언하고 출력
DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
BEGIN
    VEMPNO := 7890;
    VENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;

-- 레퍼런스
-- 이전에 선언된 다른 변수 또는 데이터베이스 컬럼에 맞추어 변수 선언
-- '%TYPE' 속성 사용
REMPNO EMP.EMPNO%TYPE;
RENAME EMP.ENAME%TYPE;
-- REMPNO, RENAME 변수는 EMP 테이벌의 해당 컬럼 자료형과 크기를 그대로 참조


/*
# PL/SQL SELECT
- 테이블의 행에서 질의된 값을 변수에 할당시키기 위해서 SELECT 문장을 사용합니다
  PL/SQL 의 SELECT 문은 INTO 절이 필요한데, INTO 절에는 데이터를 저장할 변수를 작성합니다
- SELECT 절에 있는 컬럼은 INTO 절에 있는 변수와 1:1 대응을 하기 때문에
  갯수, 데이터형, 길이가 일치해야 합니다
  SELECT select_list
  INTO variable_name, ...
  FROM table_name
  WHERE condition;
*/

-- EMP 테이블의 사원번호, 이름 조회
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE('-----------');
    
    SELECT EMPNO, ENAME INTO VEMPNO, VENAME
    FROM EMP
    WHERE ENAME='SMITH';
    
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;


/*
# ROWTYPE 레퍼런스 변수
- ROW(행) 단위로 참조하는 자료형으로 만들어진 변수
- 특정 테이블의 컬럼의 갯수와 데이터 형식을 모르더라도 지정할 수 있습니다
*/
/ -- 이렇게 설정해 놓으면 드레그 할 필요가 없다
DECLARE
    VEMP EMP%ROWTYPE;
BEGIN
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME='SMITH';
    
    --DBMS_OUTPUT.PUT_LINE(VEMP);
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('사원급여 : ' || VEMP.SAL);
END;
/

/*
# IF - THEN - END IF
- IF condition THEN -> 조건문
       statements;  -> 조건문이 참이면 실행
  END IF;
*/

SELECT * FROM DEPT;
SELECT * FROM EMP;
-- 10	ACCOUNTING	NEW YORK
-- 20	RESEARCH	DALLAS
-- 30	SALES	CHICAGO
-- 40	OPERATIONS	BOSTON
-- 50	DATABASE	KOR

-- 7369, 7499, 7521, 7566, 7654, 7698, 7782, 7839, 7844, 7900, 7901, 7934
-- 부서번호를 사용해서 부서명 출력
/
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
    VDEPTNO EMP.DEPTNO%TYPE;
    VDNAME VARCHAR(20) := NULL;
BEGIN
    SELECT EMPNO, ENAME, DEPTNO
    INTO VEMPNO, VENAME, VDEPTNO
    FROM EMP
    WHERE EMPNO = 7369;
    
    IF(VDEPTNO = 10) THEN
        VDNAME := 'ACCOUNTING';
    END IF;
    IF(VDEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    END IF;
    IF(VDEPTNO = 30) THEN
        VDNAME := 'SALES';
    END IF;
    IF(VDEPTNO = 40) THEN
        VDNAME := 'OPERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름 / 부서명');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME || ' / ' || VDNAME);
    
END;
/


/*
# IF THEN  ESLIF ~ ELSE ~ END IF
*/

-- 부서번호를 사용해서 부서명 출력
/
DECLARE
    VEMP EMP%ROWTYPE;
    VDNAME VARCHAR(20) := NULL;
BEGIN
    SELECT * 
    INTO VEMP
    FROM EMP
    WHERE ENAME = 'SMITH';
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNTING';
    ELSIF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    ELSIF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    ELSIF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름 / 부서명');
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' / ' || VEMP.ENAME || ' / ' || VDNAME);   
    
END;
/


/*
# BASIC LOOP
- 조건없이 반복 작업 실행
  LOOP
    statement;
    ....
    EXIT'
  END LOOP;
*/

-- 1 ~ 5 까지 출력
DECLARE
    NO NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (NO);
        NO := NO + 1;
        IF NO > 5 THEN
            EXIT;
        END IF;
    END LOOP;
    
END;


/*
# FOR LOOP
- FOR index IN 시작값..종료값 (.. <있어야 함)
    statement;
    ....
  END LOOP;
  
  > index 는 자동 선언되는 BINARY_INTEGER 형 변수. 1씩 증가
*/

-- 1 ~ 5 까지 출력
/
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('- FOR LOOP -');
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/


/*
# WHILE LOOP
- WHILE condition LOOP
    statement;
    ....
  END LOOP;
*/

-- 1 ~ 5 까지 출력
/
DECLARE
    NO NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('- WHILE LOOP -');
    WHILE NO <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(NO);
        NO := NO + 1;
    END LOOP;
END;
/


/* -Quiz- */

-- EMP 테이블에서 사원이름을 사용해서, 해당 사원의 연봉을 구하세요
-- 커미션이 없으면 0으로 변환해서 연봉을 구합니다
/
SELECT ENAME, COMM FROM EMP;
DECLARE
    VEMP EMP%ROWTYPE;
BEGIN
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME='ALLEN';
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('사원연봉 : ' || (VEMP.SAL+NVL(VEMP.COMM, 0)));
END;
/
-- 강사님 풀이 
/
DECLARE
    VEMP EMP%ROWTYPE;
    ANNSAL NUMBER(7, 2);
BEGIN
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME = 'SMITH';
    -- 연봉 계산
    IF(VEMP.COMM IS NULL) THEN
        VEMP.COMM := 0;
    END IF;
    ANNSAL := VEMP.SAL * 12 + VEMP.COMM;
    
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || ANNSAL);
END;
/
-- 구구단 7단의 값을 모두 출력하세요
/
DECLARE
    NO NUMBER := 7;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (NO);
        NO := NO + 7;
        IF NO > 65 THEN
            EXIT;
        END IF;
    END LOOP;
    
END;
/
-- 강사님 풀이
/
DECLARE
    DAN NUMBER := 7;
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (DAN || ' X ' || I || ' = ' || (DAN*I));
        I := I + 1;
        IF I > 9 THEN
            EXIT;
        END IF;
    END LOOP;
    
END;
/
-- FOR LOOP 을 사용해서 부서번호를 생성하고,
-- 이 값을 SELECT 문에 적용해서 부서정보를 출력하세요
-- > 부서번호, 부서명, 지역
/
DECLARE
    VDEPT DEPT%ROWTYPE;
BEGIN
    FOR DN IN 1..4 LOOP
        SELECT * INTO VDEPT
        FROM DEPT
        WHERE DEPTNO = DN*10;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' || VDEPT.LOC);
    END LOOP;
END;
/

