-- 한줄 주석

-- 실행 : Ctrl + Enter 


-- 현재 연결된 계정 확인 
show user;

-- 전체 계정 확인 
select * from all_users;

-- system 계정 : 사용자 계정 관리

-- system 계정 연결해서 scott 생성
-- create user 계정명 identified by 비밀번호;
create user scott identified by tiger;

-- 권한부여
-- connect : database 연결 권한
-- dba     : 테이블 생성 권한 
-- resource: 객체, 생성, 변경 권한
grant connect, resource, dba to scott;

-- scott 연결
conn scott/TIGER

SHOW USER

-- 계정 삭제
-- drop user 계정명
drop user scott;

-- 데이터가 있는 계정 삭제
drop user scott cascade;