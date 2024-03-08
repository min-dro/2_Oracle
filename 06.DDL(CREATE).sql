/*
    * DDL : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE), ������ �����ϰ�(ALTER),
                            ���� ��ü�� ����(DELETE)�ϴ� ���
    ��, ���� ������ ���� �ƴ� ��Ģ ��ü�� �����ϴ� ���
    
    - ����Ŭ������ ��ü(����)    :    ���̺�, ��, ������
                                   ��
    < CREATE > : ��ü�� ���� �����ϴ� ����
*/
/*
    1. ���̺� ����
    - ���̺�: ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
             ��� �����͵��� ���̺��� ���ؼ� �����
            (DBMS ��� �� �ϳ��� �����͸� ������ ǥ ���·� ǥ���� ��)
            
    - ǥ����
    CREATE TABLE ���̺��� (
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
    )
    
    - �ڷ���
        * ���� -> �ݵ�� ũ�������� ����� ��.
            + CHAR(����Ʈũ��)    : �������� (������ ������ �����Ͱ� ��� ���
                                   -> ������ ���̺��� ���� ���� ���� ��� �������� ä������ ����
                                   �ִ� 2,000 ����Ʈ���� ���� ����
            + VARCHAR2(����Ʈũ��): �������� (������ ����)
        * ���� : NUMBER
        * ��¥ : DATE
*/
CREATE TABLE MEMBER ( -- MEMBER ��� �̸��� ���̺� ����
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PW VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),     -- ������ '��' | '��' ����
    PHONE VARCHAR2(13), -- 01012345678 , 010-1234-5678
    EMAIL VARCHAR2(30),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;

-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
--  * USER_TABLES : ����ڰ� ������ �ִ� ���̺����� �������� ����
SELECT * FROM USER_TABLES;
--------------------------------------------------------------------------------
/*
    2. �÷��� �ּ��ޱ� (�÷��� ���� ������ ����)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺���.�÷��� IS '�ּ� ����(����)';
    -> �߸� �ۼ� �� ���� �ۼ��ϸ� ������ ��
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PW IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEN_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '������';

-- ���̺� �����ϰ��� �� �� : DROP TABLE ���̺���;

-- ���̺��� �����͸� �߰��� �� ����ϴ� ���� (INSERT)
--  INSERT INTO ���̺��� VALUES (��, ��, ��, ��, ��, ...);
INSERT INTO MEMBER
VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1234-5678'
            , 'hong@naver.com', '24/01/29');
            
SELECT * FROM MEMBER;

INSERT INTO MEMBER
VALUES (2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL, SYSDATE);
    -- SYSDATE: �ý��� ���� ���� ��¥
    
INSERT INTO MEMBER
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--------------------------------------------------------------------------------
/*
    * ��������
    : ���ϴ� ������ ��(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
      ������ ���Ἲ ������ �������� ��.
      
    - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/
/*
    [1] NOT NULL ���� ����
        : �ش� �÷��� �ݵ�� ���� ������ ��� (��, ���� NULL�� ����Ǹ� �ȵǴ� ���)
          ����(�߰�)/���� �� NULL���� ������� �ʵ��� ����
          
    (+) �������� ���� ��� (2����)
        + �÷��������
        + ���̺��������
        
    * NOT NULL ���� ������ ��� ������ "�÷��������"�� ��� ����!
*/
CREATE TABLE MEM_NOTNULL (  -- MEM_NOTNULL ���̺� ����
    MEM_NO NUMBER NOT NULL, -- �÷�������� : �÷��� ������ ��ġ�� ���������� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE
);
INSERT INTO MEM_NOTNULL
VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1234-5678', 'hong@naver.com', SYSDATE);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES (3, NULL, 'PASS3', 'ȫȫȫ', NULL, NULL, NULL, NULL);
--> �츮�� �ǵ��� ��� ������ �߻�. NOT NULL ���� ������ �� �÷��� NULL�� �����Ϸ��� �ؼ�)

