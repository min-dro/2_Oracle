/*
    * DQL (QUERY) : SELECT
    * DML (MANIPULATION) : INSERT, UPDATE, DELETE
    * DDL (DEFINITION : CREATE, ALTER, DROP
    * DCL (CONTROL) : GRANT, REVOKE
    * TCL  (TRANSACTION CONTROL) : COMMIT, ROLLBACK
    
    - DML : DATA MANIPULATION LANGUAGE
            ������ ���� ���
            ��(������)�� ����(�߰�)�ϰų� �����ϰų� ������ �� ����ϴ� ���
*/
/*
    1. INSERT : ���̺��� �����͸� �߰��� �� ���
    
    [ǥ����]
        [1] INSERT INTO ���̺��� VALUES (��1, ��2, ��3, ...);
            : ���̺��� ���ǵ� ��� �÷��� ���� �ִ� ��� ���
              ������ ������Ÿ��(�ڷ���)�� �� ���Ѽ� �ۼ��ؾ� ��!
              
            * �÷����� ���� ���� �ۼ��� ��� => not enough value ����
            * �÷����� ���� ���� �ۼ��� ��� => too many value ����
            
        [2] INSERT INTO ���̺���(�÷���, �÷��� ..) VALUES (��, ��, ..);
            : ������ �÷��� �ش��ϴ� ���� �߰��ϴ� ��� ���
              �������� ���� �÷��� �⺻���� ������ �⺻������, ������ NULL�� �����Ͱ� �߰���.
*/
-- EMPLOYEE ���̺��� ����� �߰�
--  [1] ��� �÷��� ����Ͽ� �߰�
INSERT INTO EMPLOYEE VALUES (300, '����ö', '790710-1234567', 'gong79@naver.com',
                            '01012345678', 'D7', 'J5', 5000000, 0.5, 200, SYSDATE,
                            NULL, DEFAULT);
                            
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '����ö';

--  [2] �÷� �����Ͽ� �߰�
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE)
    VALUES (301, '�����', '920702-2123456', 'J5');
    
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '�����';
--------------------------------------------------------------------------------
/*
    [3] �������� ����Ͽ� ������ �߰�
        : VALUES�� ���� ���� �ۼ��ϴ� �� ���
          ���������� ��ȸ�� ��� ���� �ѹ��� �߰�
          
    [ǥ����]
            INSERT INTO ���̺� (��������);
*/
-- EMP_01 ���̺� ����
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);
SELECT * FROM EMP_01;

-- ��ü ����� ���, �̸�, �μ����� ��ȸ�Ͽ� ������ �߰�
--  * ��ü ����� ���, �̸�, �μ���, ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE =DEPT_ID);
--  * ���������� ����Ͽ� ������ �߰�
INSERT INTO EMP_01
(  
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);
--------------------------------------------------------------------------------
/*
    [4] INSERT ALL
        �� �� �̻��� ���̺��� ���� �����͸� �߰��� ��,
        �� �� ���Ǵ� ���������� ������ ��� ����ϴ� ���    
*/
-- EMP_DEPT ���̺� ����
CREATE TABLE EMP_DEPT (
    EMP_ID VARCHAR2(3) NOT NULL,
    EMP_NAME VARCHAR2(20) NOT NULL,
    DEPT_CODE CHAR(2),
    HIRE_DATE DATE
);
DROP TABLE EMP_DEPT;
CREATE TABLE EMP_DEPT
AS (
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLIYEE
    WHERE 1=0
);

-- EMP_MANAGER ���̺� ����
CREATE TABLE EMP_MANAGER
AS (
    SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0 -- �÷� ������ �������� ���� ������ FALSE ������ ����
);

SELECT * FROM EMP_MANAGER;
SELECT * FROM EMP_DEPT;

-- �μ��ڵ尡 'D1'�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [ǥ����] 
            INSERT ALL
            INTO ���̺���(A) VALUES (�÷���, �÷���, ...)
            INTO ���̺���(B) VALUES (�÷���, �÷���, ...)
                ��������;
*/
INSERT ALL
    INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    (
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1'
    );
    
-- 6�� ���� �߰��� (���� 3���� �߰��Ǿ���)
SELECT * FROM EMP_DEPT;     -- 3�� �� �߰���
SELECT * FROM EMP_MANAGER;  -- 3�� �� �߰���
--------------------------------------------------------------------------------
/*
    * ������ ����ؼ� �� ���̺��� ���� �߰��ϴ� ���
    
    [ǥ����]
            INSERT ALL
            WHEN ����1 THEN
                INTO ���̺���(A) VALUES (�÷���, �÷���, ...)
            WHEN ����2 THEN
                INTO ���̺���(B) VALUES (�÷���, �÷���, ...)
*/
-- �Ի����� 2000�� ������ ��� ���, �̸�, ����, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
WHERE HIRE_DATE <= '2000/01/01';

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- '2000/01/01' ���� �Ի��ڵ��� EMP_OLD ���̺��� �߰�
--              ���� �Ի��ڵ��� EMP_NEW ���̺��� �߰�
INSERT 
    WHEN HIRE_DATE < '2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, SALARY, HIRE_DATE)
    WHEN HIRE_DATE >= '2000/01/01' THEN
        INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE)
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EPLOYEE;

