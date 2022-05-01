-- ex23_pseudo.sql

/*

    의사 컬럼, Pseudo Column
    - 실제 컬럼이 아닌데 컬럼처럼 동작하는 객체
    
    
    rownum
    - 행번호
    - 데이터
    - from절이 실행될 때 각 레코드에 rownum을 할당한다.(***********************)
    - where절의 영향을 받아 reindexing을 한다. (**********************)
    - rownum을 사용시 서브 쿼리를 자주 사용한다.(**********************)
        

*/

select 
    name, buseo,     -- 컬럼(속성)   > output > 객체의 특성에 따라 다른 값을 가진다.
    rownum,          -- 의사 컬럼    > output > 컬럼의 모습이나 특성과 가장 유사함.
    substr(name, 2), -- 함수         > input + output > 객체의 특성에 따라 다른 값을 가진다.
    sysdate,         -- 함수         > output > 모든 레코드가 동일한 값을 가진다. 너 나할거 없이 모두 같은 값
    '상수'           -- 상수         > 모든 레코드가 동일한 값을 가진다. 너 나할거 없이 모두 같은 값
from tblInsa;



-- 게시판 > 페이지
-- 1페이지 > rownum between 1 and 20
-- 2페이지 > rownum between 21 and 40
-- 3페이지 > rownum between 41 and 60


-- rownum은 1이 포함되고 값이 순차적일때만 데이터를 가져올 수 있따.
select name, buseo, rownum from tblInsa where rownum = 1;
select name, buseo, rownum from tblInsa where rownum <= 5;

select name, buseo, rownum from tblInsa where rownum = 10; --1(o), 2~60(x)
select name, buseo, rownum from tblInsa where rownum > 5;  --(x)



select name, buseo, rownum      --2. 소비 > 1에서 이미 할당된 숫자를 rownum 표현을 통해서 가져온다.(여기서 생성x)
from tblInsa;                   --1. 생성 > from절이 실행되는 순간 > 모든 레코드에 rownum이 할당된다.


select name, buseo, rownum      --3. 소비
from tblInsa                    --1. 생성
where rownum = 1;               --2. 조건 > 1에서 생성된 번호를 조건으로 검색


select name, buseo, rownum      --3. 소비
from tblInsa                    --1. 생성
where rownum = 3;               --2. 조건 > 1에서 생성된 번호를 조건으로 검색
                                --        > 순차적으로 비교 > 1 탈락 > 이때 2가 1로 reindexing이 발생한다.
                                --        > 따라서 계속 shift가 발생하여 3을 절대 찾을 수 없다. > 탈락하면 다음 숫자가 계속 1로 바뀌기때문
                                --        > 1 2 3 4 5.. > 1 탈락 > 2 3 4 5 (X) > 1 2 3 4 (O)

select name, buseo, rownum      
from tblInsa                    
where rownum >= 3 and rownum <= 5; -- 찾을 수 없는 조건 > reindexing특성으로 인해




select name, buseo, basicpay, rownum    --2.
from tblInsa                            --1. 번호 생성
order by basicpay desc;                 --3.



-- 서브쿼리에서 rownum이 생성 > 엉망진창이된 숫자가
-- 메인쿼리에서 rownum이 따로 생성 > 다시 생성되어 순차적으로 나옴
select name, buseo, basicpay, 
       rownum, -- B절의 행번호
       rnum
from (select  -- B절
             name, buseo, basicpay,
             rownum as rnum -- A절 실행될 때 할당된 행번호
      from tblInsa   -- A절
        order by basicpay desc)
            where rownum <= 3;



-- rnum(고정), rownum(계산)
select name, buseo, basicpay, rrnum, rownum from (select 
                                                        name, buseo, basicpay, 
                                                       rownum as rrnum
                                                   from (select
                                                             name, buseo, basicpay
                                                      from tblInsa
                                                        order by basicpay desc)) -- rownum 값을 고정시키기 위한 행동
                                                            where rrnum >= 3 and rrnum <= 7; --서브쿼리에서의 rownum은 메인쿼리(바깥)에서 고정된 값으로 사용 가능


--(**************************************************)
-- 고객 명단 > 페이지 단위 출력 > 10명씩
select * from tblAddressBook;

-- 1. 원하는 정렬
select * from tblAddressBook order by name asc;

-- 2. 1을 뷰로 생성 + rownum 생성
-- 와일드카드와 다른 컬럼을 같이 쓸 수 없다.
-- 테이블에 alias를 붙여서 와일드 카드를 사용하면가능하다.
select a.*, rownum as rnum from (select * from tblAddressBook order by name asc) a;

-- 3. 2를 뷰로 생성 + 사용~~~
select * from(select a.*, rownum as rnum from (select * from tblAddressBook order by name asc) a);

-- 4. 고정된 값 rnum을 이용해 where절에 사용 가능
select * from(select a.*, rownum as rnum from (select * from tblAddressBook order by name asc) a)
    where rnum between 1 and 10;

select * from(select a.*, rownum as rnum from (select * from tblAddressBook order by name asc) a)
    where rnum between 11 and 20;

select * from(select a.*, rownum as rnum from (select * from tblAddressBook order by name asc) a)
    where rnum between 21 and 30;



-- 뷰로 만들어 반복되는 코드를 최소화
create or replace view vwAddressBook
as
select a.*, rownum as rnum from (select * from tblAddressBook order by name asc) a;


select * from vwAddressBook where rnum between 31 and 40; -- 뷰까지 사용하여 코드가 더 간결해짐










