/*
    �Լ�(FUNCTION) : ���޵� �÷� ���� ����Ͽ� �Լ��� ������ ����� ��ȯ
    
    - ������ �Լ�
        : N���� ���� �о�鿩�� N���� ������� ��ȯ (�� �ึ�� �Լ� �������� ��ȯ)
        
    - �׷��Լ�
        : N���� ���� �о�鿩�� 1���� ������� ��ȯ (�׷� ��� �׷� ���� �Լ� �������� ��ȯ)
        
    => SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ��� �� �� ����!!
       ��� ���� ������ �ٸ��� ����
       
    => �Լ��� ��� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/
-- ================================ ������ �Լ� =================================
/*
    <���� ó�� �Լ�> : CHAR, VARCHAR, ..
    
    * ���� �� ��ȯ : LENGTH / LENGTHB    => ��� �� NUMBER Ÿ��(����)
        - LENGTH(�÷��� | '���ڿ� ��') : �ش� ���ڿ��� ���� ��
        - LENGTHB(�÷��� | '���ڿ� ��') : �ش� ���ڿ��� ����Ʈ �� 
        
            + ������, ����, Ư������, : 1byte
            + �ѱ� ('��', '��', '��') : 3byte
*/
-- ��� ���̺� ���� : DUAL
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') || 'byte'
FROM DUAL;

SELECT LENGTH('Oracle'), lengthb('oracle') || 'byte' -- �Լ� ��� �ô�ҹ��� �������!
from dual;

-- ���� ���̺����� �������� ���� ���� ����Ʈ ��, �̸����� ���� ���� ����Ʈ ���� ��ȸ
SELECT EMP_NAME, LENGTH(EMP_NAME) "������ ���� ��", LENGTHB(EMP_NAME) "������ ����Ʈ ��",
        EMAIL, LENGTH(EMAIL) "�̸��� ���� ��", LENGTHB(EMAIL) "�̸��� ����Ʈ ��"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * INSTR : ���ڿ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷��� | '���ڿ� ��', 'ã�����ϴ� ����', [ã��_��ġ��_����_��(1), [����(1)]])
    => ��� ���� NUMBERŸ��(����). �ش� ������ ��ġ ��.
    
    - ã�� ��ġ�� ���� ��
      * 1 : �տ������� ã��
      * -1 : �ڿ������� ã��
*/
-- �׽�Ʈ ���ڿ� : AABAACAABAA / ���� ���̺�: DUAL
--  * B ���� ��ġ ã��
SELECT INSTR('AABAACAABAA', 'B') FROM DUAL;      -- 3��° ��ġ
--  => ������ġ : 1, ���� : 1

-- * B ���ڸ� �ڿ������� ã��
--   => �ڿ������� ã�� ��, ��ġ�� ���ڿ� ù���� ��ġ�� ������ �Ǿ� ����� ��ȯ
SELECT INSTR('AABAACAABAA', 'B', -1) FROM DUAL;     -- 9��° ��ġ

-- * B ���ڸ� �տ������� ã�µ�, 2��°�� ã�� ��ġ
SELECT INSTR('AABAACAABAA', 'B', 1, 2) FROM DUAL;   -- 9��° ��ġ(�տ������� ã���� �� �ι�° B�� ��ġ)

--  * B ���ڸ� �ڿ������� ã�µ�, 2������ ã�� ��ġ
SELECT INSTR('AABAACAABAA', 'B' -1, 2) FROM DUAL;   -- 3���� ��ġ (�ڿ������� ã���� �� �ι�° B�� ��ġ)

--  * B ���ڸ� �ڿ������� ã�µ�, 3������ ã�� ��ġ
SELECT INSTR('AABAACAABAA', 'B', -1, 3) FROM DUAL;  -- 0��° ��ġ => ���ǿ� �´� ��ġ�� ã�� ���ߴ�.
-- �ڿ������� 3��° ��ġ�� �ִ�'B' ���� ����!

