-- ex13_ddl.sql

/*

    ex01 ~ ex12 : DML 기본
    
    DDL
    - 데이터 정의어
    - 데이터베이스 객체를 생성/수정/삭제한다.
    - 데이터베이스 객체 > 테이블, 뷰, 인덱스, 프로시저, 트리거, 제약 사용, 시노닙 등..
    - CREATE, ALTER, DROP
    
    
    테이블 생성하기 > 스키마 정의하기 > 속성(컬럼) 정의하기 > 속성(컬럼)의 성격(이름)과 도메인(자료형, 제약)을 정의하기
    
    CREATE TABLE 테이블명
    (
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        
        컬럼명 자료형(길이) NULL 제약사항
        
    );
        


    제약 사항, Constraint
    - 해당 컬럼에 들어갈 데이터(값)에 대한 조건
        > 조건에 만족하면 > 대입
        > 조건에 만족하지 못하면> 에러발생
    - 유혀성 검사 도구
    - 데이터 무결성을 보장하기 위한 도구(*****)
    
    1. NOT NULL
        - 해당 컬럼이 반드시 값을 가져야한다.
        - 해당 컬럼에 값이 없으면 에러 발생
        - 필수값
    
    2. PRIMARY KEY, PK
        - 기본키
        - 테이블의 행을 구분하기 위한 제약 > 
        - 행을 식별하는 수많은 키들 중 대표로 지정한 키
        - 모든 테이블 안에는 반드시 1개의 기본키가 존재해야한다.(*********)
        - 중복값을 가질 수 없다. > unique
        - 값을 반드시 가진다. > not null
        
    3. FOREIGN KEY
    
    4. UNIQUE
        - 유일하다. > 행들 간에 동일값을 가질 수 없다.
        - UNIQUE 제약은 null을 가질 수 있다. > 식별자가 될 수 없다.
        ex) 경품
            - 고객(번호(PK), 이름, 주소, 당첨(UQ))
                     1, 홍길동, 서울, 1등
                     2, 아무개, 부산, NULL
                     3, 하하하, 서울, 2등
                     4, 호호호, 경기, 3등
                     5, 후후후, 제주, NULL
        ex) 초등학교 교실
            - 학생(번호(PK), 이름, 직책(UQ))
                    1, 홍길동, 반장
                    2, 아무개
                    3, 하하하, 부반장
                    4, 호호호
                    5, 후후후
        
    5. CHECK
        - 사용자 정의 제약 조건
        - where절과 동일한 조건을 컬럼에 적용한다.
        
    
    
    6. DEFAULT
        - 기본값 설정
        - insert/update 작업 때 컬럼값을 대입하지 않으면(null)


*/


drop table tblMemo;

-- 메모 테이블
create table tblMemo (

    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) null,                  -- 메모번호
    name varchar2(30) null,              -- 작성자
    memo varchar2(1000) null,            -- 메모
    regdate date null                    -- 작성날짜

);

select * from tblMemo;
--select * from tblMemo where 2번째 행;


insert into 테이블(컬럼리스트) values (값리스트);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (2, '아무개', null, sysdate);
insert into tblMemo(seq, name, memo, regdate) values (3, null, null, null);
insert into tblMemo(seq, name, memo, regdate) values (null, null, null, null); -- 절대 생성 금지!!!
insert into tblMemo(seq, name, memo, regdate) values (4, '홍길동', '테스트', '2022-01-01');
insert into tblMemo(seq, name, memo, regdate) values (5, '홍길동', '테스트', '2022-01-01 12:30:00'); -- 에러
insert into tblMemo(seq, name, memo, regdate) values (5, '홍길동', '테스트', to_date('2022-01-01 12:30:00', 'yyyy-mm-dd hh24:mi:ss')); -- 이게 정석



drop table tblMemo;

create table tblMemo (

    
    seq number(3) not null,              -- 메모번호(NN)
    name varchar2(30) null,              -- 작성자
    memo varchar2(1000) not null,        -- 메모(NN)
    regdate date null                    -- 작성날짜

);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.', sysdate);

--ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO")
insert into tblMemo(seq, name, memo, regdate) values (2, '홍길동', null, sysdate); -- not null(NN) 제약사항에 걸린다. > 에러
insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '', sysdate); -- 빈문자도 null 취급한다. > 에러
insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', ' ', sysdate); -- 스페이스는 문자이므로 된다.

select * from tblMemo;








-- PRIMARY KEY

drop table tblMemo;

create table tblMemo (
    
    seq number(3) primary key,           -- 메모번호(NN)
    name varchar2(30) null,              -- 작성자
    memo varchar2(1000) not null,        -- 메모(NN)
    regdate date null                    -- 작성날짜

);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.', sysdate);

--ORA-00001: unique constraint (HR.SYS_C007085) violated > 중복값을 넣으려고 했습니다.
--insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.', sysdate);

insert into tblMemo(seq, name, memo, regdate) values (2, '홍길동', '메모입니다.', sysdate);

--ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ")
--insert into tblMemo(seq, name, memo, regdate) values (null, '홍길동', '메모입니다.', sysdate);


select * from tblMemo;







