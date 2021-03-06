-- ex12_casting.sql



/*

    형변환 함수
    
    1. to_char()        : 숫자 > 문자
    2. to_char()        : 날짜 > 문자 *****
    3. to_number()      : 문자 > 숫자
    4. to_date()        : 문자 > 날짜 *****


    
    
    null 함수 > null value
    1. nvl(값1, 값2)
    2. nvl2(값1, 값2, 값3)


*/

select
    name,
    population * 2, -- 자바에서 null이 피연산자가 되면 에라가 난다.
    case
        when population is not null then population
        when population is null then 0 -- 이렇게하면 자바에서도 null로 인한 에러를 해결
    end * 2 as a,
    
    nvl(population, 0) as b, -- case-end문과 같은 일을 한 것
    
    case
        when population is not null then '확인'
        when population is null then '미확인'
    end as c,
    
    nvl2(population, '확인', '미확인') as d -- 앞의 값이 null이 아니면 '확인', null이면 '미확인'을 돌려준다
    
from tblCountry;



/*

    형변환 함수
    
    1. to_char()        : 숫자 > 문자
    2. to_char()        : 날짜 > 문자 *****
    3. to_number()      : 문자 > 숫자
    4. to_date()        : 문자 > 날짜 *****
    
    
    1. to_char()
    - char to_char(컬럼, 형식문자열)
    
    
    형식문자열 구성요소
    a. 9 : 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 공백으로 치환 > %5d
    b. 0 : 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 0으로 치환    > %05d
    c. $ : 통화기호 표현
    d. L : 통화기호 표현(로컬) > 설정에 따라 바뀜
    e. . : 소수점 표시
    f. , : 자릿수 표시
       
*/


-- *** SQL은 아주 우연한 언어 > 자료형 > 암시적 형변환 잦음

select 
    weight,             -- 우측정렬(숫자)
    to_char(weight),    -- 좌측정렬(문자)
    length(weight),     -- 자동으로 형변환 발생 > length(to_char(weight)) 동일
    length(to_char(weight))
from tblComedian;



-- Java > Strong Type
-- SQL  > Week Type



select 
    10,
    length(10),  -- 10 > '10'
    length('10'),
    2 * 2,
    '2' * 2      -- '2' > 2
from dual;


-- 한 칸씩 더 있는건 부호자리이다. 9가 5개면 > 5칸확보 + 1칸 부호칸
select
    weight,
    '@' || to_char(weight) || '@',
    '@' || to_char(weight, '99999') || '@',  -- 숫자9 x > 형식문자 9 > 9개수만큼 자리를 확보하고 빈칸은 공백을 채움
    '@' || to_char(weight, '00000') || '@'   -- 숫자0 x > 형식문자 0 > 0개수만큼 자리르 확보하고 남는 자리는 0 채움
from tblComedian;




select
    100,
    to_char(100, '$999'),
    --to_char(100, '999달러') -- 형식문자열 안에는 형식문자열 구성요소만 올 수 있다. > 달러x
    to_char(100, '999') || '달러',
    to_char(100, 'L999')
from dual;



-- ,를 직접 찍어줘야함 > %,d
select 
    1234567.89,
    to_char(1234567.89, '9,999,999.9'), -- 소수이하 1자리 반올림까지 되는 모습
    to_char(1234567.89, '9,999,999.999') -- 소수이하 맨 뒤를 0으로 채우는 모습
from dual;




/*

    2. to_char()
    - 날짜 > 문자
    - char to_char(컬럼, 형식문자열)
    
    형식문자열 구성요소
    a. yyyy
    b. yy
    c. month
    d. mon
    e. mm
    f. day
    g. dy
    h. ddd
    i. dd
    j. d
    k. hh
    l. hh24
    m. mi
    n. ss
    o. am(pm)

*/


select sysdate from dual;
select to_char(sysdate) from dual;
select to_char(sysdate, 'yyyy') from dual;  -- 년(4자리)  *****
select to_char(sysdate, 'yy') from dual;    -- 년(2자리)
select to_char(sysdate, 'month') from dual; -- 월(풀네임) 
select to_char(sysdate, 'mon') from dual;   -- 월(약어)
select to_char(sysdate, 'mm') from dual;    -- 월(2자리)  *****
select to_char(sysdate, 'day') from dual;   -- 요일(풀네임)
select to_char(sysdate, 'dy') from dual;    -- 요일(약어)
select to_char(sysdate, 'ddd') from dual;   -- 일(올해의 며칠)
select to_char(sysdate, 'dd') from dual;    -- 일(이번달의 며칠) *****
select to_char(sysdate, 'd') from dual;     -- 일(이번주의 며칠 == 요일)
select to_char(sysdate, 'hh') from dual;    -- 시(12시간)
select to_char(sysdate, 'hh24') from dual;  -- 시(24시간) *****
select to_char(sysdate, 'mi') from dual;    -- 분 *****
select to_char(sysdate, 'ss') from dual;    -- 초 *****
select to_char(sysdate, 'am') from dual;    -- 오전/오후
select to_char(sysdate, 'pm') from dual;    -- 오전/오후



select
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'day am hh:mi:ss')
from dual;




select
    name,
    to_char(ibsadate, 'yyyy-mm-dd') as hire_date,
    to_char(ibsadate, 'day') as day,
    case
        when to_char(ibsadate, 'd') in('1', '7') then '주말입사'
        else '평일입사'
    end
from tblInsa;



-- 2010년에 입사한 직원?
-- 2010-01-01 00:00:00 ~ 2010-12-31 00:00:00
-- 상수값을 쓰면 시분초가 무조건 00:00:00으로 들어가서 생긱는 문제
select * from tblInsa
    where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31'; -- 오답

select * from tblInsa
    where ibsadate between '2010-01-01' and '2010-12-31'; -- 오답


-- 날짜형 리터럴은 없다.
-- 아래의 표현은 문자열 리터럴이다. > 위에 예시가 가능했던건 몰래 형변환을 했기때문
-- 날짜가 되야하는 곳이어야 형변환을 해준다. 따라서 밑에는 문자열로 출력된다.
select '2010-01-01', sysdate from dual;

select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2010';


select 
    name,
    to_char(ibsadate, 'yyyy-mm-dd day')
from tblInsa
    order by to_char(ibsadate, 'd') asc;






/*

    3. to_number()
    - 문자 > 숫자
    - number to_number(컬럼)

*/

select
    123 as "aaaaaaaaaaaaaaaa",
    '123' as "aaaaaaaaaaaaaaaa",
    to_number('123') as "aaaaaaaaaaaaaaaa"
from dual;


select
    123 * 2,
    '123' * 2 -- 암시적 형변환
    from dual;





/*

    4. to_date()
    - 문자 -> 날짜
    - date to_date(컬럼, 형식문자열)

*/

-- 프로그램 > 사용자 날짜 입력 > SQL 사용

select 
    sysdate,
    '2022-04-22',
    to_date('2022-04-22'),
    to_date('2022-04-22', 'yyyy-mm-dd'),
    to_date('20220422', 'yyyymmdd'),
    to_date('2022/04/22', 'yyyy/mm/dd'),
    to_date('2022/04/22 15:05:30', 'yyyy/mm/dd hh24:mi:ss')
from dual;




-- 날짜 관련 함수
-- 2. 날짜 > 문자
-- 4. 문자 > 날짜
























