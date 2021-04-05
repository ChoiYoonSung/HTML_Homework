--EXCEPTION (����ó��)
--1. ���ǵ� Oracle Server Error
--2. ���� ���� ���� Oracle Server Error
--3. ����� ���� Error
--��κ��� ���ܿ����� ���� �״�� ������ �� �� �ִ�

DECLARE
  V_NM VARCHAR2(30);
BEGIN
  SELECT LPROD_NM INTO V_NM
  FROM LPROD
  WHERE LPROD_GU = 'Z101';
  
  DBMS_OUTPUT.PUT_LINE(V_NM);
  
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('���� ����' || SQLCODE || SQLERRM);
      WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('������ ����' || SQLCODE|| SQLERRM);
      WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('��Ÿ ����');
      
END;
/

--���� ���� ���� ����
DECLARE
  --����ó������ EXP1 ���� ����
  EXP1 EXCEPTION;
  --PRAGMA : �����϶��� ���� BUY, ����ÿ��� ���� �ȵ�
  --EXCEPTINO INIT : ����ó���� EXP1 ������ �����ڵ��ȣ�� ����
  PRAGMA EXCEPTION_INIT(EXP1, -2292);
BEGIN
  DELETE FROM LPROD
  WHERE LPROD_GU = 'P101';
  
  EXCEPTION
    WHEN EXP1 THEN
      --SQLERM : SQL ERROR MESSAGE
      DBMS_OUTPUT.PUT_LINE('�����Ұ�' || SQLERRM);
END;
/

--���ӻ���(cascaade) : �θ����̺��� �����͸� �����ϸ� �ڽ����̺��� �����͵� �����ȴ�

--MEMBER ���̺� a001 ȸ���� ������ ����
--MEMBER ���̺��� MEM_ID�� �����ϰ� �ִ� CART���̺��� CART_MEMBER(FK)�� ����
--MEMBER���̺� �����Ͱ� ������ ���� �ʴµ� ���ܷ� ó���ϱ�
DECLARE
  EXCP EXCEPTION;
  PRAGMA EXCEPTION_INIT(EXCP, -2292);
BEGIN
  DELETE FROM MEMBER
  WHERE MEM_ID = 'a001';
  
  EXCEPTION
    WHEN EXCP THEN 
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

ACCEPT p_lgu PROMPT '����Ϸ��� �з��ڵ� �Է�:'
DECLARE
  exp_lprod_gu exception;
  v_lgu VARCHAR2(10) := UPPER('&p_lgu');
BEGIN
  IF v_lgu IN ('P101','P102','P201','P202') THEN
    RAISE exp_lprod_gu;
  END IF;
  DBMS_OUTPUT.PUT_LINE(v_lgu || '�� ��� ����');
EXCEPTION
  WHEN exp_lprod_gu THEN
    DBMS_OUTPUT.PUT_LINE(v_lgu || '�� �̹� ��ϵ� �ڵ��Դϴ�.');
END;

/
--����� ���� ����
--MEMBER���̺� ȸ��ID b001�� �߰��Ϸ��� �� ��
--����� ���� ���ܸ� �߻��ϱ�
--ȸ��ID üũ�� a001, b001, c001�� �ϱ�
ACCEPT m_id PROMPT '����Ϸ��� �з��ڵ� �Է�:'
DECLARE
  EXP_M_ID EXCEPTION;
  M_ID VARCHAR2(10) := LOWER('&m_id');
BEGIN
  IF M_ID IN ('a001','b001','c001') THEN
    RAISE EXP_M_ID;
  END IF;
  INSERT INTO MEMBER(MEM_ID) VALUES(M_ID);
EXCEPTION
  WHEN EXP_M_ID THEN
  DBMS_OUTPUT.PUT_LINE(M_ID || '�� �̹� ���');
END;
/

--CURSOR��
--SELECT������ ������ ��� ���տ� ���� �������� �� ���� �۾��� �����ϰ� ��
--QUERY ����� �аų� ����

--ȸ���� ���ϸ��� ��Ȳ ���
--������ �ֺ��� ȸ���� ���
DECLARE
    V_NAME VARCHAR2(30);
    V_MILEAGE NUMBER;
  --Ŀ�� ����
  CURSOR MEM_CUR IS 
    SELECT MEM_NAME ,MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_JOB = '�ֺ�'
    ORDER BY MEM_NAME;
BEGIN
  --�޸𸮿� �ö�
  OPEN MEM_CUR;
  LOOP
    FETCH MEM_CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN MEM_CUR%NOTFOUND;--FETCH�� ������ �ɾ� LOOP Ż��
    DBMS_OUTPUT.PUT_LINE(V_NAME|| V_MILEAGE);
  END LOOP;
  CLOSE MEM_CUR;
END;
/
--FOR�������� CURSOR�� OPEN�� CLOSE�� �ڵ����� ���ش�.
DECLARE
  CURSOR MEM_CUR IS 
    SELECT MEM_NAME ,MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_JOB = '�ֺ�'
    ORDER BY MEM_NAME;
BEGIN
  FOR MEM_REC IN MEM_CUR LOOP --MEM_REC�� MEM_CUR�� �� �� ���� �� �پ� ������
    DBMS_OUTPUT.PUT_LINE(MEM_REC.MEM_NAME || MEM_REC.MEM_MILEAGE);
  END LOOP;
END;
/
--��ǰ�ڵ带 �Ű������� �Ͽ� ��� ���� ADD
CREATE OR REPLACE PROCEDURE USP_GAEDDONG1
IS
BEGIN
    UPDATE PROD
    SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + 10
    WHERE PROD_ID = 'P101000001';
    DBMS_OUTPUT.PUT_LINE('������Ʈ');
EXCEPTION
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE(SQLERRM);
 ROLLBACK;
END;
/

EXEC USP_GAEDDONG1;

/
SELECT PROD_TOTALSTOCK
FROM PROD;

/
CREATE TABLE PROCTEST(
    PROC_SEQ NUMBER,
    PROC_CONTENT VARCHAR2(30),
    CONSTRAINT PK_PROCTEST PRIMARY KEY(PROC_SEQ)
);


--SEQPROC1.NEXTVAL : 1 ����
--SEQPROC!.CURRVAL : ���簪
CREATE SEQUENCE SEQPROC1
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE PROCEDURE PROC_TEST
IS
BEGIN
INSERT INTO PROCTEST(PROC_SEQ,PROC_CONTENT) VALUES(SEQPROC1.NEXTVAL,'������');
END;
/
EXEC PROC_TEST;
/
SELECT * FROM PROCTEST;

--���ν��� PROC_TEST2 ����
--�����ϸ� PROCTEST���̺��� ������ ������ ����
--������ �����Ͱ� ������ ����ó�� "������ �����Ͱ� �����ϴ�."


DECLARE
    EXCP EXCEPTION;
    CNT NUMBER;
    
CREATE OR REPLACE PROCEDURE PROC_TEST2
IS
BEGIN
    SELECT COUNT(PROC_SEQ) INTO CNT FROM PROCTEST;
    DELETE FROM PROCTEST WHERE PROD_SEQ = MAX(PROC_SEQ);
    
    
    IF EXCP THEN
    DBMS_OUTPUT.PUT_LINE('������ �����Ͱ� �����ϴ�.');
    END IF;
END;