--UNIQUE

drop table tblMemo;


create table tblMemo (

    
    seq number(3) primary key,                  -- 메모번호(PK)
    name varchar2(30) unique null,              -- 작성(UQ)
    memo varchar2(1000) not null,            -- 메모(NN)
    regdate date null                    -- 작성날짜

);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.', sysdate);

--ORA-00001: unique constraint (HR.SYS_C007088) violated
insert into tblMemo(seq, name, memo, regdate) values (2, '홍길동', '메모입니다.', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (2, '아무개', '메모입니다.', sysdate);

insert into tblMemo(seq, name, memo, regdate) values (3, null, '메모입니다.', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (4, null, '메모입니다.', sysdate);

select * from tblMemo;













--CHECK

drop table tblMemo;


create table tblMemo (
    
    seq number(3) primary key,                  -- 메모번호(PK)
    name varchar2(30),                          -- 작성(UQ)
    memo varchar2(1000),                        -- 메모(NN)
    regdate date,                               -- 작성날짜
    priority number check (priority between 1 and 3),                                           --1(중요), 2(보통), 3(안중요)
    category varchar2(30) check (category in ('할일', '장보기', '공부', '가족', '친구'))        -- 할일, 장보기, 공부, 가족, 친구

);


insert into tblMemo(seq, name, memo, regdate, priority, category)
                    values (1, '홍길동', '메모입니다.', sysdate, 1, '할일');

--ORA-02290: check constraint (HR.SYS_C007092) violated
insert into tblMemo(seq, name, memo, regdate, priority, category)
                    values (2, '홍길동', '메모입니다.', sysdate, 5, '할일');
                    
--ORA-02290: check constraint (HR.SYS_C007093) violated     
insert into tblMemo(seq, name, memo, regdate, priority, category)
                    values (2, '홍길동', '메모입니다.', sysdate, 3, '코딩');

-- CHECK에서 null을 검사할 수 없다 > null은 not null로만 체크 가능하다.
insert into tblMemo(seq, name, memo, regdate, priority, category)
                    values (2, '홍길동', '메모입니다.', sysdate, 3, null);


insert into tblMemo(seq, name, memo, regdate, priority, category)
                    values (3, '홍길동', '메모입니다.', sysdate, null, null);
                    

select * from tblMemo;









--DEFAULT
drop table tblMemo;


create table tblMemo (
    
    seq number(3) primary key,                  -- 메모번호(PK)
    name varchar2(30) default '익명',           -- 작성(UQ)
    memo varchar2(1000),                        -- 메모(NN)
    regdate date default sysdate                -- 작성날짜
 

);



insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (2, null, '메모입니다.', sysdate); -- 여기에 null은 개발자의 의도 표현o > 따라서 default 값을 안 넣어줌
insert into tblMemo(seq, memo, regdate) values (3, '메모입니다.', sysdate); -- 개발자 의도 표현 x > default로 알아서 넣으라는 뜻으로 생각함 > 소극적인 default 실행 방법
insert into tblMemo(seq, name, memo, regdate) values (4, default, '메모입니다.', sysdate); -- 적극적인 default 실행 방법


insert into tblMemo(seq, name, memo) values (1, '홍길동', '메모입니다.'); -- 현재 시간도 default를 걸어두면 매번 신경 안 써도 적용된다.


select * from tblMemo;






-- DDL > 테이블 생성 > 컬럼 생성 = 컬럼명 + 자료형(길이) + 제약 사항

-- 1. not null
-- 2. primary key = not null + unique
-- 3. unique
-- 4. check
-- 5. default
-- 6. foreign


/*

    제약 사항을 만드는 방법
    
    1. 컬럼 수준에서 만드는 방법
        - 위에서 수업한 방법
        - 컬럼을 정의할 때 제약사항도 같이 정의하는 방법
        
    2. 테이블 수준에서 만드는 방법
        - 컬럼 정의와 제약사항 정의를 분리시킨 방법
        - 제약 사항만 따로 정의 > 관리 차원 > 코드 분리
        - not null, default > 컬럼 수준에서만 정의 가능
        
    3. 외부에서 만드는 방법
        - alter 명령어   
    

*/



drop table tblMemo;

create table tblMemo (
    
    seq number(3) /*constraint tblmemo_seq_pk primary key*/,         
    name varchar2(30) not null,     -- not null 제약은 컬럼수준에서만 선언 가능
    memo varchar2(1000),         
    regdate date,
    
    -- 테이블 수준의 제약사항 정의
    -- 제약사항명: 테이블명_컬럼명_제약사항
    constraint tblmemo_seq_pk primary key(seq),
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check(length(memo) >= 10)
    
);

-- ORA-00001: unique constraint (HR.SYS_C007085) violated
-- ORA-00001: unique constraint (HR.TBLMEMO_SEQ_PK) violated
-- ORA-02290: check constraint (HR.TBLMEMO_MEMO_CK) violated
-- ORA-00001: unique constraint (HR.TBLMEMO_NAME_UQ) violated
insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모입니다.홍길동입니다.', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (2, '홍길동', '메모입니다.홍길동입니다.', sysdate);




















