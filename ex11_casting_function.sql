-- ex11_casting_function.sql

/*

    형변환
    
    1. varchar2 to_char(숫자형) : 숫자 -> 문자
    2. varchar2 to_char(날짜형) : 날짜 -> 문자
    3. number to_number(문자형) : 문자 -> 숫자
    4. date to_date(문자형) : 문자 -> 날짜
    
    
    
    1. varchar2 to_char(숫자형 [, 형식문자열]) : 숫자 -> 문자
    - 형식문자열을 넣을수도 있고 안 넣을수도 있다 %d, %f 같이
    
    형식문자열 구성요소
    a. 9 : 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 공백으로 치환 > %5d
    b. 0 : 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 0으로 치환 > %05d
    c. $ : 통화 기호
    d. L : 통화 기호
    e. . : 소숫점
    f. , : 천단위 표기

*/

select 
basicpay as aaaaaaaaaaaaaaaaaaaaaaaa,  -- 오른쪽 정렬(숫자)
to_char(basicpay) as aaaaaaaaaaaaaaaaaaaaaaaa -- 왼쪽 정렬(문자)
from tblInsa;


select
    weight,
    '@' ||  to_char(weight) || '@',
    '@' ||  to_char(weight, '99999') || '@', -- @    64@ 5자리의 문자로 만들고, 나머지부분을 스페이스로 채우기
    '@' ||  to_char(weight, '00000') || '@', -- @ 00064@ 5자리의 문자로 확보하고, 나머지부분을 0으로 채우기, 빈칸은 부호 (+,-)
    '@' ||  to_char(-weight, '99999') || '@', -- @   -64@
    '@' ||  to_char(-weight, '00000') || '@' -- @-00064@
from tblComedian;



select 
100,
to_char(100, '$999'), --  $100
--to_char(100, '999달라')
to_char(100) || '달라',
to_char(100, 'L999') --         ￦100
from dual;


select

    3.14,
    to_char(3.14, '99.9'), --   3.1
    to_char(3.14, '9.99'), --  3.14
    1000000,
    to_char(1000000, '9,999,999'),
    to_char(1000000, '9999,999')

from dual;


/*

2. varchar2 to_char(날짜형 [, 형식문자열]) : 날짜 -> 문자

형식문자열 구성 요소
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

select sysdate from dual; -- 24/02/15
select to_char(sysdate, 'yyyy') from dual; -- 2024 > 년(4자리)  
select to_char(sysdate, 'yy') from dual;  -- 24 > 년(2자리)
select to_char(sysdate, 'month') from dual; -- 2월 > 월(풀네임)
select to_char(sysdate, 'mon') from dual; --2월 > 월(약어)
select to_char(sysdate, 'mm') from dual; --02 > 월(2자리)
select to_char(sysdate, 'day') from dual;  -- 목요일 > 요일(풀네임)
select to_char(sysdate, 'dy') from dual; --목 > 요일(약어)
select to_char(sysdate, 'ddd') from dual; --046 > 일(올해의 며칠)
select to_char(sysdate, 'dd') from dual; --15 > 일(이번달의 며칠)
select to_char(sysdate, 'd') from dual; --5 > 일(이번주의 며칠, 요일)
select to_char(sysdate, 'hh') from dual; --02 > 시(12시)
select to_char(sysdate, 'hh24') from dual; -- 14 > 시(24시)
select to_char(sysdate, 'mi') from dual; -- 38 > 분
select to_char(sysdate, 'ss') from dual; -- 00 > 초
select to_char(sysdate, 'am') from dual; -- 오후 > 오전/오후
select to_char(sysdate, 'pm') from dual;  -- 오후 > 오전/오후

select
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd'), -- 2024-02-15
    to_char(sysdate, 'hh24:mi:ss'), -- 14:44:51
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), -- 2024-02-15 14:45:40
    to_char(sysdate, 'day am hh:mi:ss') -- 목요일 오후 02:46:36
from dual;

select
    name,
    to_char(ibsadate, 'yyyy-mm-dd') as ibsadate,
    to_char(ibsadate, 'day') as day,
    case
        when to_char(ibsadate, 'd') in ('1', '7') then '휴일 입사'
        else '평일 입사'
    end
from tblInsa;

-- 요일별 입사 인원수?
 
select
    count(case
        when to_char(ibsadate, 'd') = '1' then 1
    end),
    count(decode(to_char(ibsadate, 'd'), '2', 1)) as 월요일,
    count(decode(to_char(ibsadate, 'd'), '3', 1)) as 화요일,
    count(decode(to_char(ibsadate, 'd'), '4', 1)) as 수요일,
    count(decode(to_char(ibsadate, 'd'), '5', 1)) as 목요일,
    count(decode(to_char(ibsadate, 'd'), '6', 1)) as 금요일,
    count(decode(to_char(ibsadate, 'd'), '7', 1)) as 토요일
from tblInsa;

-- tblInsa. 2010년도 입사한 직원?

select * from tblInsa
    where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31'; -- 오답
    
select * from tblInsa
    where ibsadate >= '2010-01-01 00:00:00' and ibsadate <= '2010-12-31 23:59:59'; --  형변환을 안해줘서 할 수 없는 방식
    
select * from tblInsa
    where ibsadate between '2010-01-01' and '2010-12-31'; -- 오답 (날짜가 아닌 문자열로 시분초가 없어서)
    
select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2010';
    
    
    
/*

    3. number to_number(문자형) : 문자 -> 숫자


*/


select 
    '123' * 2,
    to_number('123') * 2 -- 암시적 형변환이 발생하므로 가치 없다
from dual;


/*

    4. date to_date(문자형[, 형식문자열]) : 문자 -> 날짜 

*/


select 
    '2024-02-15', -- 날짜? 문자?  -> 문자
    to_date('2024-02-15'), -- 24/02/15
    --to_date('2024-02-15 15:14:45')  X
    to_date('2024-02-15', 'yyyy-mm-dd'),
    to_date('20240215'),
    to_date('20240215', 'yyyymmdd'),
    to_date('02152024', 'mmddyyyy'),
    to_date('2024-02-15 15:14:45', 'yyyy-mm-dd hh24:mi:ss')
    
from dual;

select * from tblInsa
    where ibsadate >= to_date('2010-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
    and ibsadate <= to_date('2010-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss');
    
-- to_char(숫자) > *
-- to_char(날짜) > *****
-- to_number(문자) 
-- to_date(문자) > ***

