/*
	<SELECT> ������ ��ȸ �� ����ϴ� ����
	
	SELECT ������ �� ���� FROM ���̺�
	SELECT �÷�1, �÷�2, �÷�3 FROM ���̺�
	SELECT * FROM ���̺�  -- ���̺��� �ִ� ��� ����(������) ��ȸ
*/

-- EMPLOYEE : ����(���)�� ���� ������ ����(�׷�)

-- ��� ����� ������ ��ȸ
SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�(EMP_NAME), �ֹι�ȣ(EMP_NO), �ڵ�����ȣ(PHONE) ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;
------------------------------------------------------------------------------------
-- JOB : ���޿� ���� ������ ����

-- ��� ������ ������ ��ȸ
SELECT * FROM JOB;

-- ��� ������ ���޸�(JOB_NAME) �÷��� ��ȸ
SELECT JOB_NAME FROM JOB;
-------------------------------------------------------------------------------------
-- DEPARTMENT : �μ��� ���� ������ ����

-- ��� �μ��� ������ ��ȸ
SELECT * FROM DEPARTMENT;

-- ��� �μ��� �μ��ڵ�(DEPT_ID), �μ���(DEPT_TITLE) ��ȸ
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
--------------------------------------------------------------------------------------
-- ������ �����, �̸���, ����ó, �Ի��� �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY 
FROM EMPLOYEE;
/*

*/
-- ���� ���̺��� �����, ����� �޿�, ����� ����(�޿� * 12) ��ȸ
SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- ����� ���� ����*(���ʽ� ���� ����) ��ȸ
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, (SALARY + ( SALARY * BONUS)) * 12
FROM EMPLOYEE;

-- �����, �Ի���, �ٹ��ϼ��� ��ȸ
-- * ��ȸ �� ��¥�� ǥ���ϴ� ��� : SYSDATE (��/��/��/��/��/��)
--   DATE_Ÿ����_�� = DATE_Ÿ���� �� �� ���� ���� �ϰ� ǥ��
SELECT EMP_NAME, HIRE_DATE,  SYSDATE - HIRE_DATE
FROM EMPLOYEE;

-- ���� ��¥ �� �ð� ��ȸ
-- * DUAL : ����Ŭ���� �������ִ� ���� ������ ���̺�(���� ������)
SELECT SYSDATE FROM DUAL;

/*
    <�÷����� ��Ī ��Ī�ϱ�>
    : ��� ���� �� �÷����� �������� ���̴µ�, �̹� �÷����� ��Ī�� �ο��ϸ� ����ϰ�
      ǥ���� �� ����.
      
      [ǥ����]
       * �÷��� ��Ī
       * �÷��� as ��Ī
       * �÷��� "��Ī"
       * �÷��� as "��Ī"
       
       - ��Ī�� ���� �Ǵ� Ư������ ������ �� ū����ǥ("")�� ��� ǥ����
*/
-- ���� ���� ��ȸ : �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME �����, SALARY as �޿�, BONUS "���ʽ�", (SALARY * 12) as "����",
(SALARY + (SALARY*BONUS)) * 12 as "���ʽ� ���� ����"
FROM EMPLOYEE;

/*
    <���ͷ�> : �� ��ü
    - ���Ƿ� ������ ���ڿ�('')
    - ��ȸ�� RESULT SET(���â)�� ��� �࿡ �ݺ������� ���
*/
-- ���� ���� ��ȸ : ���, �����, �޿�
SELECT EMP_ID, EMP_NAME, SALARY, '��' as "����"
FROM EMPLOYEE;

/*
    <���� ������> : ||
    - ���� �÷� ������ �ϳ��� �÷�ó�� ������ �� ����
*/
-- ���� ���� ��ȸ : ���, �����, �޿�
SELECT EMP_ID, EMP_NAME, SALARY || '��' as "�޿�"
FROM EMPLOYEE;

-- ���, �̸�, �޿��� �ϳ��� �÷�ó�� ��ȸ
SELECT EMP_ID || ' ' || EMP_NAME || ' ' || SALARY || '��' as "��������"
FROM EMPLOYEE;

-- xxx�� ������ xxx�� �Դϴ�. ��µǵ��� ��ȸ.
--  * �����, �޿�
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' as "���� �� �޿� ����"
FROM EMPLOYEE;


/*
    <�ߺ� ����> : DISTINCT
    - �÷��� ǥ�õǴ� ������ �ѹ����� ��ȸ�ϰ��� �� �� ���
*/

-- ���� �������� �����ڵ带 �ߺ� ���� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- ���� �������� �μ��ڵ带 �ߺ� ���� ��ȸ
SELECT * FROM EMPLOYEE;

-- ===========================================================================

