/*
    * DCL : ������ ���� ���
    
        - ����(�����)���� �ý��۱��� �Ǵ� ��ü ���� ������ �ο��ϰų� ȸ���ϴ� ����
            * �ý��۱��� : DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
            * ��ü ���� ���� : Ư�� ��ü���� ������ �� �ִ� ����
        
        - ���� �߰�
            ** CREATE USER ������ IDENTIFIED BY �����ȣ;
        - ������ ���� �ο�(����)
            ** GRANT ����(CONNECT, RESOURCE[, DBA]) TO ������;
            
            + ROLE : Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
                * CONNECT : ������ �� �ִ� ���� (DREATE SESSION)
                * RESOURCE : Ư�� ��ü���� ������ �� �ִ� ���� (CREATE TABLE, CREATE SEQUENCE, ...)
*/
-- CONNECT, RESOURCE ������ ���� ���� Ȯ��
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');
--------------------------------------------------------------------------------
/*
    * TCL : Ʈ����� ���� ���
    
        - Ʈ����� : �����ͺ��̽����� ������ �������
                    �������� �������(DML) ���� �ϳ��� Ʈ����ǿ� ��� ó��
                    DML ���ɾ� ���� ����� �� Ʈ������� �������� �ʴ� �ٸ�
                                                    Ʈ������� ���� ����
                                            Ʈ������� �����Ѵٸ� �ش�
                                                Ʈ����ǿ� �����ؼ� �ѹ��� ó��
                    COMMIT �ϱ� �������� ��������� �ϳ��� Ʈ����ǿ� ��Ƶд�.
        - Ʈ����� ��� SQL(������)
            : INSERT, UPDATE, DELETE  (DML)
            
        - Ʈ����� ����
            + COMMIT    : Ʈ����� ���� ó�� �� Ȯ��
                COMMIT; -- Ʈ����ǿ� ����� �ִ� ������׵��� DB(�����ͺ��̽�)�� �ݿ��Ѵ�.
            + ROLLBACK  : Ʈ����� ���
                ROLLBACK; -- Ʈ����ǿ� ����� �ִ� ������׵��� ����(���)�� �� ������ COMMIT �������� ���ư���.
                ROLLBACK TO ����Ʈ��;   -- �ӽ������� ������ ����Ʈ�� ��ġ�� ���ư���,
            + SAVEPOINT : Ʈ����� �ӽ� ����
                SAVEPOINT ����Ʈ��; -- �ش� ������ ����Ʈ������ �ӽ� �������� �����صδ� ���̴�.
*/
-- ���̺� ���� ( EMP_ID, EMP_NAME, DEPT_TITLE )
CREATE TABLE EMP_01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));
    
-- EMP_01 ���̺� ��ȸ
SELECT * FROM EMP_01 ORDER BY EMP_ID;

-- ��� 201���� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 201;
DELETE FROM EMP_01 WHERE EMP_ID = 202;


ROLLBACK;   -- DELETE 201, DELETE 202 �� Ʈ����ǿ��� ���ŵ�
---------------------------------------
INSERT INTO EMP_01 VALUES (900, '�ƹ���', NULL);
COMMIT;
---------------------------------------

SELECT * FROM EMP_01 ORDER BY EMP_ID;

-- ����� 900���� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 900; -- Ʈ����� ���� �� DELETE 900 �߰�

INSERT INTO EMP_01 VALUES (800, '�����', NULL);   -- INSERT 800 �߰�

COMMIT;     -- DB�� ��������� �ݿ�
ROLLBACK;   -- ���� COMMIT ��ġ���� ���ư�
--------------------------------------------
SELECT * FROM EMP_01 ORDER BY EMP_ID;
-- ����� 217, 218, 219���� ����� ����
DELETE FROM EMP_01 WHERE EMP_ID IN (217, 218, 219);

-- �ӽ����� (SAVEPOINT)
SAVEPOINT SP;

-- ��� �߰�
INSERT INTO EMP_01 (EMP_ID, EMP_NAME)
    VALUES (700, '������');
    
-- ����� 222���� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 222;

-- �ӽ�����(SP) ��ġ�� ���ư�����
ROLLBACK TO SP;
COMMIT;
-----------------------------------------
-- 800�� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 800;

-- TEST ���̺� ����
CREATE TABLE TEST (
    T_NO NUMBER
);

ROLLBACK;
--> �ѹ��� ������, 800�� ��� ���ƿ��� �ʰ�, TEST ���̺��� ���ŵ��� ����
-- DDL (CREATE, ALTER, DROP)�� �����ϴ� ���� ������ Ʈ����ǿ� �־��� ���� ���׵���
-- ������ COMMIT�� �ȴ�.
-- �׷��� ������, DDL�� ����ϱ� ���� ���� ������ �ִٸ� Ȯ���� �����ְ� DDL�� ����ؾ� ��.