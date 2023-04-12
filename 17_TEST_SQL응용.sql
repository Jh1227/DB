-- 1번
SET SERVEROUTPUT ON;

-- 2번
/
DECLARE
    idata NUMBER(3);
    sdata VARCHAR(4);
BEGIN
    idata := 123;
    sdata := 'test';
    DBMS_OUTPUT.PUT_LINE(idata ||' / '|| sdata);
END;
/

-- 3번
/
DECLARE
    VEMP EMP%ROWTYPE;
    SAL_A NUMBER(8, 2);
BEGIN
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME = 'KING';
    IF(VEMP.COMM IS NULL) THEN
        VEMP.COMM := 0;
    END IF;
    SAL_A := VEMP.SAL * 12 + VEMP.COMM;
    
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VEMP.ENAME ||' / ' || '연봉 : ' || SAL_A);
    
END;
/


-- 4번
/
SELECT DEPTNO, TRUNC(AVG(NVL(SAL, 0)))
FROM EMP
GROUP BY DEPTNO
HAVING TRUNC(AVG(NVL(SAL, 0))) > 2000
/

-- 5번
Class.forName("oracle.jdbc.OracleDriver");
url = "jdbc:oracle:thin:@localhost:1521:xe";

-- 6번
Connect con = null;
PreparedStatement pstmt = null;
int res = 0;

String sql = "insert into dept values(?, ?, ?)";
con = getConnection();
pstmt = con.prepareStatement(sql);
pstmt.setInt(1, deptno);
pstmt.setString(2, dname);
pstmt.setString(3, loc);
res = pstmt.executeUpdate();

-- 7번
/
CONN SYSTEM/oracle;

CREATE ROLE TEST_R;

CONN SCOTT/tiger;

GRANT SELECT ON EMP TO TEST_R;

/