INSERT INTO MEM_NOTNULL
VALUES (3, 'USER2', 'PASS3', 'ȫȫȫ', NULL, NULL, NULL, NULL);
--> ����ڰ� ���̵� �����ϳ� �߰��� �� �Ǿ���. (�ߺ����� �ʰ� ó���� �ʿ���!)
--------------------------------------------------------------------------------
/*
    [2] UNIQUE ���� ����
        : �ش� �÷��� �ߺ��� ���� �߰����� �ʵ��� �� �� ���
          �÷� ���� �ߺ� ���� �����ϴ� ���� ����
          ����(�߰�)/���� �� �ߺ��Ǵ� ���� ���� ��� ������ �߻���Ŵ!
*/
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL, -- �÷�������� : �÷��� ������ ��ġ�� ���������� ����
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE
    -- , UNIQUE(MEM_ID)     --> ���̺��������
);
-- ���̺� ����
DROP TABLE MEM_UNIQUE;

-- ���̺�������� : ��� �÷��� ���� ���� �� �������� ���
--  * ��������(�÷���)
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE
    , UNIQUE(MEM_ID)     --> ���̺��������
);

INSERT INTO MEM_UNIQUE
VALUES (1, 'USER1', 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);
-- UNIQUE �������ǿ� ����Ǿ� INSERT �� ���� �߻�!
--> ���� �޽��� �� �ڼ��ϰ� ǥ������ ����. �ľ� �����)
--> ���� ���� ���� �� "�������Ǹ�"�� �����ϰ� �Ǹ�,
--      ���� �޽����� �ش� ��[�� ���Ǹ��� ǥ������.
--------------------------------------------------------------------------------
/*
    * ���� ���� ���� �� "�������Ǹ�"�� �����ϴ� ���
        + �÷�������� CREATE TABLE ���̺��� (
            �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
        );
        
    + ���̺��������
        CREATE TABLE ���̺��� (
            �÷��� �ڷ���,
            ...,
            [CONSTRAINT �������Ǹ�] ��������(�÷���)
        );
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,    -- �÷��������
    MEM_PW VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE,
    CONSTRAINT MEMID_UNIQ UNIQUE(MEM_ID)    -- ���̺��������
);

INSERT INTO MEM_UNIQUE
VALUES (1, 'USER1', 'PAS12', 'ȫ�浿', NULL, NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE
VALUES (2, 'USER1', 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE
VALUES (2, NULL, 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);
--> NULL ���� �������� �������Ǹ��� �ƴ϶� �ٸ� ���� �޽����� Ȯ�ε�.

INSERT INTO MEM_UNIQUE
VALUES (3, 'USER3', 'PASS3', 'ȫȫȫ', 'O', NULL, NULL, NULL);
--> ���� �����Ϳ� ��ȿ�� ���� �ƴ� ����ε��� �� �߰��� ��.
--------------------------------------------------------------------------------
/*
    [3] CHECK(���ǽ�)
        : �ش� �÷��� ����� �� �ִ� ���� ���� 
            ���ǿ� �ش�Ǿ�߸� ������ �߰� ����
*/
CREATE TABLE MEM_CHECK (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,    -- �÷��������
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    -- ������ ������ ���� : '��' �Ǵ� '��' �� ��쿡�� ����ǵ���
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')) NOT NULL,
    
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE,
    UNIQUE(MEM_ID)    -- ���̺��������
);

INSERT INTO MEM_CHECK
VALUES (1, 'USER1', 'PASS1', 'ȫ���', '��', NULL, NULL, NULL);

INSERT INTO MEM_CHECK
VALUES (2, 'USER2', 'PASS2', 'ȫȫȫ', 'O', NULL, NULL, NULL);
--> CHECK �������ǿ� ����Ǿ� ���� �߻�!

INSERT INTO MEM_CHECK
VALUES (2, 'USER2', 'PASS2', 'ȫȫȫ', NULL, NULL, NULL, NULL);
--> NULL �� ���� ���ٴ� ������ �߰��� ����.
--> NULL�� �ƴ� ���� CHECK ���Ǥ�[ �ش��ϴ� ���� �߰��� �� ����. ('��', '��')
INSERT INTO MEM_CHECK
VALUES (2, 'USER3', 'PASS3', '������', NULL, NULL, NULL, NULL);
--> ȸ�� ��ȣ�� �ش��ϴ� �����Ͱ� ���� ���ӿ��� �� �߰� ��.
--------------------------------------------------------------------------------
/*  [4] PRIMARY KEY (�⺻Ű) ��������
        : ���̺����� �� ��(������)���� �ĺ��ϱ� ���� ������ ���Ǵ� �÷�
        
        EX) ȸ����ȣ, �й�, ����, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, ...
        
        PRIMARY KEY�� �����Ǹ� �ش� �÷��� NOT NULL + UNIQUE�� �ɷ������� �ǹ���.
        *���� ����: �� ���̺� �� ������ �� ���� ���� ����
*/
CREATE TABLE MEM_PRI (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- MEM_NO �÷��� �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(13),
    EMAIL VARCHAR(30),
    UNIQUE(MEM_ID)
    --, CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)     -- ���̺�������� ����
);

INSERT INTO MEM_PRI
VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', '010-1234-5678', 'hong@naver.com');
--> �⺻Ű(MEM_NO)�� NULL ���� �߰��Ϸ��� ���� ���� �߻�! (UNIQUE ���� ����)

INSERT INTO MEM_PRI
VALUES (NULL, 'USER2', 'PASS2', 'ȫ���', NULL, NULL);
----------------
-- ���� �߻�! , PRIMARY KEY�� 
CREATE TABLE MEM_PRI2 (
    MEM_NO NUMBER PRIMARY KEY, -- MEM_NO �÷��� �⺻Ű�� ����
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(13),
    EMAIL VARCHAR(30)
);

-- �� ���� �÷��� �ϳ��� PRIMART KEY�� ����ϰ��� �� ���
CREATE TABLE MEM_PRI2 (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR(30),
    PRIMARY KEY(MEM_NO, MEM_ID) --> ���� �÷��� ��� �ϳ��� �⺻Ű�� ��� (����Ű)
);

INSERT INTO MWM_PRI2
VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', NULL, NULL);

INSERT INTO MWM_PRI2
VALUES (1, 'USER2', 'PASS1', 'ȫ���', NULL, NULL);

INSERT INTO MWM_PRI2
VALUES (2, 'USER2', 'PASS1', 'ȫȫȫ', NULL, NULL);

-- ����Ű ��� ����
CREATE TABLE TB_LIKE (
    MEM_NO NUMBER, 
    PRODUCT_NAME VARCHAR(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

-- ȸ�� ��ȣ 1, ��ǰ�� ȭ��ǰA ������ �߰�
INSERT INTO TB_LIKE VALUES (1, 'ȭ��ǰA', SYSDATE);
-- ȸ�� ��ȣ 2, ��ǰ�� ȭ��ǰA ������ �߰�
INSERT INTO TB_LIKE VALUES (2, 'ȭ��ǰA', SYSDATE);
-- ȸ�� ��ȣ 1, ��ǰ�� ȭ��ǰA ������ �߰�
INSERT INTO TB_LIKE VALUES (1, 'ȭ��ǰA', SYSDATE);

-- ����Ű�� ������ �÷� �� �ϳ��� �÷��� NULL�� �߰��� �� �ִ°�? (X)
INSERT INTO TB_LIKE VALUES (1, NULL, SYSDATE);
--------------------------------------------------------------------------------
/*
    [5] FOREIGN KEY (�ܷ�Ű)
        : �ٸ� ���̺��� �����ϴ� ���� ���Ǵ� �÷��� �����ϴ� ���� ����
*/
-- ȸ�� ��� ���� ���̺� ����
CREATE TABLE MEM_GRADE (
    GEADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR(20) NOT NULL
);
-- CODE : NAME
-- 100: �Ϲ�ȸ��
-- 200: ���ȸ��
-- 300: Ư��ȸ��
INSERT INTO MEM_GRADE VALUES (100, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES (200, '���ȸ��');
INSERT INTO MEM_GRADE VALUES (300, 'Ư��ȸ��');

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- MEM_NO �÷��� �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR(30),
    GRADE_ID NUMBER,
    UNIQUE(MEM_ID)
);


INSERT INTO MEM VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', NULL, NULL, NULL);
INSERT INTO MEM VALUES (2, 'USER2', 'PASS2', 'Ȧ���', NULL, NULL, 100);
INSERT INTO MEM VALUES (3, 'USER3', 'PASS3', 'ȫȫȫ', NULL, NULL, 400);
--> ��ȿ�� ȸ������� �ƴѵ��� �����Ͱ� �� �߰��ǰ� ����

DROP TABLE MEM;


-- �ܷ�Ű �������:
--          REFERENCES ���������̺���(�������÷���) -- �÷��������
--          FOREIGN KEY(�÷���) REFERENCES ���������̺���([�������÷���]) -- ���̺��������
--    * ������ �÷����� �����ϴ� ��� �ش� ���������̺��� �⺻Ű�� �ڵ����� ������!
CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY, -- MEM_NO �÷��� �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR(30),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE),
    UNIQUE(MEM_ID)
    -- , FOREIGN KEY (GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE),
);

INSERT INTO MEM VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', NULL, NULL, NULL);
--> �ܷ�Ű ���������� �⺻������ NULL�� ����
INSERT INTO MEM VALUES (2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, 100);

INSERT INTO MEM VALUES (3, 'USER3', 'PASS3', 'ȫȫȫ', NULL, NULL, 400);
--> �θ� Ű�� ���ٴ� ���� �߻�

INSERT INTO MEM VALUES (3, 'USER3', 'PASS3', 'ȫȫȫ', NULL, NULL, 100);

-- MEM_GRADE (�θ����̺�) -1----<-  MEM (�ڽ����̺�)
-- 1:N ���� ) 1 - �θ����̺�, N -�ڽ����̺�

