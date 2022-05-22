-- ex32_synonym.sql


/*

    동의어, Synonym
    - 시노님
    - 데이터베이스 객체의 별칭
    - 다른 사용자 소유의 객체를 접근 > 별칭 사용

*/


--hr
show user;

select * from tabs where table_name = 'TBLINSA';

--system
show user;

select * from tblInsa;

select * from tabs where table_name = 'TBLINSA';

select * from tblInsa;
select * from hr.tblInsa; -- 다른 계정의 자원에 접근 > 계정명.자원명

select fnSum(10,20) from dual; -- hr의 함수라 system으로 그냥은 못 씀
select hr.fnSum(10,20) from dual; -- hr.fnSum




-- scott에게 hr.tblInsa를 접근할 수 있는 권한 부여
grant select, delete 
    on hr.tblInsa 
        to scott;

revoke delete 
    on hr.tblInsa 
        from scott;
        


-- 일반 다른 계정 > scott
create user scott identified by java1234;

grant connect, resource to scott;


-- 시노님, Synonym
grant create synonym to scott;


--create user ksy identified by java1234;

--grant connect, resource, dba to ksy;



-- scott
show user;

select * from tabs;

select * from hr.tblInsa; -- 다른 계정의 자원은 접근 불가능

select * from hr.tblInsa; -- 접근 권한을 부여 받고는 접근 가능

update hr.tblInsa set basicpay = 3000000 where name = '홍길동'; -- 일반키 > 비인덱스
update hr.tblInsa set basicpay = 3000000 where num = 1001; -- PK > 인덱스

--ORA-01031: insufficient privileges
delete from hr.tblInsa where num = 1001;


-- 홍길동 > hong
-- 테스트 > test

-- 개발용 > dev
-- 용도별 계정 > xxx


-- 영구적으로 hr의 tblInsa를 scott이 접근해야하는 경우

select * from hr.tblInsa;

select i.name, i.buseo, i.jikwi from hr.tblInsa i;



-- create synonym 별칭 for 자원;
create synonym insa for hr.tblInsa;
create public synonym insa for hr.tblInsa; -- 다른 계정에서도 사용 가능 > 잘 안 씀.

select * from hr.tblInsa;
select * from insa; -- 소유주 명시X > 이러면 보통 자기 테이블이라고 생각한다. 
                    --  > 하지만 이건 scott의 테이블이 아니라 Synonym을 쓴 것이다.

select * from tabs; -- 여전히 scott이 가진 테이블은 없다.

-- 시노님의 장점
-- > 별칭으로 이름을 줄일 수 있다.
-- > 1회성이 아니라 계속 사용 가능
select * from hr.departments;
select * from dept;


-- dual, tabs > public 시노님
select sysdate from dual;
select * from tabs;























