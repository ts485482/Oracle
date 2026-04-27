-- 적용시킨 프로시저 : 주석처리
-- 19-2 프로시저
-- 파라미터를 사용하지 않는 프로시저

/*
CREATE OR REPLACE PROCEDURE pro_noparam
IS
  V_EMPNO NUMBER(4) :=7788;
  V_ENAME VARCHAR(10);
BEGIN
  V_ENAME := 'SCOTT';
  DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
  DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
*/

SET SERVEROUTPUT ON;
EXECUTE pro_noparam;

--파라미터를 사용하는 프로시저
/*
CREATE OR REPLACE PROCEDURE pro_param_in
(
    param1 IN NUMBER,
    param2 NUMBER,
    param3 NUMBER := 3,
    param4 NUMBER DEFAULT 4
)IS

BEGIN
DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;
*/

EXECUTE pro_param_in(1,2,9,8);
EXECUTE pro_param_in(1,2);
-- param2에 값 지정이 되지않아, 오류 출력
EXECUTE pro_param_in(1);
EXECUTE pro_param_in(param1 => 10, param2 => 20);


--파라미터 사용 모드(IN, OUT)
/*
CREATE OR REPLACE PROCEDURE pro_param_out
(
  in_empno IN EMP.EMPNO%TYPE,
  out_ename OUT EMP.ENAME%TYPE,
  out_sal OUT EMP.SAL%TYPE
)IS

BEGIN
  SELECT ENAME, SAL INTO out_ename, out_sal
  FROM EMP
  WHERE EMPNO = in_empno;
END;
*/

--파라미터 실행(IN, OUT)
DECLARE
  v_ename EMP.ENAME%TYPE;
  v_sal EMP.SAL%TYPE;
BEGIN
  pro_param_out(7788, v_ename, v_sal);
  DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
  DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;

--파라미터 사용 모드(IN OUT)
/*
CREATE OR REPLACE PROCEDURE pro_param_inout
(inout_no IN OUT NUMBER)
IS

BEGIN
  inout_no := inout_no*2;
END pro_param_inout;
*/

--파라미터 실행(IN OUT)
DECLARE
  no NUMBER;
BEGIN
  no := 5;
  pro_param_inout(no);
  DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;

--함수
/*
CREATE OR REPLACE FUNCTION FUNC_AFTERTAX(
SAL IN NUMBER
)
RETURN NUMBER
IS
tax NUMBER := 0.05;
BEGIN
RETURN (ROUND(SAL - (SAL*TAX)));
END FUNC_AFTERTAX;
*/

DECLARE
AFTERTAX NUMBER;
BEGIN
AFTERTAX := FUNC_AFTERTAX(3000);
DBMS_OUTPUT.PUT_LINE('after-tax income : ' || AFTERTAX);
END;

--트리거(정보처리 시험 단골)

/*
CREATE TABLE EMP_TRG
AS SELECT * FROM EMP;
*/

/*
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
  IF TO_CHAR(sysdate, 'DY') IN ('토', '일')THEN
    IF INSERTING THEN
      raise_application_error(-20000, '주말 사원정보 추가 불가');
    ELSIF UPDATING THEN
      raise_application_error(-20000, '주말 사원정보 수정 불가');
    ELSIF DELETING THEN
      raise_application_error(-20000, '주말 사원정보 삭제 불가');
    ELSE
      raise_application_error(-20000, '주말 사원정보 변경 불가');
    END IF;
  END IF;
END;
*/

UPDATE emp_trg SET sal = 3500 WHERE empno = 7788;

/*
CREATE TABLE EMP_TRG_LOG(
  TABLENAME VARCHAR2(10),       --DML이 수행된 테이블 이름
  DML_TYPE VARCHAR2(10),        --DML 명령어 종류
  EMPNO NUMBER(4),              --DML 대상이 된 사원 번호
  USER_NAME VARCHAR2(30),       --DML을 수행한 USER이름
  CHANGE_DATE DATE              --DML이 수행된 날짜
);
*/

/*
CREATE OR REPLACE TRIGGER TRG_EMP_LOG
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW

BEGIN
  IF INSERTING THEN
    INSERT INTO EMP_TRG_LOG
    VALUES ('EMP_TRG', 'INSERT', :new.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
  ELSIF UPDATING THEN
    INSERT INTO EMP_TRG_LOG
    VALUES ('EMP_TRG', 'UPDATE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
  ELSIF DELETING THEN
    INSERT INTO EMP_TRG_LOG
    VALUES ('EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
  END IF;
END;
*/


INSERT INTO EMP_TRG
VALUES(9999,'TestEMP','CLERK',7788, TO_DATE('2018-03-03','YYYY-MM-DD'), 1200, NULL, 20);
COMMIT;

SELECT * FROM EMP_TRG;

SELECT * FROM EMP_TRG_LOG;

UPDATE EMP_TRG
  SET SAL = 1300
  WHERE MGR = 7788;
  
  COMMIT;
  
DELETE FROM EMP_TRG WHERE EMPNO = 9999;

COMMIT;
