/*
    * �������� (SUBQUERY)
    : �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
      ���� SQL���� ���� ������ �ϴ� ������
      
      * SQL�� = SELECT�� = ������ 
*/
-- ���ö ����� ���� �μ��� ������� ��ȸ
-- * ���ö ��� ���� ��ȸ
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '���ö';

-- * �μ��ڵ尡 'D9'�� ��� ���� ��ȸ
SELECT *FROM EMPLOYEE WHERE DEPT_CODE =  'D9';

-- * �� ������ �����غ���.
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE              
                    WHERE EMP_NAME = '���ö'
                  );
-- �� ������ ��� �޿����� �� ���� �޿��� �޴� ���� ��ȸ
-- * �� ���� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;        -- 3,047,663

SELECT * FROM EMPLOYEE WHERE SALARY > 3047663;

-- * �� �������� �����غ���.
SELECT * FROM EMPLOYEE WHERE SALARY > ( -- SALARY > ��� �޿�
                                        SELECT ROUND(AVG(SALARY))
                                        FROM EMPLOYEE
                                    );
--------------------------------------------------------------------------------
/*
    * ���������� ����
     : ���������� ������ ������� ���� ��� �����Ŀ� ���� �з�
     
     - ������ �������� : ���������� ��ȸ ����� 1�� + ��, �� : 1��
     - ������ �������� : ���������� ��ȸ ����� ���� ��(��) + ���� 1��
     - ���߿� �������� : ���������� ��ȸ ����� �� ���̰�, �÷��� ���� ���� ��
     - ������ ���߿� �������� : ���������� ��ȸ ����� ���� ���̰�, ���� ��(Į���� ���� ��)�� ��
     
     >> �������� ������ ���� �տ� ���Ǵ� �����ڰ� �޶���.
     
*/
/*
    - ������ �������� : �������� ��� ���� 1���� ��� 1�� 1��)
      + �Ϲ� �񱳿����� ��� ����
        : = != > <= ...
*/
-- ��� �޿����� ���� ������ �̸�, ����ó, �޿� ��ȸ
--  * ��� �޿�
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;
--  * ����
SELECT EMP_NAME "�̸�", PHONE "����ó", SALARY "�޿�"
FROM EMPLOYEE
WHERE SALARY < (
                SELECT ROUND(AVG(SALARY))
                FROM EMPLOYEE
               );
               
-- ���� �޿��� �޴� ���� ���� ��ȸ (�̸�, ����ó �޿�)
--  * ���� �޿�
SELECT EMP_NAME "�̸�", PHONE "����ó", SALARY "�޿�"
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- ���ö ����� �޿����� ���� �޴� ����� ���, �̸�, �μ���, �޿� ��ȸ
-- ORACLE ����
SELECT EMP_ID "���", EMP_NAME "�̸�", DEPT_TITLE "�μ���", SALARY "�޿�"
FROM EMPLOYEE
WHERE DEPT_CODE = DEPT_ID
        AND SALARY > ( 
                        SELECT SALARY FROM EMPLOYEE
                        WHERE EMP_NAME = '���ö'
                     );
                     
-- ANSI ����
SELECT EMP_ID "���", EMP_NAME "�̸�", DEPT_TITLE "�μ���", SALARY "�޿�"
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    AND SALARY> (
                    SELECT SALARY FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö'
                );
-- GROUP BY ����
-- * �μ� �� �޿� ���� ���� ū ������ �μ��ڵ�, �޿� �� ��ȸ
--  * �μ� �� �޿� �� �߿��� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--  + �μ��� �޿� ���� 17,700,000dls �μ��� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CORE
HAVING SUM(SALARY) = 17700000;

--  + �����غ���.
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CORE
HAVING SUM(SALARY) = (
                        SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE
                    );
--------------------------------------------------------------------------------
/*
    * ������ ��������
      : �������� ������ ����� ���� ���� �� (���� 1��)  -  N�� 1���� �Ѱ�
      
      IN (��������) : ���� ���� ��� �� �ϳ��� ��ġ�ϸ� ��ȸ
      
      > ANY (��������) : ���� ���� ��� �� �ϳ��� Ŭ ��� ��ȸ
      < ANY (��������) : ���� ���� �Ѱ� �� �ϳ��� ���� ��� ��ȸ
      
      �� ��� > ANY ((�������� �Ѱ� �� - ��1, ��2, ��3))
      -> �� ��� > ��1 OR �� ��� > ��2 OR �� ��� > ��3
*/
-- ����� �Ǵ� ������ ����� ���� ������ ������� ���, �̸�, �����ڵ� �޿� ��ȸ
--  * ����� �Ǵ� ������ ����� �۱��ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('���缮', '������');

--  * ����
SELECT EMP_ID "���", EMP_NAME "�̸�", JOB_CODE "�����ڵ�", SALARY "�޿�"
FROM EMPLOYEE
WHERE JOB_CODE IN (
                SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('���缮', '������')
                  );
-- �븮 ������ ����� �� ���� ������ �ּ� �޿����� ���� �޴� ������� ���, �̸�, ���޸�, �޿��� ��ȸ
--  * ���� ������ �޿� ��ȸ
SELECT SALARY "�޿�"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';
--  * ����
SELECT EMP_ID "���", EMP_NAME "�̸�", JOB_NAME "���޸�", SALARY "�޿�"
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮' 
        AND SALARY > ANY (
                SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '����'
             );
