
/*  13_시스템권한.sql  */

/*
# 데이터베이스 보안을 위한 권한
- 시스템 권한, 객체 권한으로 나누어 집니다

# 시스템 권한
- 사용자 생성과 제거, DB 접근 및 여러가지 객체를 생성할 수 있는 권한 등 주로 DBA 에 의해 부여됩니다

# 객체 권한
- 테이블, 뷰 등의 객체
*/


/*
# 사용자 생성
- 사용자 계정을 생성하기 위해서는 시스템 권한을 가진 SYSTEM 으로 접속해야 합니다
  CREATE USER '사용자 이름'
  IDENTIFIED BY '사용자 암호'
  [ WITH ADMIN OPTION ];
*/

-- SYSTEM 계정 연결

-- TEST 계정 생성 (SYSTEM 계정에서 해야함)
CREATE USER TEST
IDENTIFIED BY TEST1234;

-- 생성된 계정 목록 확인 (SYSTEM 계정에서 해야함)
SELECT * FROM ALL_USERS;


/*
# GRANT
- 사용자에게 시스템 권한을 부여할 때 사용하는 명령어 입니다
  GRANT privilege_name, ....
  TO user_name;
*/

-- SYSTEM 계정 연결

-- CREATE SESSION : 데이터베이스에 접속할 수 있는 권한 부여
GRANT CREATE SESSION TO TEST;

CONN TEST/TEST1234;


/*
# WITH ADMIN OPTION
- 사용자에게 시스템 권한을 WITH ADMIN OPTION 과 함께 부여하면,
  시스템 권한을 다른 사용자에게도 부여 할 수 있습니다
*/

-- SYSTEM 계정

-- USER01 계정 생성
CREATE USER USER01 IDENTIFIED BY USER01;

-- USER02 계정 생성
CREATE USER USER02 IDENTIFIED BY USER02;

-- USER02 계정에 연결 권한 부여
GRANT CREATE SESSION TO USER02 WITH ADMIN OPTION;

-- USER02 계정 연결
CONN USER02/USER02;

-- USER02 계정으로 USER01 계정에 연결 권한 부여
GRANT CREATE SESSION TO USER01;


/*
# 객체 권한
- 특정 객체의 조작을 할 수 있는 권한입니다. 객체의 소유자는 객체에 대한 모든 권한을 가집니다
  GRANT privilege_name [column_name] || ALL -> 권한
  ON object_name | role_name | public       -> 객체 선택
  TO user_name;                             -> 사용자
*/

-- USER01 계정 연결
CONN USER01/USER01;

-- SCOTT 계정의 EMP 테이블 조회
-- > EMP 테이블은 SCOTT 소유자의 테이블이므로 접근 불가
SELECT * FROM SCOTT.EMP;

-- SCOTT 계정 연결
CONN SCOTT/tiger;

-- SCOTT 소유의 EMP 테이블을 조회할 수 있는 권한을 USER01 계정에 부여
GRANT SELECT ON EMP TO USER01;

-- USER01 계정 연결
CONN USER01/USER01;

-- 자신이 소유한 객체가 아닌 경우에는 그 객체를 소유한 사용자명(스키마)를 반드시 지정해야 합니다
-- > 스키마(schema) : 객체를 소유한 사용자명
SELECT * FROM SCOTT.EMP;


/*
# 사용자에게 부여된 권한 조회
- 자신에게 부여된 사용자 권한 정보 조회
  SELECT * FROM USER_TAB_PRIVS_RECD;
  
  다른 사용자에게 부여한 권한 정보 조회
  SELECT * FROM USER_TAB_PRIVS_MADE;
*/

-- SCOTT 계정 연결
SELECT * FROM USER_TAB_PRIVS_RECD;

SELECT * FROM USER_TAB_PRIVS_MADE;


/*
# REVOKE
- 사용자에게 부여한 객체 권한을 데이터베이스 관리자나 소유자로 부터 철회할 때에는 REVOKE 명령어를 사용합니다
  REVOKE privilege_name | ALL           -> 철회하는 객체 권한
  ON object_name                        -> 객체 지정
  FROM user_name | role_name | public;  -> 부여한 사용자명
*/

