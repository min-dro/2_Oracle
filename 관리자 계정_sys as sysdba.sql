ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- ����� �߰� ( ������ �������θ� ���� �Ϲ� ����� �������δ� �߰� �Ұ�. )
-- ��ü ����(�߰�) -> DDL
--  CREATR USER ����ڸ� IDENTIFIED BY ��й�ȣ;
CREATE USER TICTACTOE IDENTIFIED BY ttt;
-- ���� �ο� => DCL
--  GRANT �ο��ұ��Ѹ� TO ������̸�(ID);
--  RESURCE, CONNECT, DBA
GRANT CONNECT, RESOURCE TO TICTACTOE;
ALTER USER Tictactoe DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- *----------------------------------------------------------------------------
-- DQL (SELECT) : ������ ��ȸ �� ���Ǵ� ����
/*
    [SELECT�� ����]
     (5)   SELECT * (��ü �÷�) | �÷�A, �÷�B | �÷�A ��ĪA | �÷�A as ��ĪA | �÷�A as "�÷� A"
     (1)   FROM ���̺��� ��ĪT
     (2)   WHERE ���ǽ�
     (3)   GROUP BY �÷��� | �Լ���
     (4)   HAVING �׷쿡�������ǽ�
     (6)   ORDER BY �÷���
*/
-- * � �÷��� �ش��ϴ� ������ ���Ͽ� �ߺ��� ������ ���·� ��ȸ�ϰ��� �� �� ? DISTINCT
SELECT DISTINCT(DEPT_CODE) "�μ��ڵ�" FROM EMPLOYEE;
-- * �̸��� �ּҿ� _�տ� 3���� �ִ� ��� ������ ��ȸ�ϰ��� �� �� ? ����÷� LIKE '��ȸ������'
--   - ���ϵ�ī��(Ű����) : _ , %
--   - ���ϵ�ī��� ��ȸ�� �ؾ��� ���� ESCAPE '������' �� �߰��Ͽ� ��ȸ�ؾ� ��.
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '__\_%' ESCAPE '\';
--   �达 ���� ���� ��� ��ȸ�ϰ��� �� ��, ���� => EMP_NAME LIKE '��%'
SELECT * FROM EMPLOYEE WHERE EMP_NAME LIKE '��%';
-- * ���� �� NULL ������ ��ġ => NULL ������ ���� ���ĵǵ��� �� �� ? NULLS FIRST
--                            NULL ������ ���ʿ� ��ġ�� �� ? NULLS LAST
SELECT * FROM EMPLOYEE ORDER BY BONUS NULLS FIRST;  -- �������� �� �⺻ �� (DESC)
SELECT * FROM EMPLOYEE ORDER BY BONUS NULLS LAST;   -- �������� �� �⺻ �� (ASC)
-- * ��¥ ���� �Լ���
--      [��ȯ �� ����ϴ� ����]
--      - ����: YYYY, YY, RRRR, RR => 50�� �������� Y ���� ��� �� 20XX, R ���� ��� �� 19XX
--      - ��  : MM, MON, MONTH (X��), RM (�θ� ����)
--      - ��  : DD, DDD, D
--      - ���� : DAY, DY
--      - �� : HH, HH24
--      - �� : MI
--      - �� : SS
SELECT TO_CHAR(TO_DATE('90-01-14', 'RR-MM-DD'), 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('90-01-14', 'YY-MM-DD'), 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('90-01-14', 'YY-MM-DD'), 'RM') FROM DUAL;
--     EXTRACT : ����(YEAR), ��(MONTH), ��(DAY)�� �ش��ϴ� ���� ������ �� ����ϴ� �Լ�
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;
--------------------------------------------------------------------------------
-- * �����Լ� : DECODE , CAST WHEN THEN
--  DECODE(�񱳴���÷�|�����, �񱳰�, �����1, �񱳰�, �����2, ..., �����N)
SELECT EMP_NAME �̸�, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ���� FROM EMPLOYEE;
--  CASE WHEN ���ǽ�1 THEN �����1 WHEN ���ǽ�2 THEN �����2 ... ELSE �����N END
SELECT EMP_NAME �̸�, SALARY ����,
    CASE WHEN SALAEY >= 5000000 THEN '����'
         WHEN SALARY >= 3000000 THEN '�߱�'
         WHEN SALARY IS NULL THEN '�˼�����'    -- NULL üũ�� IS NULL | IS NOT NULL
         ELSE '�ʱ�'
    END ���
