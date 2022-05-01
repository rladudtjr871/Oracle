-- ex22_alter.sql


/*

    객체생성: CREATE
    객체삭제: DROP
    객체수장: ALTER
    
    데이터 생성: INSERT
    데이터 삭제: DELETE
    데이터 수정: UPDATE
    
    
    테이블 수정하기
    - 테이블 정의 수정 > 테이블 스키마 수정 > 컬럼 수정(컬럼명 or 자료형(길이) or 제약사항)
    - 되도록 테이블 수정하는 상황을 발생시키면 안된다!!! > 설계를 반드시 완벽하게!!!
    
    
    테이블 수정해야 하는 상황 발생!!!
    1. 테이블 삭제(DROP) > 테이블 DDL(CREATE) 수정 > 수정된 DDL로 새롭게 테이블 생성
        a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있었을 경우 > 미리 데이터 백업 > 테이블 삭제 > 수정 후 생성 > 데이터 복구
            - 개발 중에 사용 가능
            - 공부할 때 사용 가능
            - 서비스 운영중에는 거의 불가능한 방법
        
    
    2. ALTER 명령어 사용 > 기존 테이블의 구조 변경
        a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있었을 경우 > 경우에 따라 무난/추가 조치 필요
            - 개발 중에 사용 가능
            - 공부할 때 사용 가능
            - 서비스 운영 중 가능한 방법

*/

drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');

select * from tblEdit;


-- Case 1. 새로운 컬럼을 추가하기
alter table tblEdit 
    add (price number null);


--ORA-01758: table must be empty to add mandatory (NOT NULL) column
alter table tblEdit
    add (memo varchar2(100) not null); -- alter 테이블을 추가하면 해당 부분은 데이터가 없어서 not null 제약이 불가능


delete from tblEdit; -- 기존 데이터 날리고


alter table tblEdit
    add (memo varchar2(100) not null); -- 추가하면 컬럼만 있고 null인 데이터가 없어서 잘 생성된다.


select * from tblEdit;

insert into tblEdit values (1, '마우스', 3000, '로지텍');

select * from tblEdit;


-- 위 방법은 데이터를 다 날려야하는 단점이 있다.
-- 그러나 alter시 default를 깔고 not null을 걸면 default값으로 채워지기때문에 not null제약에 위배되지 않는다.
-- 그러나 1번째 방법(위에 방법)을 권장한다. > 다 지우고 만드는 방법 추천
alter table tblEdit
    add (memo2 varchar2(100) default '임시' not null); 

select * from tblEdit;



-- Case 2. 컬럼 삭제하기
alter table tblEdit
    drop column memo2;

alter table tblEdit
    drop column memo;

alter table tblEdit
    drop column seq; --PK 컬럼 삭제 > 절대 금지!!!

select * from tblEdit;



-- Case 3. 컬럼 수정하기
drop table tblEdit;

insert into tblEdit values (4, '인텔 i7 12세대 최신형 노트북');


-- Case 3.1 컬럼의 길이 수정하기(확장/축소)
alter table tblEdit
    modify (data varchar2(100));

--ORA-01441: cannot decrease column length because some value is too big
alter table tblEdit
    modify (data varchar2(20));    


--Case 3.2 컬럼의 제약사항 수정하기
alter table tblEdit
    modify (data varchar2(100) null); -- null 허용

alter table tblEdit
    modify (data varchar2(100) not null); --not null 제약

desc tblEdit;


--Case 3.3 컬럼의 자료형 바꾸기 (이런 일이 생기면 최악) > 무조건 테이블 비우고 작업
--ORA-01439: column to be modified must be empty to change datatype
alter table tblEdit
    modify (data number); --테이블 비우고해라~

alter table tblEdit
    modify (seq varchar2(100));

desc tblEdit;


-- Case 3.4 컬럼명 바꾸기
alter table tblEdit
    rename column data to etc; -- data를 etc로 컬럼명 변경

select * from tblEdit;


---------------------------------------------------------------------------------



-- 제약사항 수정하기


drop table tblEdit;

create table tblEdit (
    seq number,
    data varchar2(20) not null,
    color varchar2(30) null
);

alter table tblEdit
    add constraint tbledit_seq_pk primary key(seq); -- 제약사항 추가 (DDL에서 본 것과 유사함)

    
alter table tblEdit
    add constraint tbledit_color_ck
        check (color in ('red', 'yellow', 'blue')); -- check 제약
                

alter table tblEdit
    drop constraint tbledit_color_ck; --제약사항 삭제


insert into tblEdit values (1, '마우스', 'red'); -- 2번 추가하여 PK제약 잘 되는지 확인~
insert into tblEdit values (2, '키보드', 'yellow');
insert into tblEdit values (3, '모니터', 'white'); -- check 제약을 했을 땐 오류 > check 제약을 삭제하면 정상적으로 들어감


select * from tblEdit;

