/*
    <IS NULL * IS NOT NULL>
    : �÷����� NULL�� ���� ��� NULL ���� ���ϱ� ���� ���
*/
-- [java] str == null / str = null (x) / [oracle] str is null (0)
-- ���ʽ��� ���� ���� (bonus is null ������� ���, �̸�, �޿�, ���ʽ� ��ȸ
-- ������ ��ȸ ���� (1) -> (2) -> (3)
select emp_id, emp_name, salary, bonus -- (3)
FROM EMPLOYEE           -- (1)
WHERE bonus is null;    -- (2)
-- ���ʽ��� ���� ������� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT emp_id, emp_name, salary, bonus
FROM EMPLOYEE
WHERE bonus is not null;

-- ����� ���� ������ �����, ��� ���, �μ��ڵ� ��ȸ
select emp_name, manager_id, dept_code
from employee
where manager_id is null;
-- �μ��� ��ġ���� ���� ������ ����̸�, �޿�, ���ʽ� ��ȸ
select emp_name, salary, bonus
from employee
where dept_code is null;
-- =============================================================================
/*
    ������ �켱���� : ���� ���� �����ڰ� ����� �� �켱������ ���� ������� ����Ǵ� ���
    
    1. ��� ������ : + - * /
    2. ���� ������ : ||
    3. �� ������ : < > <= >= = != ^= <>
    4. IS NULL / LIKE / IN
    5. BETWEEN ���� AND ��
    6. NOT
    7. AND
    8. OR
*/
-- �����ڵ尡 J7�̰ų� J2�� ��� �߿� �޿��� 200���� �̻��� ������� ��� ������ ��ȸ
select *
from employee
where (job_code = 'J7' or job_code = 'J2') and salary >= 2000000;
-- ======================== �ǽ� ���� ===========================================
-- 1. ����� ���� �μ� ��ġ�� ���� ���� ����� �����, ���, �μ��ڵ� ��ȸ
select emp_name, emp_id, dept_code
from employee
where manager_id is null and dept_code is null;
-- 2. ����(���ʽ� ������)�� 3õ���� �̻��̰� ���ʽ��� ���� ���� ������� ���, �����, �޿�, ���ʽ� ��ȸ
select emp_id, emp_name, salary, bonus
from employee
where salary*12 >= 30000000 and bonus is null;
-- 3. �Ի����� '95/01/01' �����̰� �μ���ġ�� ���� ���� ������� ���, �����, �Ի���, �μ��ڵ� ��ȸ
select emp_id, emp_name, hire_date, dept_code
from employee
where hire_date >= '95/01/01' and dept_code is null;
-- 4. �޿��� 200���� �̻�, 500���� ������ ��� �� �Ի����� '01/01/01' �����̰�
--    ���ʽ��� �������� ������� ���, �����, �޿�, �Ի���, ���ʽ� ��ȸ
select emp_id, emp_name, salary, hire_date, bonus
from employee
where salary between 2000000 and 5000000 and hire_date >= '01/01/01' and bonus is null;
-- 5. ���ʽ� ���Ե� ������ NULL�� �ƴϰ� �̸��� '��'�� ���Ե� ������� ���, �����, �޿�, ���ʽ� ���� ���� ��ȸ
select emp_id, emp_name, (salary+(bonus*salary))*12
from employee
where (salary+(bonus*salary))*12 is not null and emp_name like '%��%';
-- =============================================================================
/*
    <ORDER BY> : ���� ���õ� ����.
                 SELECT��
                 ���� ���� ���� �������� ����.
                 
    [ǥ����]
            SELECT �÷�1, �÷�2, ...
            FROM ���̺�
            WHERE ���ǽ�
            ORDER BY �������÷� | ��Ī | �÷����� [ASC | DESC] [NULLS FORST | NULLS LAST]
            
            * ASC : �������� (�⺻ ������ ���� ���)
            * DESC : ��������
            
            * NULLS FIRST : �����Ϸ� �ϴ� ������ ���� �� null �� ���� �ش� ������ �� �տ� ��ġ
                            DESC (��������) �⺻ ��
            * NULLS LAST  : �����Ϸ� �ϴ� ������ ���� �� null �� ���� �ش� ������ �� �ڿ� ��ġ
                           ASC (��������) �⺻ ��
                           
            ex) ORDER BY NAME;  -- ASC(��������), NULLS LAST �� ����� ����!
*/
-- ���� ���̺����� ��ü ������ ��ȸ
SELECT * FROM EMPLOYEE
-- ORDER BY EMP_NAME; -- ���������� �������� ���� (ASC ����!)
-- ORDER BY EMP_NAME DESC; -- ���������� �������� ����
-- ORDER BY BONUS ASC NULLS FIRST; -- ���ʽ� �������� NULL�� �׸��� �� ���� ��ġ�ǵ��� �������� ����
-- ORDER BY BONUS; -- ���ʽ� �������� NULL�� �׸��� �� �ڷ� ��ġ�Ͽ� �������� ����
ORDER BY BONUS DESC, SALARY ASC; -- ���ʽ� �������� �������� �����ϰ�, �޿� �������� �������� ����

-- �� ����� �����, ���� ��ȸ (���� �� �������� ����)
SELECT EMP_NAME "�����", SALARY * 12 "����"
FROM EMPLOYEE
-- ORDER BY SALARY * 12 DESC;
-- ORDER BY ���� DESC;
ORDER BY ���� DESC;