-- ���� ���̺����� �̸���, �̸��� �� '_' ��ġ ù������ ã�� ��ġ, '@' ������ ��ġ ��ȸ
SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) "_ ��ġ", INSTR(EMAIL, '@') "@ ��ġ"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * SUBSTR : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ

    SUBSTR(�÷��� | '���ڿ� ��', ������ġ, ������_����_����) => ��� ���� characterŸ��(����)
    - ������_����_���� �κ��� ������ ��� ������ġ���� ������ �����Ѵ�.
*/
-- ���� ������ : 'This too shall pass.' -- �� ���� ����������. | ���� ���̺�: DUAL
SELECT SUBSTR('This too shall pass.', 10) FROM DUAL;    -- ���: shall pass.

SELECT SUBTER('This too shall pass.', 6, 3) FROM DUAL;    -- ���: too

SELECT SUBTER('This too shall pass.', -11, 3) FROM DUAL;    -- ���: sha

-- ���� ���̺����� �����, ��� �ֹι�ȣ�� ����(�ش� ��ġ�� ��) ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) "����" FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
-- ���� ����鸸 ��ȸ
SELECT * FROM EMPLOYEE 
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 'sjlim.iei@gmail.com' => | �Ӽ��� | sjlim.iei@gmail.com | sjlim.iei |
-- ���� ���̺� ������, �̸���, �̸��� ���̵� ��� ������ ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "���̵�"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * LPAD / RPAD : ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    RPAD(�÷��� | '���ڿ� ��', ����������_��ȯ�� ���ڿ���_����, [�����̰��� �ϴ� ����(����)])
    => ��� �� CHARACTERŸ�� (����)
    LPAD ...
    
    - ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �߰��Ͽ� ���� N ������ ���ڿ� ��ȯ
*/
-- ��ü ������ ������, �̸��� ��ȸ (�̸��� �������� ��� �� ���̸� 20���� �ΰ�, ������ ����)
SELECT EMP_NAME, LPAD(EMAIL, 20) "�̸���" FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#') "�̸���" FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#') "�̸���" FROM EMPLOYEE; -- ���� ����

-- ���� ������ : '870927-1', 14, '*') FROM DUAL;
SELECT RPAD('870927-1', 14, '*') FROM DUAL;

-- ���� ���̺����� ������, �ֹι�ȣ�� ��� ������ ��ȸ (�ֹι�ȣ �޹�ȣ ù��°������ ǥ��, ������ *�� ǥ��)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1, 8), 14, '*') "�ֹι�ȣ"
FROM EMPLOYEE;

