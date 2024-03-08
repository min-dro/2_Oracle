/*
	<SELECT> 데이터 조회 시 사용하는 문법
	
	SELECT 가지고 올 정보 FROM 테이블
	SELECT 컬럼1, 컬럼2, 컬럼3 FROM 테이블
	SELECT * FROM 테이블  -- 테이블에 있는 모든 정보(데이터) 조회
*/

-- EMPLOYEE : 직원(사원)에 대한 데이터 묶음(그룹)

-- 모든 사원의 정보를 조회
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름(EMP_NAME), 주민번호(EMP_NO), 핸드폰번호(PHONE) 조회
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;
------------------------------------------------------------------------------------
-- JOB : 직급에 대한 데이터 묶음

-- 모든 직급의 정보를 조회
SELECT * FROM JOB;

-- 모든 직급의 직급명(JOB_NAME) 컬럼만 조회
SELECT JOB_NAME FROM JOB;
-------------------------------------------------------------------------------------
-- DEPARTMENT : 부서에 대한 데이터 묶음

-- 모든 부서의 정보를 조회
SELECT * FROM DEPARTMENT;

-- 모든 부서의 부서코드(DEPT_ID), 부서명(DEPT_TITLE) 조회
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
--------------------------------------------------------------------------------------
-- 직원의 사원명, 이메일, 연락처, 입사일 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY 
FROM EMPLOYEE;
/*

*/
-- 직원 테이블의 사원명, 사원의 급여, 사원의 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- 사원의 연봉 정보*(보너스 포함 연봉) 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, (SALARY + ( SALARY * BONUS)) * 12
FROM EMPLOYEE;

-- 사원명, 입사일, 근무일수를 조회
-- * 조회 시 날짜를 표시하는 상수 : SYSDATE (년/월/일/시/분/초)
--   DATE_타입의_값 = DATE_타입의 값 의 열과 값을 일괄 표시
SELECT EMP_NAME, HIRE_DATE,  SYSDATE - HIRE_DATE
FROM EMPLOYEE;

-- 현재 날짜 및 시간 조회
-- * DUAL : 오라클에서 제공해주는 가상 데이터 테이블(더미 데이터)
SELECT SYSDATE FROM DUAL;

/*
    <컬럼명에 별칭 지칭하기>
    : 산술 연산 시 컬러명이 지저분해 보이는데, 이미 컬럼명울 별칭을 부여하며 깔끔하게
      표시할 수 있음.
      
      [표현법]
       * 컬럼명 별칭
       * 컬럼명 as 별칭
       * 컬럼명 "별칭"
       * 컬럼명 as "별칭"
       
       - 별칭에 띄어쓰기 또는 특수문자 포함할 때 큰따옴표("")로 묶어서 표시함
*/
-- 직원 정보 조회 : 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉 조회
SELECT EMP_NAME 사원명, SALARY as 급여, BONUS "보너스", (SALARY * 12) as "연봉",
(SALARY + (SALARY*BONUS)) * 12 as "보너스 포함 연봉"
FROM EMPLOYEE;

/*
    <리터럴> : 값 자체
    - 임의로 지정한 문자열('')
    - 조회된 RESULT SET(결과창)의 모든 행에 반복적으로 출력
*/
-- 직원 정보 조회 : 사번, 사원명, 급여
SELECT EMP_ID, EMP_NAME, SALARY, '원' as "단위"
FROM EMPLOYEE;

/*
    <연결 연산자> : ||
    - 여러 컬럼 값들을 하나의 컬럼처럼 연결할 수 있음
*/
-- 직원 정보 조회 : 사번, 사원명, 급여
SELECT EMP_ID, EMP_NAME, SALARY || '원' as "급여"
FROM EMPLOYEE;

-- 사번, 이름, 급여를 하나의 컬럼처럼 조회
SELECT EMP_ID || ' ' || EMP_NAME || ' ' || SALARY || '원' as "직원정보"
FROM EMPLOYEE;

-- xxx의 월급은 xxx원 입니다. 출력되도록 조회.
--  * 사원명, 급여
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' as "직원 별 급여 정보"
FROM EMPLOYEE;


/*
    <중복 제거> : DISTINCT
    - 컬럼에 표시되는 값들을 한번에만 조회하고자 할 때 사용
*/

-- 직원 정보에서 직급코드를 중복 제거 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 직원 정보에서 부서코드를 중복 제거 조회
SELECT * FROM EMPLOYEE;

-- ===========================================================================

