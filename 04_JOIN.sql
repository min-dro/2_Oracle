/*
    * JOIN
    : �� �� �̻��� ���̺����� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� ����
      ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
      
    : ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺��� ��� ����
      (�ߺ� ������ �ּ�ȭ�ϱ� ���ؼ� �ִ��� �ɰ��� ������)
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� "����"�� �δ� ���
    (������ �� ��ȸ�� �ϴ� �� �ƴ϶� �� ���̺��� ���� �����μ��� �����͸� ��Ī���Ѽ� ��ȸ�ؾ� ��!)
    
    -JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ)
    
    [JOIN ��� ����]
    
            ����Ŭ ���� ����               |               ANSI ����
    ---------------------------------------------------------------------------------------
            �����(�����(EQUAL JOIN)  |           �������� (INNER JOIN)=> JOIN USING/ON
    ---------------------------------------------------------------------------------------
            ��������                      |     ���� �ܺ� ���� (LEFT OUTER JOIN)
        ( LEFT OUTER )                   |     ������ �ܺ� ���� (RIGHT OUTER JOIN)
        ( RIGHT OUTER )                  |     ��ü �ܺ� ���� (FU:: OUTER JOIN)
    ---------------------------------------------------------------------------------------
            ��ü����  (SELF JOIN)         |             JOIN ON
        �� ����  (NON EQUAL)          |
    ----------------------------------------------------------------------------------------
*/
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸��� ��ȸ
SELECT JOB_CODE, JOB_NAME
FROM JOB;
/*
    1. � ���� (EQUAL JOIN / �������� (INNER JOIN)
        : �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ(=> ��ġ���� �ʴ� ���� ����)
*/

-- ����Ŭ ���� ����: �����(EQUAL JOIN)
--  FROM���� ��ȸ�ϰ����ϴ� ���̺����� ���� (, ���..)
--  WHERE���� ������������� �ϴ� �÷��� ���� ������ ����

--  1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE: DEPT_CODE / DEPARTMENT: DEPT_ID)
--  ���, �����, �μ��ڵ�, �μ��� ��ȸ (�μ� ��ġ�� ���� ���� ������ ��ȸ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- => null, D3, D4, D7 �����ʹ� ��ȸ���� ���� ���� Ȯ���� �� ����. => ��ġ�ϴ� ���� ���� ������

--  2) ������ �� �÷����� ���� ��� (EMPLOYEE: JOB_CODE / JOB: JOB_CODE)
--  ���, �����, �����ڵ�, ���޸� ��ȸ
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- * ��Ī�� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- =============================
-- ANSI ����
-- FROM���� ������ �Ǵ� ���̺� �ϳ� ���
-- JOIN���� �����ϰ����ϴ� ���̺� ��� + ����������� �÷��� ���� �κ� ���
-- * JOIN USING / JOIN ON

-- 1) ���� ���� ������ �ϴ� "�÷��� �ٸ� ���" => JOIN ON ������ ���
-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ���� ���� ������ �ϴ� "�÷��� ���� ���" => JOIN USING ���� (JOIN ON�� ����)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);      -- JOIN USING: �����ϴ� �÷��� ���� ���� ��밡��.

-- �߰����� ���� ���õ� ����.
-- ������ "�븮"�� ������ ��ȸ
--  ANSI rnans
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

-- Oracle ���� ����
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮';
--------------------------------------------------------------------------------
-- ���� -------------------------------------------------------------------------
--  (Oracle ���� ����, ANSI ����)
-- 1) �μ��� "�λ������"��  ������� ���, �̸�, ���ʽ� ��ȸ
--   * Oracle ���� ����
--   �μ� ���� (DEPARTMENT), ���� ���� (EMPLOYEE)
SELECT EMP_NO "���", EMP_NAME "�̸�", BONUS "���ʽ�"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE  = DEPT_ID              -- ���� ���� ���� �÷� 
        AND DEPT_TITLE = '�λ������';   -- �߰� ���� (�λ������)
        