-- �޹�ȣ�� �� ������ ������...?
SELECT EMP_NAME, SUBSTR(EMP_NO,1, 7) || '*******' "�ֹι�ȣ"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * LTRIM / RTRIM : ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM(�÷��� | '���ڿ� ��', [�����ϰ��� �ϴ� ����(����)]) => ��� �� CHAEACTERŸ�� (����)
    RTRIM(...
    
    - ���ڿ��� ���� �Ǵ� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ������ �� ������ ���ڿ��� ��ȯ
*/
SELECT LTRIM('   K  H') FROM DUAL; -- �����ϰ��� �ϴ� ���ڸ� �Է����� ������ ������ ���ŵ�.

SELECT LTRIM('123123K123H123', '123') FROM DUAL;

SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;  -- ������ ���ڴ� ���ڿ��� �ƴ϶� ���ڵ�


/*
    * TRIM : ���ڿ��� ��/��/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    
    TRIM(�÷��� | '���ڿ� ��')     -- ���ʿ��� ���� ����
    TRIM(Ư������ FROM ���ڿ�)     -- ���ڿ����� Ư�� ���ڸ� ���ʿ��� ����
    TRIM([LEADING | TRAILING | BOTH] Ư������ FROM ���ڿ�)
        * LEADING : �տ��� Ư�� ���� ���� => LTRIM ����
        * TRAILING : �ڿ��� Ư�� ���� ���� => RTRIM ����
        * BOTH : ���ʿ��� Ư�� ���� ���� => Ű���� ���� �� ����(�⺻��)
*/
SELECT TRIM(LEADING 'z' FROM 'zzzzzzzkhzzzzzzzzzzz') FROM DUAL;
SELECT TRIM(TRAILING 'z' FROM 'zzzzzzzkhzzzzzzzzz') FROM DUAL;
SELECT TRIM(BOTH 'z' FROM 'zzzzzzzkhzzzzzzzzz') FROM DUAL;
--------------------------------------------------------------------------------
/*
    * ��/�ҹ��� ��ȯ ���� �Լ� : LOWER / UPPER / INITCAP
    
        LOWER|UPPER|INITCAP(�÷��� | '���ڿ� ��') => ��� ���� CHARACTERŸ�� (����)
        - LOWER : ���ڿ��� ��� ���ڸ� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ
*/
-- ���õ����� : 

--------------------------------------------------------------------------------
/*
    * CONCAT : ���ڿ� �� ���� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(���ڿ�A, ���ڿ�B) => ����� CHARACTERŸ��(����)
*/
SELECT CONCAT('�𳪹�', '����') "CONCAT_�׽�Ʈ" FROM DUAL; -- �� ���� ���ڿ��� ����

-- CONCAT ���� CONCAT ����� �����ϳ�, ����...
-- SELECT CONCAT('�𳪹�', CONCAT('����', CONCAT('����','����'));

--------------------------------------------------------------------------------
/*

    REPLACE(���ڿ�|�÷�, Ư��_���ڿ�, ������_���ڿ�)
        - Ư��_���ڿ�: ��ȯ �� ���ڿ�
        - ������_���ڿ�: ��ȯ �� ���ڿ�
    + ������ ���� �� ����
*/
-- �̸��� �ּҿ��� 'KH.or.kr' �� �κ��� 'gmail.com'���� ��ȯ�Ͽ� ��ȸ
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, '@KH.or.kr', '@gmail.com')
FROM EMPLOYEE;
-- =============================================================================
/*
    * ���� ���� �Լ�
    
    - ABS : ������ ���밪�� �����ִ� �Լ�
    
    ABS(����_������ | �÷�) => ��� �� NUMBERŸ��(����)
*/
SELECT ABS(-10) "-10�� ���밪" FROM DUAL;
SELECT ABS(-3.14) "-3.14�� ���밪" FROM DUAL;
--------------------------------------------------------------------------------
/*
    - MOD : �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
    MOD(����_������1, ����_������2) => ��� �� NUMMBERŸ��(����)
*/
SELECT MOD(10, 3) "10�� 3���� ���� ������" FROM DUAL;   -- ���: 1
SELECT MOD(3, 10) "3�� 10���� ���� ������" FROM DUAL;   -- ���: 3
SELECT MOD(10.5, 3) "10.5�� 3���� ���� ������" FROM DUAL;   -- ���: 1.5
--------------------------------------------------------------------------------
/*
    - ROUND : �ݿø��� ����� ��ȯ => ��� �� NUMBERŸ�� (����)
    
    ROUND(����_������, [�Ҽ��� ��ġ(0)])
*/
SELECT ROUND(123.456) FROM DUAL;    -- �Ҽ��� ��ġ ���� -> 0�� �⺻ ��. ���: 123
SELECT ROUND(123.345, 1) FROM DUAL; -- ���: 123.5
SELECT ROUND(123.456, -1) FROM DUAL; -- ���: 120

/*

    - CEIL : �ø�ó���� �ؼ� ��ȯ
    
    CEIL(����_������)
*/
SELECT CEIL(123.456) FROM DUAL;     -- ���: 124

/*
    - FLOOOR : ���� ó���� �ϴ� �Լ�
        * �Ҽ����� �����ϸ鼭 ����(����) ó��
        * �Ҽ����� �����ϰ� ���� ���� ����
    FLOOR(����_������)
*/
SELECT FLOOR(123.456) FROM DUAL;    -- ���: 123
SELECT FLOOR(-3.14) FROM DUAL;      -- ���: -4

/*
    - TRUNC : ���� ó���� �ϴ� �Լ�
        * ��ġ�� ������ �� ����
        
    TRUNC(����_������, [�Ҽ���_��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL;    -- ���: 123
SELECT TRUNC(123.456, 1) FROM DUAL;  -- ���: 123.4
SELECT TRUNC(123.456, -1) FROM DUAL;  -- ���: 120
-- =============================================================================
/*
    * ��¥ ���� �Լ�
    
    - SYSDATE  : �ý����� ���� ��¥ �� �ð��� ��ȯ
*/
SELECT SYSDATE FROM DUAL;   -- ���� ��¥ ��ȸ : YY/MM/DD �������� ��ȸ��.

/*
    - MONTHS_BETWEEN �� ��¥ ������ ���� ��
    
    MONTHS_BETWEEN(��¥A(DATEŸ��), ��¥B(DATEŸ��)) => ��� �� NUMBERŸ��(����)
*/
-- ���� ���̺����� �����, �Ի���, �ٹ��ϼ�, �ٹ� ���� �� ��ȸ
-- �ٹ��ϼ� �Ҽ����� ��� ����, �ٹ� ���� �� �ø� ó��(~������)
-- ex) ������ |  �Ի���   | �ٹ��ϼ�| �ټӰ���
--     ȫ�浿 | 03/02/09 |  2532  | 7������
SELECT EMP_NAME "������", HIRE_DATE "�Ի���", TRUNC(SYSDATE - HIRE_DATE) "�ٹ��ϼ�", 
        CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������' "�ٹ� ���� ��"