-- �� 24�� ���� �߰���.
SELECT * FROM EMP_OLD;  -- 8���� ���� �߰���
SELECT * FROM EMP_NEW;  -- 16���� ���� �߰���
--------------------------------------------------------------------------------
/*
    2. UPDATE : ���� �����͸� ������ �� ����ϴ� ����
    
    [ǥ����]
            UPDATE ���̺���
            SET �÷���1=��1,
                �÷���2=��2,
                ...
            [WHERE ���ǽ�] --> ���ǿ� ���� �ش� �÷��� ���� �����ϴ� ��� ���
                          --> ���� ��, ��� �����Ϳ� �ش� �÷��� ���� �����ϰ� ��.
                          
            * ������ ���� �� "��������"�� �� Ȯ���ؾ� ��.
*/
-- DEPARTMENT --> DEPT_TABLE ���̺��� ���� ( DEPT_TABLE ���̺� ����, DEPARTMENT ���̺� ��������
CREATE TABLE DEPT_TABLE
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_TABLE;

-- DEPT_TABLE���� �μ��ڵ尡 'D9'�� ������ ��ȸ
SELECT * FROM DEPT_TABLE WHERE DEPT_ID = 'D9';

-- �μ��ڵ尡 'D9'�� �μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_TABLE 
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

-- EMP_SALARY ���̺� ����
-- (EMPLOYEE ���̺����� ���� - EMP_ID / EMP_NAME / DEPT_CODE / SALARY / BONUS)
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
    SELECT * FROM EMP_SALARY;
    
-- '���ö' ����� ������ 100�������� ����
SELECT * FROM EMP_SALARY WHERE EMP_NAME = '���ö';

UPDATE EMP_SALARY
SET SALARY = 1000000 WHERE EMP_NAME = '���ö';

-- '�溴��' ����� ������ 500�������� �����ϰ�, ���ʽ��� 0.2�� ����
SELECT * FROM EMP_SALARY WHERE EMP_NAME = '�����';

UPDATE EMP_SALARY
SET SALARY = 5000000,
    BONUS = 0.2
WHERE EMP_NAME = '�����';

-- ��ü ����� �޿��� ���� �޿��� 10���� �λ�� �ݾ����� ���� (�⺻�޿� * 1.1)
UPDATE EMP_SALARY SET SALARY = SALARY * 1.1;
--------------------------------------------------------------------------------
/*
    * ������ ���� �� �������� ����غ���
    
    [ǥ����]
            UPDATE ���̺���
            SET �÷��� = ( �������� )
            [WHERE ���ǽ�]
*/
-- EMP_SALARY
-- '�����' ����� �޿��� ���ʽ��� '�����' ����� �޿��� ���ʽ� ������ ����
--  * ������ �������� (1�� 1��)
UPDATE EMP_SALARY
SET SALARY = ( SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����'),
    BONUS = ( SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '�����';

--  * ���߿� �������� (1�� N��) -- '������' ����� �޿��� ���ʽ��� ����
UPDATE EMP_SALARY
SET (SALARY, BONUS) = ( SELECT SALARY , BONUS
                        FROM EMP_SALARY WHERE EMP_NAME = '������' )
WHERE EMP_NAME = '�����';

-- ����) ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ���� (���̺�: EMP_SALARY)
--      ����T : LOCATION
--      * ASIA �������� �ٹ��ϴ� ��� ��ȸ

SELECT *
FROM EMP_SALARY JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (OCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

-- ���� ���������� ����Ͽ� ������Ʈ
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE  EMP_ID IN (  -- ���� ������ ����� �������̹Ƿ� '='�� �ƴ� 'IN' �����ڸ� ���
    SELECT *
    FROM EMP_SALARY JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%'
);

-- ������� ����� ������ Ȯ������.
COMMIT;
--------------------------------------------------------------------------------
/*
    3. DELETE : ���̺��� ����� �����͸� �����ϴ� ����
    
    [ǥ����]
            DELETE FROM ���̺���
            [WHERE ���ǽ�] --> WHERE�� ���� �� ��� �����Ͱ� ���� ��
*/
DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE
ROLLBACK;               --> ������ COMMIT �������� ���ư�.

SELECT * FROM EMPLOYEE EMPLOYEE WHERE EMP_NAME = '�����';
DELETE FROM EMPLOYEE WHERE EMP_NAME = '�����';

COMMIT;

-- DEPARTMENT ���̺��� DEPT_ID ���� 'D1' �����͸� �����غ���.
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';
--> ��������  (�ܷ�Ű)�� ����Ǿ� ������ �Ұ�! - 'D1'�� ������� �ٸ� ���̺��� ����.

/*
    * TRUNCATE : ���̺��� ��ü ���� �����ϴ� ����
                 DELETE���� ���� �ӵ��� ����
                 ������ ������ ���� (��� �Ұ�)
                 ROLLBACK �Ұ�
    [ǥ����]
            TRUNCATE TABLE ���̺���;
*/
SELECT * FROM EMP_SALARY;
TRUNCATE TABLE EMP_SALARY;

ROLLBACK;       -- ROLLBACK ��
