/*
    * �� (View) : SELECT���� �����ص� �� �ִ� ��ü
    
        - ���� ����ϴ� �� SELECT���� �����صθ� �� SELECT���� �Ź� �ۼ��� �ʿ䰡 ����.
        - �ӽ� ���̺� ���� ����
            * ���� �����͸� �����ϴ� �� �ƴ�! -> �������� ���̺�
*/
-- "�ѱ�"���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ (JOIN)
--  EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

--  "���þ�"���� �ٹ��ϴ� ����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

--  "�̱�"���� �ٹ��ϴ� ����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�̱�';
--------------------------------------------------------------------------------
/*
    1. VIEW �����ϱ�
    
    [ǥ����]
    CREATE VIEW ���
    AS ��������;        -- �������� : ������ SELECT��
    
    -- OR REPLACE : �� ���� �� ����� ������ �̸��� �䰡 �ִٸ� �ش� �信 ����� SELECT���� �����ϰ�,
                                                     ���ٸ� ���� ���� �ؾ��Ѵ�.
*/
-- ������ ����� SELECT������ ���Ǻκи� �����ϰ� VIEW�� �����غ���.
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    
-- KH ������ ������ DBA ������ �־� VIEW�� �� ����������,
--  �Ϲ������� CONNECT, RESOURCE ���Ѹ� ���� ��쿡�� VIEW�� �������� ���� ����.
--  ����, CONNECT, RESOURCE ���Ѹ� �ִ� ��� �Ʒ��� ���� ������ �߰������ ��.
--  GRANT CREATE VIEW TO KH;    -- KH

SELECT * FROM VW_EMPLOYEE; -- VIEW (�ӽ����̺�)�� ��ȸ�Ѵٴ� ����,
SELECT * FROM (            -- 
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)
);
--> ��� �������̺��̹Ƿ�, ���� �����͸� �����ϰ� ���� ����

-- "�ѱ�"�� �ٹ��ϴ� ������� ���� ��ȸ (VW_EMPLOYEE �並 ��� ��ȸ)
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';
-- "�Ϻ�"�� �ٹ��ϴ� ��� ���� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

-- * --------------------------
--  ����� ������ ������ �� ��� ��ȸ
--      + VIEW_NAME : �� �̸�
--      + TEXT      : ������ SELECT��
SELECT * FROM USER_VIEWS;
-- * --------------------------

-- ������ ������ VW_EMPLOYEE �並 ���� (BONUS �÷� �߰�)
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    
SELECT * FROM VW_EMPLOYEE;
--------------------------------------------------------------------------------

-- ��ü ����� ���, �̸�, ���޸�, ����('��'/'��'), �ٹ������ ��ȸ�� �� �ִ� SELECT��
--> ��(VM_EMP_JOB)�� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��'), 
        EXTRACT(YEAR FROM HIRE_DATE) - EXTRACT(YEAR FROM SYSDATE)
FROM EMPLOYEE JOIN JOB USING(JOB_CODE);

CREATE VIEW VW_EMP_JOB
AS SELECT EMP_ID ���, EMP_NAME �̸�, JOB_NAME ���޸�, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��') ����, 
        EXTRACT(YEAR FROM HIRE_DATE) - EXTRACT(YEAR FROM SYSDATE)�ٹ����
    FROM EMPLOYEE JOIN JOB USING(JOB_CODE);