-- �θ����̺��� �ִ� �����͸� �����Ѵٸ�? ������ ������?
-- ������ ����: DELETE FROM ���̺��� WHERE ���ǽ�;
--      * ���� �� �ش� ���ǽ����� SELECT�� ���� �غ���!

SELECT * FROM NEW_GRADE WHERE GRADE_CODE = 100;

DELETE FROM MEM_GRADE WHERE GRADE_CODE = 100;
--> ���� �� ���� �߻�!
--   �ڽ����̺�(MEM)�� ��� ���� ���� �ִ�.

SELECT * FROM MEM_GRADE WHERE GRADE_CODE = 300;
DELETE FROM MEM_GRADE WHERE GRADE_CODE = 300;
-->  �ش� �����͸� ������� �ڽ����̺��� ��� ������ ���������� �����.

--> "���� ����" �ɼ��� ������ �� ����
-- COMMIT;      -- ����/���� �� �ý��������� �����ϴ� ���ɾ�. ROLLBACK �Ұ�.
ROLLBACK;       -- ����/���� �� ������� �������� ���ɾ�(����)
--------------------------------------------------------------------------------
/*
    * ���� ���� �ɼ�
      : �ܷ� Ű ���� �� �θ����̺��� �����Ͱ� �����Ǵ� ��� �ڽ� ���̺��� ����
        ��� ó���� �� �����ϴ� �ɼ�
        
      - ON DELETE RESTRICTED (�⺻��) : �������ѿɼ�, �ڽ����̺����� ������� �����ʹ�
                                       �θ����̺����� ������ ���� ����
      - ON DELETE SET NULL : �θ� ���̺����� ���� ��, �ڽ����̺����� ������� �����Ͱ�
                            NULL ������ �����
      - ON DELETE CASCADE : �θ�
*/

