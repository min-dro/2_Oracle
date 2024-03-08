/*
    * DDL : ������ ���� ���
    
        - ALTER : ��ü(���̺�, �����, ��, ...)�� ����
        
            ALTER TABLE ���̺��� �����ҳ���;
            
            + ���� ����
              - �÷� ���� ���� �߰�/(���� - NOT NULL)/����
              - �÷� �߰�/����/����
              - ���̺���/Į����/�������Ǹ� ����
*/
-- (1) �÷� �߰�/����/����
--      * �÷� �߰� : ALTER TABLE ���̺��� ADD �߰���_�÷��� �ڷ���

--      DEPT_TABLE ���̺��� CNAME �÷� �߰� (VARCHAR2(20))
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);
SELECT * FROM DEPT_TABLE;


--      DEPT_TABLE ���̺��� LNAME �÷� �߰� (VARCHAR2(20), '�ѱ�')
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
-----------------------
--      * �÷� ���� : ALTER TABLE ���̺��� MODIFY �÷��� ������_�ڷ���;   -- �ڷ��� ����
--                   ALTER TABLE ���̺��� MODIFY �÷��� DEFAULT �⺻��; -- �⺻�� ����

--  DEPT_TABLE ���̺����� DEPT_ID �÷��� �ڷ����� CHAR(5) ���� ����;
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);  -- ����Ʈ ũ�� ���� : 2->5

-- DEPT_ID �÷��� �ڷ����� NUMBER�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;   -- ���� ���� �߻�!

--  DEPT_ID  �÷��� �ڷ����� VARCHAR2(10);
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID VARCHAR2(20); -- ���� �۵���!

-- DEPT_TITLE �÷��� �ڷ����� VARCHAR2(20)���� ���� (35 -> 20)
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(20); -- ���� ����

-- 20 -> 10 ����Ʈ ũ�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10); -- ũ�� ����!

----------------------------
--          * �÷� ���� : DROP COLUMN ������ �÷���
--  ���̺� ���� : DEPT_COPY ���� (DEPT_TABLE ���̺� ����)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPT_TABLE;

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
--> ���̺����� �ּ� �� ���� �÷��� �����ؾ� ��.
--------------------------------------------------------------------------------
/*
    [2] ���� ���� �߰�/���� -- �����ϰ��� �ϸ�, ���� �� �߰�
    
    * PRIMARY KEY  | ADD [CONTRAINT �������Ǹ�] PRIMARY KEY(�÷���)
    * FOREIGN KEY  | ADD [CONTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺��� [(�������÷���)]
    * NOT NULL     | MODIFY �÷��� [CONTRAINT �������Ǹ�] NOT NULL
    * UNIQUE       | ADD [CONTRAINT �������Ǹ�] UNIQUE(�÷���)
    * CHECK        | ADD [CONTRAINT �������Ǹ�] CHECK(���ǽ�-�÷������Ե����ǽ�)
*/
-- DEPT_TABLE -> DEPT_ID �⺻Ű ���� (DTABLE_PK)
--               DEPT_TITLE �ߺ����X (DTABLE_UQ)
--               LNAME NULL ���X (DTABLE_NN)
ALTER TABLE DEPT_TABLE
    ADD CONSTRAINT DTABLE_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DTABLE_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DTABLE_NN NOT NULL;
    
-- [����]
--  * DRPO CONSTRAINT �������Ǹ� -- NOT NULL�� ������ ����..!
--          + NOT NULL ���� ������ ���� -> NULL�� ���
--              MODIFY �÷��� NULL;
-- DEPT_TABLE���� �⺻Ű (DTABLE_PK) ���������� ����
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DTABLE_PK;


--  DEPT_TABLE���� DTABLE_UQ �������� ����, LNAME �÷��� NULL ���
ALTER TABLE DEPT_TABLE
    DROP CONSTRAINT DTABLE_UQ
    MODIFY LNAME NULL;
--------------------------------------------------------------------------------
/*
    [3] �̸��� ����. (�÷�/���̺�/��������)
    
        + �÷��� ���� : RENAME COLUMN �����÷��� TO �������÷���
        
        + �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �����������Ǹ�
        
        * ���̺��� ���� : RENAME TO �ٲ����̺���
*/
-- DEPT_TITLE -> DEPT_NAME
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- �������Ǹ� ����: SYS_c008456 -> DTABLE_NN
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008456 TO DTABLE_NN;

-- ���̺��� ����: DEPT_TABLE -> DEPT_TEST
ALTER TABLE DEPT_TABLE RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
/*
    * ���̺� ���� (DROP)
    
    [ǥ����]
            DROP TABLE ���̺���
            
    * �ٸ� ���̺����� ���� ���� ���̺��� ��� ������ ���� �ʴ´�.
      ���� �����ϰ��� �Ѵٸ�,
        1. �ڽ� ���̺�(�����ϰ� �ִ� ���̺�)�� ���� ������ �� ����
        2. �θ� ���̺��� �����ϴµ�, ���� ���Ǳ��� �����ϴ� ���
            DROP TABLE ���̺��� CASCADE CONSTRAINTS
*/
DROP TABLE DEPT_TEST;
COMMIT;

DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;