/*
    * ������������ �Լ����̳� ���������� ����ϰ� �Ǵ� ���
        ��Ī�� ������ �䰡 �������� �ʱ� ������, �ݵ�� ��Ī�� �ο������ ��.
*/
SELECT * FROM VW_EMP_JOB;
-- ��Ī �ο� ��� 2
--  * ��� ���� �÷��� ��Ī�ϴ� ���
CREATE OR REPLACE VIEW VW_EMP_JOB (���, �̸�, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'), 
        EXTRACT(YEAR FROM HIRE_DATE) - EXTRACT(YEAR FROM SYSDATE)
    FROM EMPLOYEE JOIN JOB USING(JOB_CODE);
    
-- ������ ��ȸ �� �ش� �÷��� ����ؾ� ��.
SELECT * FROM VW_EMP_JOB
WHERE ���� = '��';

SELECT * FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �並 �����ϰ��� �Ѵٸ�, DROP VIEW ���;
DROP VIEW VW_EMP_JOB;
--------------------------------------------------------------------------------
/*
    * ������ �並 ���ؼ� DML(INSERT, UPDATE, DELETE) ����Ѵٸ� ? -- ��� ����.
*/
-- JOB ���̺��� ��� �����غ���. (VW_JOB)
CREATE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME FROM JOB;

SELECT * FROM VW_JOB; -- �����͸� ������ �ִ� �� �ƴ϶� JOB���̺��� ��ȸ�ϴ� SELECT���� ������ ����.
SELECT * FROM JOB;    -- ���� �����ʹ� JOB ���̺��� ����.

-- INSERT
INSERT INTO VW_JOB VALUES('J8', '����');

-- UPDATE 
UPDATE VW_JOB
SET JOB_NAME = '�Ƹ�����Ʈ'
WHERE JOB_CODE = 'J8';

-- DELETE
DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';
---------------------------------------------
/*
    * DML ���ɾ�� ������ �Ұ����� ���
        [1] �信 ���ǵǾ� ���� ���� �÷��� �����Ϸ��� ���
        [2] �信 ���ǵǾ� ���� ���� �÷� �O�� ���� �����Ͱ� ����� ���̺�����
            NOT NULL ���������� �����Ǿ� �ִ°��
        [3] ���������̳� �Լ����� ����Ͽ� ��ȸ�� �÷��� ���
        [4] �׷� �Լ��� GROUP BY���� ���ԵǾ� �ִ� ���
        [5] DISTINCT ������ ���Ե� ���
        [6] JOIN�� �̿��ؼ� ���� ���̺��� ������ ���
        
    - �̷��� �پ��� �������� DML�� ����� �� ���� ������,
      ��κ� ��� "��ȸ"�� �������� �̿��Ѵ�. DML�� �ǵ��� ������� �ʴ� ���� ����.
*/
--------------------------------------------------------------------------------
/*
    * VIEW �ɼ�
    
    [��ǥ����]
    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���
    AS ��������
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
    + OR REPLACE : ������ ������ �䰡 ������ �����ϰ�, ������ �䰡 ������ ���� ����
    + FORCE } NOFORCE
        - FORCE : ���������� ����� ���̺��� �������� ���� ��쿡�� �䰡 ������
        - NOFORCE : ���������� ����� ���̺��� �����ؾ����� �䰡 ������ (�⺻��)
    + WITH CHECK OPTION : DML ��� �� ���������� ����� ���ǿ� ������ ������ DML�� ���۵ǵ���
    + WITH READ ONLY : �信 ���ؼ� ��ȸ�� �����ϵ��� �ϴ� �ɼ�
*/
-- FORCE | NOFORCE
CREATE FORCE VIEW VW_TEST
AS SELECT T_ID, T_NAME FROM TT;

SELECT * FROM VW_TEST;      -- VW_TEST �䰡 ������ ������, TT��� ���̺��� ���� ���� �߻�;

-- NOFORCE �ɼ� �����Ͽ� �� ����
CREATE NOFORCE VIEW VW_TEST_2
AS SELECT T_ID, T_NAME FROM TT;     -- TT ��� ���̺��� �������� �ʾ� ���� �߻�!

CREATE TABLE TT (
    T_ID NUMBER,
    T_NAME VARCHAR2(30)
);

SELECT * FROM VW_TEST;

CREATE NOFORCE VIEW VW_TEST_2
AS SELECT T_ID, T_NAME FROM TT;

SELECT * FROM VW_TEST_2;
--------------------------------------------------------------------------------
-- WITH CHECK OPTION
--  �޿��� 300���� �̻��� ��� ������ ��� ���� (VW_EMP)
CREATE VIEW VW_EMP
AS SELECT * 
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;
   
SELECT * FROM VW_EMP;
-- ����� 200���� ����� ������ 500�������� ����
UPDATE VW_EMP
SET SALARY = 5000000
WHERE EMP_ID = 200;
-- ���� ����� ������ 250�������� ����
UPDATE VW_EMP
SET SALARY = 2500000
WHERE EMP_ID = 200;

ROLLBACK;

-- WITH CHECK OPTION �� ����Ͽ� �並 �ٽ� ����
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VW_EMP;
-- ����� 200���� ����� ������ 500�������� ����
UPDATE VW_EMP
SET SALARY = 5000000
WHERE EMP_ID = 200;
-- ���� ����� ������ 250�������� ����
UPDATE VW_EMP
SET SALARY = 2500000
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- WITH READ ONLY
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
   FROM EMPLOYEE
   WHERE BONUS IS NOT NULL
WITH READ ONLY;
   
SELECT * FROM VW_EMP;

-- 200�� ��� ����
DELETE FROM VW_EMP WHERE EMP_ID = 200;  --> WITH READ ONLY �ɼǿ� ���� �����Ұ�!