--   * ANSI ���� : �÷����� �ٸ� ��� => JOIN ~ ON ���
SELECT EMP_NO "���", EMP_NAME "�̸�", BONUS "���ʽ�"
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- 2) �μ� ���̺�(DEPARTMENT)�� LOCATION���̺��� �����Ͽ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
--   * Oracle ���� ����
SELECT DEPT_ID "�μ��ڵ�", DEPT_TITLE "�μ���", LOCAL_CODE "�����ڵ�", LOCAL_NAME "������"
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

--   * ANSI ���� : �÷����� �ٸ� ��� ( JOIN ~ ON )
SELECT DEPT_ID "�μ��ڵ�", DEPT_TITLE "�μ���", LOCAL_CODE "�����ڵ�", LOCAL_NAME "������"
FROM DEPARTMENT     -- ������ �Ǵ� ���̺�: �μ�(DEPARTMENT)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- 3)���ʽ��� ���� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
--   * Oracle ���� ����
SELECT EMP_ID "���", EMP_NAME "�����", BONUS "���ʽ�", DEPT_TITLE "�μ���"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
        AND BONUS IS NOT NULL;
--   * ANSI ���� : JOIN ~ ON
SELECT EMP_ID "���", EMP_NAME "�����", BONUS "���ʽ�", DEPT_TITLE "�μ���"
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4) �μ��� "�ѹ���"�� �ƴ� ������� �����, �޿� ��ȸ
--   * Oracle ���� ����
SELECT EMP_NAME "�����", SALARY "�޿�" --, DEPT_TITLE "�μ���" -- Ȯ�ο�
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID   -- �� ���̺� ���� 
        AND DEPT_TITLE != '�ѹ���'; -- != | ^= | <> : �ٸ��� üũ�� �� ����ϴ� ������ 

--   * ANSI ����
SELECT EMP_NAME "�����", SALARY "�޿�", DEPT_TITLE "�μ���"
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���'; 
--------------------------------------------------------------------------------
/*
    2. ���� ���� / �ܺ� ���� (OUTER JOIN)
    : �� ���̺��� JOIN�� �� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ
      ��, LEFT | RIGHT�� ��������� ��. (������ �Ǵ� ���̺��� ����.)
*/
-- �(����) �������� ��ȸ.
--  �����, �μ���, �޿�, ���� ��ȸ (21�� ��ȸ) => 2���� ���ܵ�! (�μ���ġ�� ������ ����)
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", SALARY "�޿�", SALART * 12 "����"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- [1] LEFT [OUTER] JOIN : �� ���̺� �� ������ �ִ� ���̺��� �������� JOIN
-- ����Ŭ ����
-- �μ���ġ�� ���� ���� ������ ��ȸ�� ��
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", SALARY "�޿�", SALARY * 12 "����"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);   -- ������ ���� ���� �� ����(EMPLOYEE)�� �ִ� �����͸� �����Ͽ� ��ȸ��

-- ANSI ����
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", SALARY "�޿�", SALARY * 12 "����"
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- [2] RIGHT [OUTER] JOIN : �� ���̺� �� �������� �ִ� ���̺��� �������� JOIN
SELECT COUNT(*) FROM EMPLOYEE;
-- ����Ŭ ����
--  �μ� ���� ������ ���� ��쵵 ��ȸ�� ��
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", SALARY "�޿�", SALARY * 12 "����"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- ANSI ����
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", SALARY "�޿�", SALARY * 12 "����"
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- [3] FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ (����Ŭ ���� ����X ANSI ������ ����!)
-- ANSI ����
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", SALARY "�޿�", SALARY * 12 "����"
FROM EMPLOYEE FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--------------------------------------------------------------------------------
/*
    3. �� ���� (NON EQUAL JOIN)
        : ���� ���� ���� �ϴ� �÷��� ���� ���ǽĿ� '='�� ������� ����.
            ANSI ���������� ON�� ���.
*/
-- �����, �޿�, �޿����� ��ȸ
SELECT * FROM EMPLOYEE;          -- �޿�
SELECT * FROM SAL_GRADE;        -- �޿�����
-- ����Ŭ ����
SELECT EMP_NAME "�����", SALARY "�޿�", SAL_LEVEL "�޿�����", MIN_SAL, MAX_SAL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI ���� : JOIN ~ ON ���
SELECT EMP_NAME "�����", SALARY "�޿�", SAL_LEVEL "�޿�����"
FROM EMPLOYEE JOIN SAL_GRADE -- ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);
ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
-- ������ �޿� ������ �޿� ���� ������ ���ϴ� ���� �������� ����.
--------------------------------------------------------------------------------
/*
    4. ��ü ���� (SELE JOIN)
      : ���� ���̺��� �ٽ� �� �� �����ϴ� ���
*/
-- ��ü ����� ���, �����, �μ��ڵ�
--             ��� ���, ��� �����, ��� �μ��ڵ� ��ȸ
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
            E.MANAGER_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M         -- E : ���� ���� ��ȸ�ϱ� ���� EMPLOYEE
                                    -- M : ������� ���� ��ȸ�ϱ� ���� EMPLOYEE