FROM EMPLOYEE;

/*
    - ADD_MONTHS : Ư�� ��¥�� N���� ���� ���ؼ� ��ȯ
    
    ADD_MONTHS(Ư��_��¥, N) => ��� �� DATEŸ��(��¥)
*/
SELECT SYSDATE "���糯¥", ADD_MONTHS(SYSDATE, 5) "5������" FROM DUAL;
-- ���� ���̺����� ������, �Ի���, �Ի� �� 3���� ���� ��¥ ��ȸ
--      ������ |  �Ի���   |   ���� ������   |
--      ȫ�浿 | 24/01/24 |    24/04/24    |
SELECT EMP_NAME "������", HIRE_DATE "�Ի���", ADD_MONTHS(HIRE_DATE, 3) "���� ������"
FROM EMPLOYEE;

/*
    - NEXT_DAY : Ư��_��¥, ����_����)
    * ����_����
        + '������', 'ȭ����', ... '�Ͽ���'
        + '��', 'ȭ', ... '��'
        + 1, 2, ..., 7 : 1(�Ͽ���), 2(������), ... 7(�����)
        + 'MONDAY'
*/
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

SELECT NEXT_DAY(SYSDATE, 6) FROM DUAL;  -- ��� ��� ���� ��� ����

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;   -- ��� ����

/*
    - LAST_DAY : �ش� ���� ������ ��¥�� ��ȯ���ִ� �Լ�
    
    LAST_DAY(��¥_������) => ��� ���� DATEŸ��(��¥)
*/
SELECT LAST_DAY(SYSDATE) "�̹����� ������ ��" FROM DUAL;

-- �������̺����� ������, �Ի���, �Ի��� ���� ������ ��, �Ի��� ���� �ٹ��ϼ��� ��ȸ
--  ������ |   �Ի��� |   �Ի��� �� ������ �� |   �Ի��� ���� �ٹ��ϼ� |
SELECT EMP_NAME "������", HIRE_DATE "�Ի���", LAST_DAY(HIRE_DATE) "�Ի��� �� ������ ��",
        LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;