FROM EMPLOYEE;
-- COMMIT : ������(��)�� ����
--  ������ ���� ��� �� ��ȸ
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����, COUNT(*) "��� ��"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
--------------------------------------------------------------------------------
-- * JOIN : ���� ���� ���̺��� �����Ͽ� ��ȸ�� �� ���
--  * ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, JOB_NAME --, E.JOB_CODE -- ��ȸ �� ���� �� �÷����� ������ ��Ī�� �޾���� ��.
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE;
--  * ANSI(ǥ��) ����   -- JOIN ~ ON (�����÷���, �ٸ��÷��� ��� ��� ����), JOIN ~ USING (�÷����� ������ ���� ��� ����)
SELECT EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE);

-- ������ : ���� �� ���޿� �ش��ϴ� ��� ��ȸ
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;   -- SALARY >= MIN_SAL AND SALARY <= MAX_SAL
-- DEPT_CODE IN ('D3', 'D4', 'D5' => DEPT_CODE = 'D3' OR DEPT_CODE = 'D4' OR DEPT_CODE = 'D5'

-- ���� ���� : � ������ ��� ������ ���� ���� ��ȸ
SELECT E.EMP_NAME "������", E.EMP_ID "���", M.EMP_NAME "���������", M.EMP_ID "������"
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
--------------------------------------------------------------------------------
-- * �������� : SQL�� ���� �� �ٸ� SQL��
-- ex) ������ ������ ���� �μ��� ���� ��� ��ȸ (������, �μ��ڵ�(�μ���), �����ڵ�(���޸�))
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_CODE
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE
        AND DEPT_CODE = (
        SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������'
);
--------------------------------------------------------------------------------
/*
        DDL (������ ���Ǿ��)                      DML (������ ���۾��)
  -----------------------------------------------------------------
  �߰� | CREATE (��ü����) �̸� ...                 INSERT INTO ���̺���[(�÷���,...)] VALUES (��,...)
  ���� | DROP (��ü����) �̸�                       DELETE FROM ���̺��� [WHERE ���ǽ�]
  ���� | ALTER (��ü����) �̸�                      UPDATE ���̺��� SET �÷� = ��, [WHERE ���ǽ�]
  ------------------------------------------------------------------
*/
/*
    * �÷��� ���� ��������
        [1] �⺻Ű (PRIMARY KEY) : NOT NULL + UNIQUE �ݿ��Ǿ�, NULL ���X, �ߺ�X
                                : ���̺� ���� ��(������)�� ���� �����ϴ� �뵵�� ����
        [2] �ܷ�Ű (FOREIGN KEY) : �ٸ� ���̺��� �ִ� �⺻Ű �Ǵ� � ���� ����ϴ� �÷�
                                : ������ ������ ���� �ɼ� ������ - ON DELETE [SET NULL|CASCADE|RESTRICTED(�⺻��)]
        [3] NOT NULL    : NULL���� ������� ����.
        [4] UNIQUE      : �ߺ����� ������� ����.
        [5] CHECK       : ���ǿ� �ش��ϴ� ���� �ֵ��� �ϴ� ����. CHECK(���ǽ�)
    
    * �÷��� �⺻���� �����ϴ� �ɼ� : DEFAULT
        ...
        �÷��� �ڷ��� DEFAULT �⺻��
        ...
*/
/*
    - DML (������ ���۾��)
        * ������ �߰� : INSERT
            INSERT INTO ���̺���[(�÷�, �÷�, ...)] VALUES (��, ��, ...);
            ex) insert into member(emp_id, emp_name, dept_code) values (666, 'ȫ��ȫ', 'D3');
            
        * ������ ���� : UPDATE
            UPDATE ���̺��� SET �������÷���=�����Ұ�,
                               �������÷���=�����Ұ�
                            [WHERE ���ǽ�];
            ex) update employee set dept_code = 'D6' where emp_name = 'ȫ��ȫ';
                select * from employee where emp_name = 'ȫ��ȫ';
                
        * ������ ���� : DELETE
            DELETE FROM ���̺��� [WHERE ���ǽ�];
            ex) delete from employee where emp_id = 666;
            ex) delete from employee where dep_id = (select emp_id from employee where emp_name = 'ȫ��ȫ');
            
            (*) TRUNCATE : ���̺� ��ü ���� ����.
                           DELETE���� �ӵ��� ����.
                           ROLLBACK ���� ����!
*/
/*
    Ʈ����� : DML�� ����Ͽ� �����͸� �������� �� �ش� �۾� ����� �����ϴ� ��.
              �����ͺ��̽��� �ٷ� �����ϴ� ���� �ƴ϶�, COMMIT�� ���� �� �ݿ���.
              
              * COMMIT : ������ ��������� �����ͺ��̽��� �ݿ�.
              * ROLLBACK : ������ ��������� ���. ������ COMMIT ���±��� ��������.
                    - DDL �� ����� �Ŀ��� ROLLBACK
*/
/*
    * ������ ���̽� ��ü (������, ��, Ʈ����)
        - ������ : �ڵ����� ��ȣ�� �߻����� �ִ� ��ü -> �⺻Ű(PK)�� ���� ���.
            CREATE SEQUENCE ������_�̸�
                [START WITH ���۰�(1)]
                [INCREMENT BY ������(1)]
                [MAXVALUE �ִ밪(9999999999.. ��������)]
                [MINVALUE �ּҰ�(1)]
                [NOCYCLE default) | CYCLE]      -- ��ȯ����
                [NOCACHE | CACHE ����Ʈũ��];      -- ĳ�ø޸� ��뿩��
                
            [���]
            ������_�̸�.CURRVAL : ���� ������ �� (������ NEXTVAL �� ����� ��)
            ������_�̸�.NEXTVAL : ���� ������ �� + ������
            
        - �� (VIEW) : SELECT���� �����ϴ� ��ü
                      ���� ���̺�
                      ���� ��(������)�� ���������� ����.
                      DML ����� �����ϴ�. �ȵǴ� ������ ����, GROUP BY, JOIN, ���)
                      
            [����]
                CREATE [OR REPLACE] VIEW ��_�̸�   -- OR REPLACE: ���� �̸��� �䰡 ������ ����
                    AS SQL��(��������);  -- SQL���� �䰡 �����ϰ� ��.
                    
        - Ʈ���� (TRIGGER) : ���̺��� �����Ϳ� ���� �������(DML)�� ������
                            �ڵ����� �Ź� �Ǵ� �ѹ� ������ �۾��� �̸� ������ ���� ��
                            
            [����]
                CREATE TRIGGER Ʈ����_�̸�
                BEFORE|AFTER INSERT|UPDATE|DELETE ON ���̺���
                [FOR EACH ROW]          -- �Ź� ����
                -- PL/SQL��
                [DECLARE]           -- ����, ����� ���� �� �ʱ�ȭ
                    ������ �ڷ���;
                    ����� CONSTANT �ڷ���;
                BEGIN               -- �����
                    -- �̺�Ʈ(DML�� ���� �������) �߻� �� ó���� ����
                    -- ���ǹ�, �ݺ���, SQL�� ����
                [EXCEPTION]                 -- ����ó����
                    WHEN ���ܸ� THEN ����ó���ҳ���
                    WHEN OTHERS THEN ����ó������
                END;
                /
*/
/*
    * PL/SQL : ���ν��� ���.
               ����Ŭ������ ������ ���
    - ���ǹ�
            [1] IF��
                - ���� IF�� : IF ���ǽ� THEN �����ҳ��� END IF; -- ���ǽ��� ��(TRUE)�� ���� ó��
                - IF ~ ELSE�� : IF ���ǽ� THEN �����ҳ���(T) ELSE ������_����(F) END IF;
                - ���ǽ��� ������ �ʿ��� ��
                    : IF ���ǽ�1 THEN �����ҳ���(T_1) ELSIF ���ǽ�2 THEN �����ҳ���(T_2) ... [ELSE �����ҳ���(F)] END IF;
            [2] CASE WHEN THEN ��
                CASE �񱳴��
                    WHEN �񱳰�1 THEN ó����_����(1)
                    WHEN
    - �ݺ���
             [1] LOOP��
                      LOOP
             [2]
             
             [3]
*/