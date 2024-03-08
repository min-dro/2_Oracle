/*
    * Ʈ���� (TRIGGER)
      : ������ ���̺��� DML(INSERT, UPDATE, DELETE)���� ���� ������� ���� �� (���̺��� �̺�Ʈ�� �߻����� ��)
        �ڵ����� �Ź� ������ ������ �̸� �����صδ� ��.
        
     ex) ȸ�� Ż�� �� ���� ȸ�����̺��� ������ ����(DELETE)�ϰ�,
         Ż�� ȸ�� ���̺��� ������ �߰�(INSERT)�ؾ� �� �� �ڵ����� ������
         
         �Ű�Ƚ�� Ư������ �Ѿ�� �� �ش� ȸ���� ��������Ʈ�� ó��
         
         ������� ���� �����͸� ����� �� �ش� ��ǰ�� ���� ��� ������ �����ؾ� �� ��
         
        * Ʈ������ ����
            - SQL���� ���� �ñ⿡ ���� �з�
                + BEFORE TRIGER : ������ ���̺��� �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ����
                + AFTER TRIGGER : ������ ���̺��� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
                
            - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
                + ���� Ʈ����    : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
                + �� Ʈ����      : �ش� SQL���� ������ ������ �Ź� Ʈ���� ����
                                  (�ɼ� �� FOR EACH ROW �����ؾ� ��)
                                  
                                :OLD - BEFORE UPDATE(���� �� �ڷ�), BEFORE DELETE (���� �� �ڷ�)
                                :NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
                                
    * Ʈ���� ����( ���� ���� ) 
        CREATE TRIGGER �̸�
        BEFORE|AFTER INSERT|UPDATE|DELETE ON ���̺���
        [FOR EACH ROW]
        [DECLARE] -- ���� �� ��� ����, �ʱ�ȭ
        BEGIN     -- ����� (SQL��, ���ǹ�, �ݺ���, ...)
                  -- �̺�Ʈ �߻� �� �ڵ����� ó���� ����
        [EXCEPTION] -- ����ó����
        END;
        /
*/
SET SERVEROUTPUT ON;
-- EMPLOYEE ���̺��� �����Ͱ� �߰��� ������ '���Ի���� ȯ���մϴ�!' ��� (Ʈ���� ����)
CREATE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (500, '�̼���', '111111-1111111', 'D7', 'J7', SYSDATE); 
    
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (501, '������', '111111-1111111', 'D8', 'J7', SYSDATE); 
--------------------------------------------------------------------------------
-- ��ǰ�԰� �� ��� ����

--  1) ���̺�, ������ ����
CREATE TABLE TB_PRODUCT (
    PCODE NUMBER PRIMARY KEY,       -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,    -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,    -- �귣��
    PRICE NUMBER,                   -- ����
    STOCK NUMBER DEFAULT 0          -- �������
);

-- ��ǰ��ȣ �÷��� ����� ������ ( 200������ ����, 5�� ����, ĳ�ø޸�X) - SEQ_PCODE
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���� ������ �߰�
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '������24', '����', 1300000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '������15', '���', 1900000, 10);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL, '�����', '�����', 700000, 30);

SELECT * FROM TB_PRODUCT ;

COMMIT;     -- DB�� �ݿ�

-- ��ǰ ����� �� �̷� ���̺�
CREATE TABLE TB_PRODETAIL (
    DECODE NUMBER PRIMARY KEY,          -- �̷� ��ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT, -- ��ǰ ��ȣ
    PDATE DATE NOT NULL,                -- �������
    AMOUNT NUMBER NOT NULL,             -- ���������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���'))    -- ����
);
-- TB_PRODETAIL ���̺��� DECODE �÷��� ���� ������ (SEQ_DECODE) - ĳ�ø޸�X
CREATE SEQUENCE SEQ_DECODE
NOCACHE;

-- TB_PRODETAIL 200�� ��ǰ, ���ó�¥, 10�� �԰�) ������ �߰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');

-- TB_PRODUCT
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 205�� ��ǰ ���� ��¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');

UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

ROLLBACK;       -- ������Ʈ�� �߸��ؼ� ROLLBACK;

INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;
------------------------
-- TB_PRODETAIL ���̺��� INSERT �̺�Ʈ �߻� ��
-- TB_PRODUCT ���̺��� �Ź� ��� ���� UPDATE => �ڵ����� ����ǰԲ� Ʈ���� ����
/*
    - UPDATE ����
    
        * ��ǰ�� �԰��� ��� => �ش� ��ǰ�� ã�Ƽ� ��� ���� ����
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + �԰�����(TB_PRODETAIL.AMOUNT)
            WHERE PCODE = �԰��Ȼ�ǰ��ȣ(TB_PRODETAIL.PCODE)
        * ��ǰ�� ����� ��� => �ش� ��ǰ�� ã�Ƽ� ��� ���� ����
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - �������(TB_PRODETAIL.AMOUNT)
            WHERE PCODE = ����Ȼ�ǰ��ȣ(TB_PRODETAIL.PCODE)
*/
--TRG_02
CREATE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- �԰� ��� ���� (STATUS)
    IF :NEW.STATUS = '�԰�'
        THEN UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    ELSIF :NEW.STATUS = '���'
         THEN UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 220, SYSDATE, 7, '���');