/*
    - EXTRACT : Ư�� ��¥�κ��� �⵵/��/�� �� �ش��ϴ� ���� �������ִ� �Լ�
    
    + ���� ���� : EXTRACT(YEAR FROM Ư��_��¥)
    + �� ����   : EXTRACT(MONTH FROM Ư��_��¥)
    + �� ����   : EXTRACT(DAY FROM Ư��_��¥)
    => ��� ���� NUMBERŸ��(����)
*/
-- ���� �������� �����, �Ի�⵵, �Ի��, �Ի����� ��ȸ (�Ի�⵵>�Ի��>�Ի���> �������� ����)
--      �����     |   �Ի�⵵    |   �Ի�� |   �Ի��� |
SELECT EMP_NAME "�����",
            EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵", 
            EXTRACT(MONTH FROM HIRE_DATE) "�Ի��",
            EXTRACT(DAY FROM HIRE_DATE) "�Ի���"
FROM EMPLOYEE
-- ORDER BY �Ի�⵵, �Ի��, �Ի���;
ORDER BY 2, 3, 4;
-- =============================================================================
/*
    * ����ȯ �Լ� : ������ Ÿ���� ��ȯ���ִ� �Լ�
*/

/*
    - TO_CHAR ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ ��ȯ���ִ� �Լ�
    
    TO_CHAR(���� �Ǵ� ��¥ ��(�÷�), [����]) => ��� ���� CHARACTERŸ��(����)
*/
-- ���� Ÿ�� -> ���� Ÿ��
SELECT 1234 "���� Ÿ�� ������", TO_CHAR(1234) "��ȯ �� ������" FROM DUAL;
--  5ĭ ������ Ȯ��, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '99999') "1234" FROM DUAL;    -- 9 : �������� ó��
SELECT TO_CHAR(1234, '00000') "1234" FROM DUAL;    -- 0 : Ȯ���� ������ŭ ���� ���� ��� 0���� ä��

--  ȭ��
SELECT TO_CHAR(1234, 'L99999') "���� ȭ�� ����" FROM DUAL;   -- ���� ������ ������ ȭ�� ���� (L: Local)
SELECT TO_CHAR(1234, '$99999') "�޷� ���� ǥ��" FROM DUAL;   -- �޷��� ǥ��
--  123,456,789
SELECT TO_CHAR(123456789, '999,999,999') "������ �� ����" FROM DUAL;

-- ���� �������� �����, ����, ���� ��ȸ  (��ȭ ǥ��)
--    �����    |  ����      |     ����      |
--    ȫ�浿    | \4,000,000 | \50,000,000   |
SELECT EMP_NAME "�����", TO_CHAR(SALARY, 'L999,999,999') "����",
            TO_CHAR(SALARY*12, 'L999,999,999') "����"
FROM EMPLOYEE;

-- ��¥ Ÿ�� -> ���� Ÿ��
-- ���� ��¥ ��ȸ
SELECT SYSDATE FROM DUAL;
-- (��¥) YYYY : ����, MM : ��, DD : ��
SELECT TO_CHAR(SYSDATE) FROM DUAL;
-- (�ð�) HH : ��, MI : ��, SS : ��
SELECT SYSDATE,TO_CHAR(SYSDATE, 'HH:HI:SS') FROM DUAL;
-- 24�ð� ���� : HH24
SELECT SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;

-- ���� ���̺����� ������, �Ի���(xxxx�� xx�� xx��) ��ȸ
--   * ���� ��ġ���� ������ ���ĸ� ��� ����! ���ڸ� ���� ��쿡�� ū����ǥ("")�� ��� �ۼ�
SELECT EMP_NAME "������", TO_CHAR(HIRE_DATE, 'YYYY"�� "MM"�� "DD"��"') "�Ի���"
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
        TO_CHAR(SYSDATE, 'YY'),
        TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')         -- �ش� ��¥�� ������ ����� ��ȸ
FROM DUAL;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
        TO_CHAR(SYSDATE, 'MON'),        -- �ش� ���� 'x��' �������� ��ȸ
        TO_CHAR(SYSDATE, 'MONTH'),
        TO_CHAR(SYSDATE, 'RM')          -- �ش� ���� �θ� ���ڷ� ��ȸ