/*
    <IS NULL * IS NOT NULL>
    : 컬럼값에 NULL이 있을 경우 NULL 값을 비교하기 위해 사용
*/
-- [java] str == null / str = null (x) / [oracle] str is null (0)
-- 보너스를 받지 않은 (bonus is null 사원들의 사번, 이름, 급여, 보너스 조회
-- 데이터 조회 순서 (1) -> (2) -> (3)
select emp_id, emp_name, salary, bonus -- (3)
FROM EMPLOYEE           -- (1)
WHERE bonus is null;    -- (2)
-- 보너스를 받은 사원들의 사번, 이름, 급여, 보너스 조회
SELECT emp_id, emp_name, salary, bonus
FROM EMPLOYEE
WHERE bonus is not null;

-- 사수가 없는 직원의 사원명, 사수 사번, 부서코드 조회
select emp_name, manager_id, dept_code
from employee
where manager_id is null;
-- 부서를 배치하지 않은 직원의 사원이름, 급여, 보너스 조회
select emp_name, salary, bonus
from employee
where dept_code is null;
-- =============================================================================
/*
    연산자 우선순위 : 여러 개의 연산자가 수행될 때 우선순위에 따라 순서대로 수행되는 방식
    
    1. 산술 연산자 : + - * /
    2. 연결 연산자 : ||
    3. 비교 연산자 : < > <= >= = != ^= <>
    4. IS NULL / LIKE / IN
    5. BETWEEN 시작 AND 끝
    6. NOT
    7. AND
    8. OR
*/
-- 직급코드가 J7이거나 J2인 사원 중에 급여가 200만원 이상인 사원들의 모든 데이터 조회
select *
from employee
where (job_code = 'J7' or job_code = 'J2') and salary >= 2000000;
-- ======================== 실습 문제 ===========================================
-- 1. 사수가 없고 부서 배치도 받지 않은 사원의 사원명, 사번, 부서코드 조회
select emp_name, emp_id, dept_code
from employee
where manager_id is null and dept_code is null;
-- 2. 연봉(보너스 미포함)이 3천만원 이상이고 보너스를 받지 않은 사원들의 사번, 사원명, 급여, 보너스 조회
select emp_id, emp_name, salary, bonus
from employee
where salary*12 >= 30000000 and bonus is null;
-- 3. 입사일이 '95/01/01' 이후이고 부서배치를 받지 않은 사원들의 사번, 사원명, 입사일, 부서코드 조회
select emp_id, emp_name, hire_date, dept_code
from employee
where hire_date >= '95/01/01' and dept_code is null;
-- 4. 급여가 200만원 이상, 500만원 이하인 사원 중 입사일이 '01/01/01' 이후이고
--    보너스를 받지않은 사원들의 사번, 사원명, 급여, 입사일, 보너스 조회
select emp_id, emp_name, salary, hire_date, bonus
from employee
where salary between 2000000 and 5000000 and hire_date >= '01/01/01' and bonus is null;
-- 5. 보너스 포함된 연봉이 NULL이 아니고 이름에 '하'가 포함된 사원들의 사번, 사원명, 급여, 보너스 포함 연봉 조회
select emp_id, emp_name, (salary+(bonus*salary))*12
from employee
where (salary+(bonus*salary))*12 is not null and emp_name like '%하%';
-- =============================================================================
/*
    <ORDER BY> : 정렬 관련된 구문.
                 SELECT문
                 실행 순서 또한 마지막에 실행.
                 
    [표현법]
            SELECT 컬럼1, 컬럼2, ...
            FROM 테이블
            WHERE 조건식
            ORDER BY 정렬할컬럼 | 별칭 | 컬럼순분 [ASC | DESC] [NULLS FORST | NULLS LAST]
            
            * ASC : 오름차순 (기본 값으로 생략 사능)
            * DESC : 내림차순
            
            * NULLS FIRST : 정렬하려 하는 데이터 값들 중 null 인 값을 해당 데이터 맨 앞에 위치
                            DESC (내림차순) 기본 값
            * NULLS LAST  : 정렬하려 하는 데이터 값들 중 null 인 값을 해당 데이터 맨 뒤에 위치
                           ASC (오름차순) 기본 값
                           
            ex) ORDER BY NAME;  -- ASC(오름차순), NULLS LAST 이 적용된 상태!
*/
-- 직원 테이블에서 전체 데이터 조회
SELECT * FROM EMPLOYEE
-- ORDER BY EMP_NAME; -- 직원명으로 오름차순 정렬 (ASC 생략!)
-- ORDER BY EMP_NAME DESC; -- 직원명으로 내림차순 정렬
-- ORDER BY BONUS ASC NULLS FIRST; -- 보너스 기준으로 NULL인 항목이 맨 앞이 배치되도록 오름차순 정렬
-- ORDER BY BONUS; -- 보너스 기준으로 NULL인 항목을 맨 뒤로 배치하여 오름차순 정렬
ORDER BY BONUS DESC, SALARY ASC; -- 보너스 기준으로 내림차순 정렬하고, 급여 기준으로 오름차순 정렬

-- 전 사원의 사원명, 연봉 조회 (연봉 별 내림차순 정렬)
SELECT EMP_NAME "사원명", SALARY * 12 "연봉"
FROM EMPLOYEE
-- ORDER BY SALARY * 12 DESC;
-- ORDER BY 연봉 DESC;
ORDER BY 연봉 DESC;
