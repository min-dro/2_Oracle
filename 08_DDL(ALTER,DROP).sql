/*
    * DDL : 데이터 정의 언어
    
        - ALTER : 객체(테이블, 사용자, 뷰, ...)를 구문
        
            ALTER TABLE 테이블명 변경할내용;
            
            + 변경 사항
              - 컬럼 제약 조건 추가/(수정 - NOT NULL)/삭제
              - 컬럼 추가/수정/삭제
              - 테이블명/칼럼명/제약조건명 변경
*/
-- (1) 컬럼 추가/수정/삭제
--      * 컬럼 추가 : ALTER TABLE 테이블명 ADD 추가할_컬럼명 자료형

--      DEPT_TABLE 테이블에 CNAME 컬럼 추가 (VARCHAR2(20))
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);
SELECT * FROM DEPT_TABLE;


--      DEPT_TABLE 테이블에 LNAME 컬럼 추가 (VARCHAR2(20), '한국')
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '한국';
-----------------------
--      * 컬럼 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 변경할_자료형;   -- 자료형 변경
--                   ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 기본값; -- 기본값 변경

--  DEPT_TABLE 테이블에서 DEPT_ID 컬럼의 자료형을 CHAR(5) 으로 변경;
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);  -- 바이트 크기 변경 : 2->5

-- DEPT_ID 컬럼의 자료형을 NUMBER로 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;   -- 형식 오류 발생!

--  DEPT_ID  컬럼의 자료형을 VARCHAR2(10);
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID VARCHAR2(20); -- 정상 작동함!

-- DEPT_TITLE 컬럼의 자료형을 VARCHAR2(20)으로 변경 (35 -> 20)
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(20); -- 정상 동작

-- 20 -> 10 바이트 크기 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10); -- 크기 오류!

----------------------------
--          * 컬럼 삭제 : DROP COLUMN 삭제할 컬럼명
--  테이블 복사 : DEPT_COPY 생성 (DEPT_TABLE 테이블 복사)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPT_TABLE;

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
--> 테이블에는 최소 한 개의 컬럼은 존재해야 함.
--------------------------------------------------------------------------------
/*
    [2] 제약 조건 추가/삭제 -- 수정하고자 하면, 삭제 후 추가
    
    * PRIMARY KEY  | ADD [CONTRAINT 제약조건명] PRIMARY KEY(컬럼명)
    * FOREIGN KEY  | ADD [CONTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명 [(연결할컬럼명)]
    * NOT NULL     | MODIFY 컬럼명 [CONTRAINT 제약조건명] NOT NULL
    * UNIQUE       | ADD [CONTRAINT 제약조건명] UNIQUE(컬럼명)
    * CHECK        | ADD [CONTRAINT 제약조건명] CHECK(조건식-컬럼명포함된조건식)
*/
-- DEPT_TABLE -> DEPT_ID 기본키 설정 (DTABLE_PK)
--               DEPT_TITLE 중복허용X (DTABLE_UQ)
--               LNAME NULL 허용X (DTABLE_NN)
ALTER TABLE DEPT_TABLE
    ADD CONSTRAINT DTABLE_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DTABLE_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DTABLE_NN NOT NULL;
    
-- [삭제]
--  * DRPO CONSTRAINT 제약조건명 -- NOT NULL은 삭제가 없음..!
--          + NOT NULL 제약 조건을 변경 -> NULL을 허용
--              MODIFY 컬럼면 NULL;
-- DEPT_TABLE에서 기본키 (DTABLE_PK) 제약조건을 삭제
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DTABLE_PK;


--  DEPT_TABLE에서 DTABLE_UQ 제약조건 삭제, LNAME 컬럼도 NULL 사용
ALTER TABLE DEPT_TABLE
    DROP CONSTRAINT DTABLE_UQ
    MODIFY LNAME NULL;
--------------------------------------------------------------------------------
/*
    [3] 이름을 변경. (컬럼/테이블/제약조건)
    
        + 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 변경할컬럼명
        
        + 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 변경할제조건명
        
        * 테이블명 변경 : RENAME TO 바꿀테이블명
*/
-- DEPT_TITLE -> DEPT_NAME
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 제약조건명 변경: SYS_c008456 -> DTABLE_NN
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008456 TO DTABLE_NN;

-- 테이블명 변경: DEPT_TABLE -> DEPT_TEST
ALTER TABLE DEPT_TABLE RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
/*
    * 테이블 삭제 (DROP)
    
    [표현식]
            DROP TABLE 테이블명
            
    * 다른 테이블에서 참조 중인 테이블의 경우 삭제가 되지 않는다.
      만약 삭제하고자 한다면,
        1. 자식 테이블(참조하고 있는 테이블)을 먼저 삭제한 후 삭제
        2. 부모 테이블만 삭제하는데, 제약 조건까지 삭제하는 방법
            DROP TABLE 테이블명 CASCADE CONSTRAINTS
*/
DROP TABLE DEPT_TEST;
COMMIT;

DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;