FROM DUAL;

-- �Ͽ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DD'),
        TO_CHAR(SYSDATE, 'DDD'),         -- �̹� ���� �� ��° �ϼ�
        TO_CHAR(SYSDATE, 'D')
FROM DUAL;

-- ���Ͽ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),          -- x���� : �������� ��ȸ
        TO_CHAR(SYSDATR, 'DY')
FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TO_DATE : ���� �Ǵ� ����Ÿ���� �����͸� ����Ÿ�� ��ȯ���ִ� �Լ�
    
    TO_DATE(���� �Ǵ� ���� ������, [����]) => ��� �� DATEŸ��(��¥)
*/
SELECT TO_DATE(20240124) FROM DUAL;     -- ����Ÿ�� -> ��¥Ÿ��
SELECT TO_DATE('20240124') FROM DUAL;   -- ����Ÿ�� -> ��¥Ÿ��

-- SELECT TO_DATE('20240124 140650')       -- �ð� �����͸� �߰��ϸ� ������ �����ؾ� ��!
-- SELECT TO_DATE('20240124 140650', 'YYYYMMDD HH24MISS') -- �Է��� ������ ������ ����.
-- SELECT TO_CHAR(TO_DATE('140940', 'HH24MISS'), 'HH:MI:SS') -- ����Ÿ���� �ð� �����͸� ��¥Ÿ������ ��ȯ
                                            -- => TO_CHAR �� ��ȯ�� ���� Ȯ�ο����� �����.
-- SELECT TO_CHAR(TO_DATE('870124', 'YYMMDD'), 'YYYY-MM-DD') -- ���: 2087-01-24
SELECT TO_CHAR(TO_DATE('870124', 'RRMMDD'), 'YYYY-MM-DD')   -- 50�� �̸��̸� 20xx, 50�� �̻��̸� 19xx���� ��ȯ
FROM DUAL;
-- =============================================================================
/*
    * TO_NUMBER: ���� Ÿ���� �����͸� ���� Ÿ������ ��ȯ���ִ� �Լ�
    
    TO_NUMBER(����_������ [����])
*/
SELECT TO_NUMBER('12345678') FROM DUAL;

SELECT '100000' + '55000' FROM DUAL;    -- 155000 (O) ? 10000055000 ?
SELECT '100,000' + '55,000' FROM DUAL;  -- ���� ����;
SELECT TO_NUMBER('100,000', '999,999') + TO_NUMBER('55,000', '999,999') FROM DUAL;
-- =============================================================================
/*
    * NULL ó�� �Լ� : ������ ���� null�� ��� ó�����ִ� �Լ�
*/
-- NVL : null �� ������ ���� �ٸ� ������ ǥ�����ִ� �Լ�
--  NVL(�÷�, NULL�� ��� ǥ���� ������(��))
SELECT EMP_NAME, SALARY, NVL(BONUS, 0) "BONUS" FROM EMPLOYEE;
--  ������, ���ʽ� ���� ���� ��ȸ (���ʽ��� ���� ��쿡�� �⺻ �������� ��ȸ)
SELECT EMP_NAME "������", TO_CHAR((SALARY+(SALARY* NVL(BONUS, 0)))*12, 'L999,999,999') "���ʽ� ���� ����"
FROM EMPLOYEE;

-- ������, �μ��ڵ� ��ȸ (�μ���ġ���� ���� ������ "�μ�����"���� ǥ���ϵ��� ��ȸ)
SELECT EMP_NAME "������", NVL(DEPT_CODE, '�μ�����') "�μ��ڵ�" FROM EMPLOYEE;

-- NVL2 : �ش� �÷��� ���� ���� ��� A ��� ���� ǥ���ϰ�,
--                  ���� ���� ���(null�� ���) B��� ���� ǥ�����ִ� �Լ�
--      NVL2(�÷�, A, B)
SELECT EMP_NAME, SALARY, NVL2(BONUS, 'O', 'X') "���ʽ� ����" FROM EMPLOYEE;

