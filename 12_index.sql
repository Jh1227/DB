
/*  12_index.sql  */

/*
# 인덱스( index )
- SQL 명령문의 처리 속도를 향상시키기 위해서 컬럼에 대해서 생성하는 오라클 객체입니다 
- 기본키 또는 유일키와 같은 제약 조건을 지정하면 따로 생성하지 않더라도 자동으로 생성해 줍니다
*/

SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('ENP', 'DEPT');

-- INDEX 생성
CREATE INDEX IDX_TEST
ON EMP01(ENAME);