--------------------------------------------------------------------------------
/*
    * ���߿� �������� : ��� ���� �� ���̰�, ���� ���� �÷�(��)�� ��� -- 1�� N��
*/
--  ������ ����� ���� �μ��ڵ�, ���� �����ڵ带 ���� ����� ��ȸ
--  * ������ ����� �μ��ڵ�, �����ڵ� ��ȸ
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������'; -- D5, J5

--  * ������ �������� ��� ��
SELECT EMP_ID "���", EMP_NAME "�̸�", HIRE_DATE "�Ի���"
FROM EMPLOYEE
-- �μ��ڵ�� �����ڵ带 ���� ���� �� ���� ������ ����Ͽ� ��ȸ
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');

-- * ������ �������� ���    
SELECT EMP_ID "���", EMP_NAME "�̸�", HIRE_DATE "�Ի���"
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
                                SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������'
                               )
    AND EMP_NAME != '������';
--------------------------------------------------------------------------------
/*
    * ������ ���߿� �������� : N�� N�� ���
*/
-- �� ���޺� �ּ� �޿��� �޴� ��� ��ȸ
--  * ���� �� �ּ� �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
/*
    J1	8000000
    J2	3700000
    J4	1550000
    J3	3400000
    J7	1380000
    J5	2200000
    J6	2000000
*/
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' AND SALARY = 9000000
    OR JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J4' AND SALARY = 1550000
;
    
    
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
                            SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE
                            );
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE;
-- �� �μ����� �ְ� �޿��� �޴� �������� ���, �����, �μ��ڵ�, �޿� ��ȸ
--  * �μ��� �ְ� �޿� ��ȸ
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--  * ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_CODE "�μ� �ڵ�", SALARY "�޿�"
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (
                              SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE
                              );
--------------------------------------------------------------------------------
/*
    * �ζ��� ��
        - FROM ���� ���������� �ۼ��� ��
        - ���������� ������ ����� �ϳ��� ���̺��� ���
        
        - ROWNUM : ����Ŭ���� �������ִ� �÷� ��ȸ�� �������
*/
-- ������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ� ��ȸ
--  ��, ���ʽ� ���� ������ NULL�� �Ǹ� �ȵȴ�. -- NVL ����÷�|�����|�Լ���, NULL_��_���_�����_��)
--  ��, ���ʽ� ���� ������ 3000���� �̻��� ����� ��ȸ�Ѵ�.
SELECT EMP_ID "���", EMP_NAME "�̸�", (SALARY + (SALARY*NVL(BONUS, 0)))*12 "���ʽ� ���� ����",
            DEPT_CODE "�μ��ڵ�"
FROM EMPLOYEE
WHERE (SALARY + (SALARY*NVL(BONUS,0)))*12 >= 30000000
ORDER BY 3 DESC;
-- =>> TOP-N �м� : ���� N���� ��ȸ 
SELECT ROWNUM, ���, �̸�, ����, �μ��ڵ�
FROM (  -- ���� ���� �������� ������ ����� �ϳ��� ���̺��� ���
        SELECT EMP_ID "���", EMP_NAME "�̸�", (SALARY + (SALARY*NVL(BONUS,0)))*12 "����",
                    DEPT_CODE "�μ��ڵ�"
        FROM EMPLOYEE
        WHERE (SALARY + (SALARY*NVL(BONUS,0)))*12 >= 30000000
        ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ
--  * �Ի��� �������� ����
--  * rownum �÷� ����Ͽ� 5���� �߷�����.
SELECT ROWNUM, EMP_ID, EMP_NAME, �Ի���
FROM(
        SELECT EMP_ID, EMP_NAME, HIRE_DATE "�Ի���"
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;
--------------------------------------------------------------------------------
/*
    * ������ �ű�� �Լ� (WINDOW FUNCTION)
        - RANK() OVER(���� ����) : ������ ���� ������ ����� �� ������ŭ �ǳʶٰ� ���� ���
          ex) ���� 3�� 2��, �� ���� ������ 5
        - DENSE RANK() OVER(���� ����) : ������ ���� ���Ŀ� ������ 1�� �����Ͽ� ���� ���
          ex) ���� 3�� 2��, �� ���� ������ 4
          
        + SELECT�������� ��� ����!
*/
-- �޿��� ���� �������� ������ �Űܼ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE
WHERE ���� <= 5;      -- ��Ī=>WHERE������ ��� �Ұ�..

SELECT *
FROM (
    -- ���� ������ ��� "����"��� ��Ī�� �ϳ��� �÷����� ���� ������������ ����� �� ����.
    SELECT EMP_ID, EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
    FROM EMPLOYEE
)
WHERE ���� <= 5;

SELECT DEPT_CODE, SUM(SALARY) AS "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) AS �ο���
FROM EMPLOYEE           --1
GROUP BY DEPT_CODE      --3
HAVING AVG(SALARY) > 2700000
ORDER BY DEPT_CODE ASC;

SELECT DEPT_CODE, SUM(SALARY) AS "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) AS �ο���
FROM EMPLOYEE           --1
WHERE SALARY > 2700000  --2
GROUP BY DEPT_CODE      --3
ORDER BY DEPT_CODE ASC;