-- SCOTT 계정 연결
CONN SCOTT/tiger;

-- 부여한 권한 확인
SELECT * FROM USER_TAB_PRIVS_MADE;

-- USER01 사용자에게서 EMP 테이블에 대한 SELECT 권한 철회
REVOKE SELECT ON EMP FROM USER01;

-- USER01 계정 연결
CONN USER01/USER01;

-- 권한 철회 되었기 때문에 조회 불가
SELECT * FROM SCOTT.EMP;


/*
# WITH GRANT OPTION
- 사용자에게 객체 권한을 WITH GRANT OPTION 과 함께 부여하면, 
  해당 사용자는 그 객체에 접근할 수 있는 권한을 부여 받으면서
  해당 권한을 다른 사용자에게도 부여할 수 있는 권한도 같이 부여 받게 됩니다
*/

-- SCOTT 계정 연결
CONN SCOTT/tiger;

-- USER02 에게 SCOTT 계정의 EMP 테이블에 SELECT 하는 권한을 WITH GRANT OPTION 으로 부여
GRANT SELECT ON SCOTT.EMP TO USER02
WITH GRANT OPTION;

-- USER02 계정 연결해서 SCOTT 계정의 EMP 테이블 조회
CONN USER02/UESR02;

SELECT * FROM SCOTT.EMP;

-- USER02 가 받은 SELECT 권한을 USER01 에게도 부여
GRANT SELECT ON SCOTT.EMP TO USER01;

-- USER01 계정 연결해서 SCOTT 계정의 EMP 테이블 조회
CONN USER01/USER01;

SELECT * FROM SCOTT.EMP;

-- SCOTT 계정 연결해서 SELECT 권한 철회
CONN SCOTT/tiger;

REVOKE SELECT ON EMP FROM USER02;

--------------------------------------------------------------------------------


/*
# 롤 ( role )
- 사용자에게 보다 효율적으로 권한을 부여할 수 있도록 여러개의 권한을 묶어 놓은 것입니다
- 다수의 사용자에게 공통적으로 필요한 권한들을 롤을 사용해서 하나의 그룹으로 묶어놓고,
  사용자에게 롤에 대한 권한을 부여 함으로써 간단하게 권한을 부여할 수 있습니다
  
- CONNECT 롤
  > 사용자가 데이터베이스에 접속 가능하도록 하는 시스템 권한을 묶어 놓았습니다
  
  RESOURCE 롤
  > 사용자가 객체를 생성할 수 있도록 하는 권한을 묶어 놓았습니다
  
  DBA 롤
  > 사용자들이 소유한 데이터베이스 객체를 관리하고, 사용자들을 생성, 변경, 제거할 수 있는
    모든 권한을 가집니다
*/

-- SYSTEM 계정 연결

-- 롤에 포함된 권한 확인
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE='CONNECT';

SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE='CONNECT';

-- USER03 계정 생성
CREATE USER USER03 IDENTIFIED BY USER03;

-- USER03 계정에게 CONNECT, RESOURCE 권한 부여
GRANT CONNECT, RESOURCE TO USER03;

-- USER03 계정 연결
CONN USER03/USER03;


/*
# 사용자 롤 정의
- CREATE ROLE 명령어로 사용자 정의 롤을 생성할 수 있습니다
  CREATE ROLE role_name;
  GRANT privilege_name TO role_name;
- 롤 생성, 시스템 권한일 경우에는 DBA 에서 작업
  객체 권한일 경우에는 특정 객체로 접근해서 작업
- 롤 작업 순서
  1. 롤을 생성 ( 관리자 계정 )
  2. 롤에 권한 부여 ( 관리자 계정 or 사용자 계정 )
  3. 사용자에게 롤 부여 ( 관리자 계정)
*/

-- 시스템 권한 롤
-- SYSTEM 계정 연결
CONN SYSTEM/oracle;

-- 사용자 롤 생성
CREATE ROLE A_ROLE;

-- 생성된 롤에 권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO A_ROLE;

-- USER04 계정 생성해서 롤 부여
CREATE USER USER04 IDENTIFIED BY USER04;

GRANT A_ROLE TO USER04;

CONN USER04/USER04;