SELECT EMP_NAME "������", NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') "�μ���������" FROM EXPLOYEE;

-- NULLIF : �� �� ����� ���� ��ġ�ϸ� NULL�� ��ȯ�ϰ�, ��ġ���� ������ ù��° �׸�(�񱳴��1)�� ��ȯ
--  NULLIF(�񱳴��1, �񱳴��2)
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;
-- =============================================================================
/*
    * ���� �Լ�
        - DECODE(�񱳴�� �÷�_������, �񱳰�1, �����1, �񱳰�2, �����2, ... )
        
        switch(�񱳴��) {
            case �񱳰�1:
                �����ڵ�;
            case �񱳰�2:
                �����ڵ�;
*/
SELECT EMP_ID "���", EMP_NAME "�̸�", EMP_NO "�ֹι�ȣ",
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��', '�ܰ���') "����"
FROM EMPLOYEE;

-- ������ �޿� ��ȸ �� �μ����� ���ʽ��� �߰��Ͽ� ���� ��ȸ
-- D1 : ���ʽ� + 0.05
-- D2 : ���ʽ� + 0.03
-- D5 : ���ʽ� + 0.02
-- �� �� : �״�� ����
SELECT  EMP_NAME "������", DEPT_CODE "�μ��ڵ�",
        (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���� ���ʽ� ���� ����",
        (SALARY + (SALARY * (NVL(BONUS, 0)))) + DECODE(DEPT_CODE, 'D1', (SALARY+(SALARY*(NVL(BONUS,0)+0.05)))*12, 'D2', (SALARY+(SALARY*(NVL(BONUS,0)+0.03)))*12, 'D5', (SALARY+(SALARY*(NVL(BONUS,0)+0.02)))*12) "����"
FROM EMPLOYEE;
/*
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
        ELSE �����N
    END
    
    => �ڹٿ��� if ~ else �� ����
*/
-- ���� ���� ���� 500���� �̻� "����", 350���� �̻� "�߱�", �� ���ϴ� "�ʱ�" ��ȸ
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') "����";
-- =============================================================================
/*
    * �׷� �Լ� : N�� ���� ���޹޾� 1���� ����� ��ȯ���ִ� �Լ�
*/
-- 1) SUM(����Ÿ�����÷�) : �ش� ������ �� ���� ���Ͽ� ��ȯ���ִ� �Լ�
--  * �������� �� �޿�
SELECT SUM(SALARY) FROM EMPLOYEE;
--  * ������������ �� �޿�
SELECT SUM(SALARY) FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');
--  * ����� ������� �� �޿� (JOB_CODE: J5)
SELECT SUM(SALARY) FROM EMPLOYEE
WHERE JOB_CODE = 'J5';

-- 2) AVG(����Ÿ�����÷�) : �ش� ������ ����� ���Ͽ� ��ȯ���ִ� �Լ�
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;

-- 3) �ִ� (MAX) / �ּ� (MIN)
--   MAX(��� Ÿ�� ����),  MIN(��� Ÿ�� ����)
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)   -- EMP_NAME(����), SALARY(����), HIRE_DATE(��¥)
FROM EMPLOYEE;

SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 4) COUNT(*|�÷�|DISTINCT �÷�) : �ش� ���ǿ� �´� ���� ������ ��ȯ���ִ� �Լ�
-- ��ü ��� ��
SELECT COUNT(*) FROM EMPLOYEE;
-- ���� ��� ��
SELECT COUNT(*) FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
-- ���ʽ��� ���� ���� ��
SELECT COUNT(*) FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- ���� ������� �� ��� �μ��� �����Ǿ��� �� ��ȸ
SELECT COUNT (DISTINCT DEPT_CODE) FROM EMPLOYEE; -- ������ �� �� null�� ���ܵ