-- ex24_pseudo.sql

/*

    의사 컬럼, Pseudo Column
    - 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
    
    rownum
    - 행번호
    - 시퀀스 객체 상관X
    - 테이블의 행번호를 가져오는 역할
    - 오라클 전용


*/

select name, buseo, -- 컬럼(속성) > 객체(레코드)의 특성에 따라 다른 값을 가진다
        100, -- 상수 > 모든 객체(레코드)가 동일한 값을 가진다
        substr(name, 2), -- 함수 > I/O > 객체(레코드)의 특성에 따라 다른 값을 가진다
        rownum -- 의사컬럼
from tblInsa;


-- 게시판 > 페이지 나누는 작업할 때 사용 > 페이징
-- 1페이지 > where rownum between 1 and 20
-- 2페이지 > where rownum between 21 and 40
-- 3페이지 > where rownum between 41 and 60

-- 조건의 값으로 사용 가능
select name, buseo, rownum from tblInsa where rownum = 1;
select name, buseo, rownum from tblInsa where rownum <= 5;

-- 안됨 (쉬프트발생) 
select name, buseo, rownum from tblInsa where rownum = 5;
select name, buseo, rownum from tblInsa where rownum > 5 and rownum <= 10;

-- *** 1. rownum은 from절이 호출될 때 계산되어진다
-- *** 2. where절에 의해 결과셋의 변화가 발생될 때 다시 계산되어진다

select name, buseo, rownum      -- 2. 소비 > 1에서 생성된 rownum을 가져온다 (여기서 X)
from tblInsa;                   -- 1. from절이 실행되는 순간 모든 레코드에 rownum이 할당


select name, buseo, rownum  -- 3. 소비
from tblInsa                -- 1. 할당
where rownum = 1;           -- 2. 조건

-- where 절> 쉬프트 발생 
select name, buseo, rownum  -- 3. 소비
from tblInsa                -- 1. 할당
where rownum <= 3;           -- 2. 조건

-- 그래서!! 
-- 서브쿼리 + rownum 

-- 급여가 5~10등까지 가져오시오.
-- 번호가 뒤죽박죽인 이유, rownum이  from절에서 만들어졌기 때문이다
select name, basicpay, rownum as rnum1
from tblInsa
order by basicpay desc;

-- rownum은 from절을 실행할 때마다 만들어진다
select name, basicpay, rnum1, rownum from
(select name, basicpay, rownum as rnum1
from tblInsa
order by basicpay desc) where rownum = 1;


-- rnum2 고정 데이터가 되어서 사용가능 
select name, basicpay rnum1, rnum2, rownum as rnum3 from
(select name, basicpay, rnum1,rownum as rnum2 from
(select name, basicpay, rownum as rnum1
from tblInsa
order by basicpay desc))
    where rnum2 = 5;
    
    
-- 1. 가장 안쪽 쿼리 > 정렬
-- 2. 1을 서브쿼리로 묶는다 + rownum > 별칭 -- 안하면 메인쿼리와  충돌난다
-- 3. 2를 서브쿼리로 묶는다 + rnum 조건
select * from(select a.*, rownum as rnum 
from (select name, basicpay from tblInsa order by basicpay desc) a)
        where rnum = 5;
-- where rownum <= 5 -- 1이 포함된 조건은 날릴 수 있으나, =5 이건 안된다 

-- tblInsa.* 이렇게 적어야 함
select tblInsa.* from tblInsa;



-- tblInsa. 급여순 정렬 + 10명씩
select * from
(select a.*, rownum as rnum from
(select * from tblInsa order by basicpay desc) a)
where rnum between 1 and 10; -- 1페이지

select * from
(select a.*, rownum as rnum from
(select * from tblInsa order by basicpay desc) a)
where rnum between 11 and 20; -- 2페이지

-- 반복되므로 view 로 만든다(단 where 절은 뺀다, 이유? 매번 바뀌니깐..)

create or replace view vwBasicpay
as
select * from
(select a.*, rownum as rnum from
(select * from tblInsa order by basicpay desc) a);

select * from vwBasicpay where rnum between 1 and 10;
select * from vwBasicpay where rnum between 11 and 20;