WHERE E.MANAGER_ID = M.EMP_ID;
-- WHERE E.MANAGER_ID = M.EMP_ID(+);  -- ����� ���� ������ ��ȸ�Ѵٸ�, OUTER JOIN ����
--  ANSI ����
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
            E.MANAGER_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
-- LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);   -- ����� ���� ���� ��ȸ ��
--------------------------------------------------------------------------------
/*
    5. ���� JOIN : 2�� �̻��� ���̺��� JOIN.
*/
-- ���, �����, �μ���, ���޸� ��ȸ
-- Oracle ����
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID            -- EMPLOYEE ���̺��� DEPARTMENT ���̺� ����
        AND E.JOB_CODE = J.JOB_CODE;        -- EMPLOYEE ���̺��� JOB ���̺� ����
        
-- ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-- ���, �����, �μ���, ������ ��ȸ : ����(EMPLOYEE), �μ�(DEPARTENT), ����(LOCATION)
--  ORACLE ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", LOCAL_NAME "������"
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

--  ANSI ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", LOCAL_NAME "������"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
--------------------------------------------------------------------------------
------------------------------ �ǽ� ���� ----------------------------------------
-- 1. ���, �����, �μ���, ������, ������ ��ȸ
--      (EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL)
--      ORACLE ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", LOCAL_NAME "������", 
            NATIONAL_NAME "������"
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID   -- EMPLOYEE - DEPARTMENT ���� 
        AND LOCATION_ID = LOCAL_CODE    -- DEPARTMENT - LOCATION ����
            AND L.NATIONAL_CODE = N.NATIONAL_CODE;      -- LOCATION - NATIONAL ����

-- ANSI ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", NATIONAL_NAME "������",
            NATIONAL_NAME "������"
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)    -- EMPLOYEE - DEPARTMENT ����
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE) -- DEPARTMENT - LOCATION ����
    JOIN NATIONAL USING(NATIONAL_CODE);         -- LOCATION - NATIONAL ����

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �޿� ��� ��ȸ
--    (EMPLOYEE, DEPARTMENT, JOB, LOCATION, NATIONAL, SAL_GRADE)
--  ORACLE ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", JOB_NAME "���޸�",
        LOCAL_NAME "������", NATIONAL_NAME "������", SAL_LEVEL "�޿� ���"
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID           -- ENOLOYEE - DEPARTMENT ����
        AND E.JOB_CODE = J.JOB_CODE -- EMPLOYEE - JOB ����
        AND LOCATION_ID = LOCAL_CODE    -- DEPARTMENT - LOCATION ����
        AND L.NATIONAL_CODE = N.NATIONAL_CODE   -- LOCATION - NATIONAL ����
        AND SALARY BETWEEN MIN_SAL AND MAX_SAL;  -- EMPLOYEE - SAL_GRADE ���� 

--  ANSI ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", JOB_NAME "���޸�",
        LOCAL_NAME "������", NATIONAL_NAME "������", SAL_LEVEL "�޿� ���"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)            -- EMPLOYEE - DEPARTMENT ����    
JOIN JOB USING(JOB_CODE)                            -- EMPLOYEE - JOB ����
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)         -- DEPARTMENT - LOCATION ����
JOIN NATIONAL USING(NATIONAL_CODE)                  -- LOCATION - NATIONAL ����
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL); -- EMPLOYEE -SAL_GRADE ����