-- 객체 권한 롤
-- 관리자 계정 연결
CONN SYSTEM/oracle;

-- 객체 권한을 가질 롤 생성
CREATE ROLE A_OBJECT;

-- SCOTT 계정 연결
CONN SCOTT/tiger;

-- A_OBJECT 롤에 EMP 테이블을 조회할 수 있는 SELECT 권한 부여
GRANT SELECT ON EMP TO A_OBJECT;

-- 관리자 계정 연결
CONN SYSTEM/oracle;

-- 관리자 계정에서 USER04 계정에 A_OBJECT 롤 부여
GRANT A_OBJECT TO USER04;

-- USER04 계정 연결
CONN USER04/USER04;

-- 권한 부여 확인
SELECT * FROM USER_ROLE_PRIVS;

SELECT * FROM SCOTT.EMP;


/*
# 롤 회수
- REVOKE role_name 
  FROM user_name;
*/

-- 관리자 계정 연결
CONN SYSTEM/oracle;

-- 롤 회수
REVOKE A_OBJECT FROM USER04;
REVOKE A_ROLE FROM USER04;


/*
# 롤 삭제
- 사용하지 않는 롤은 DROP ROLE 명령어를 사용해서 제거합니다
  DROP ROLE role_name;
*/

-- 관리자 계정 연결
CONN SYSTEM/oracle;

-- 롤 삭제
DROP ROLE A_ROLE;
DROP ROLE A_OBJECT;


/*  -Quiz-  */

-- DBTEST_A 계정을 생성하고, 기본 2개의 롤 권한( CONNECT, RESOURCE ) 을 부여합니다
-- > 1. 계정 생성
--   2. 생성된 계정에 롤 부여
--   3. ALTER USER 계정명 DEFAULT TABLESPACE USERS; -> 데이터베이스 저장되는 공간 지정
--   4. ALTER USER 계정명 QUOTA UNLIMITED ON USERS; -> tablespace 용량 지정

CONN SYSTEM/oracle;

CREATE USER DBTEST_A IDENTIFIED BY DBTEST_A;

SELECT * FROM ALL_USERS;

GRANT CONNECT, RESOURCE TO DBTEST_A;
ALTER USER DBTEST_A DEFAULT TABLESPACE USERS;
ALTER USER DBTEST_A QUOTA UNLIMITED ON USERS;

-- DBTEST_A 계정에 회원 정보를 관리하는 TABLE 을 생성합니다
-- SEQ     - 회원수        : 시퀀스 적용
-- ID      - 회원 ID       : 중복X, NULL값 사용 불가
-- NAME    - 회원 이름     : NULL 값 사용불가
-- AGE     - 회원 나이
-- HEIGHT  - 회원 키       : 전체 10자리, 소수점 2번째 자리까지 가능
-- LOGTIME - 생성일자

GRANT SELECT ON MEMBER TO DBTEST_A
WITH GRANT OPTION;

CREATE TABLE MEMBER(
SEQ NUMBER(4),
ID VARCHAR2(14) PRIMARY KEY,
NAME VARCHAR2(12) NOT NULL,
AGE NUMBER(3),
HEIGHT NUMBER(10, 2),
LOGTIME DATE
);

-- MEMBER 테이블에 데이터 추가, 확인

CREATE SEQUENCE MEMBER_SEQ NOCACHE NOCYCLE;

INSERT INTO MEMBER VALUES ( MEMBER_SEQ.NEXTVAL, 'AA', 'MAN_A', '30', '170.8', SYSDATE);
INSERT INTO MEMBER VALUES ( MEMBER_SEQ.NEXTVAL, 'BB', 'MAN_B', '20', '179.82', SYSDATE);
INSERT INTO MEMBER VALUES ( MEMBER_SEQ.NEXTVAL, 'CC', 'MAN_C', '28', '175.34', SYSDATE);
INSERT INTO MEMBER VALUES ( MEMBER_SEQ.NEXTVAL, 'DD', 'MAN_D', '38', '172.123', SYSDATE); -- ERROR

SELECT * FROM MEMBER;

-- MEMBER 테이블 삭제
DROP TABLE MEMBER;

-- DBTEST_A 계정 삭제
DROP USER DBTEST_A CASCADE;