DROP TABLE MEM;

-- �ܷ�Ű ���� �ڿ� ���� �ɼ��� �߰�
CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY, -- MEM_NO �÷��� �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR(30),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL,
    UNIQUE(MEM_ID)
);

INSERT INTO MEM VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', NULL, NULL, NULL);
INSERT INTO MEM VALUES (2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, 100);
INSERT INTO MEM VALUES (3, 'USER3', 'PASS3', 'ȫȫȫ', NULL, NULL, 200);
INSERT INTO MEM VALUES (4, 'USER4', 'PASS4', 'ȫ�ϳ�', NULL, NULL, 100);

-- MEM_GRADE ���̺����� GRADE_CODE�� 100�� �����͸� ����
DELETE FORM MEM_GRADE WHERE GRADE_CODE = 100;
--> �θ����̺����� ���� ��, �ڽ����̺��� �����Ͱ� NULL�� ����Ǿ���.

ROLLBACK;

DROP TABLE MEM;

CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY, -- MEM_NO �÷��� �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR(30),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE,
    UNIQUE(MEM_ID)
);
INSERT INTO MEM VALUES (1, 'USER1', 'PASS1', 'ȫ�浿', NULL, NULL, NULL);
INSERT INTO MEM VALUES (2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, 100);
INSERT INTO MEM VALUES (3, 'USER3', 'PASS3', 'ȫȫȫ', NULL, NULL, 200);
INSERT INTO MEM VALUES (4, 'USER4', 'PASS4', 'ȫ�ϳ�', NULL, NULL, 100);

DELETE FROM MEM_GRADE WHERE GRADE_CODE = 100;
--> �θ����̺����� ���� �� �ڼ����̺������� ��� ���� �����Ͱ� ������ ���� ������ ��. (����..)
--------------------------------------------------------------------------------
/*
    * �⺻�� (DEFAULT)
        - ���������� �ƴ�.
        - ������ �߰��� NULL�� �ƴ� �⺻���� �߰��ϰ��� �� �� ���
        
        [���ǹ��]
        �÷��� �ڷ�� DEFAULT �⺻��
        
        [������ �߰� ��]
        VALUES(.., DEFAULT, ..)
*/
DROP TABLE MEMBER

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    UPDATE_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES(1, 'ȫ�浿', 18, '����', DEFAULT);
INSERT INTO MEMBER VALUES(2, 'ȫ���', 25, DEFAULT, '24/01/15');

-- ������ �߰�(2) : INSERT INTO ���̺���(�÷���1, �÷���2) VALUES(��1, ��2);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(3, 'ȫ�ϳ�');
--> �������� ���� �÷��� ���� ���� �⺻������ NULL�� �����
--  DEFAULT ������ �� Į���� ��� ���� �⺻������ �����
--------------------------------------------------------------------------------
-- ���� ���� ����: kh �������� ����
--  (���� ��� ���� ������ ����)

-- ���� ���̺�(EMPLOYEE)�� �����ϵ��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * FROM EMPLOYEE);

/* 
    * ���̺��� ������ �Ŀ� ���� ������ �����ϴ� ���
    ALTER TABLE ���̺��� ������_����
    
    - PRIMARY KEY : ALTER TABLE ���̺��� ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ALTER TABLE ���̺��� ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��� [(�������÷���)];
    - UNIQUE      : ALTER TABLE ���̺��� ADD CHECK(�÷����� ���� ���ǽ�);
    - NOT NULL    : ALTER TABLE ���̺��� MODIFY �÷��� NOT NULL;
*/
-- EMPLOYEE_CODY ���̺��� �⺻Ű EMP_ID
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);
-- EMPLOYEE_COPY ���̺��� �ܷ�Ű DEPT_CODE (DEPARTMENT.DEPT_ID)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);
-- EMPLOYEE_CODY ���̺��� �ܷ�Ű JOB_CODE (JOB.JOB_CODE)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB (JOB_CODE);
-- DEPARTMENT ���̺��� LOCATION_ID (LOCATION.LOCAL_CODE)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION (LOCAL_CODE);