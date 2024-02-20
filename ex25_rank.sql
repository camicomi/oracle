-- ex25_rank.sql

/*

    순위 함수
    - rownum 기반으로 만들어진 함수
    - 정렬 후......
    
    1. rank() over(order by 컬럼명 [asc|desc])
        - 동일값 = 동일순서
        - 누적O
 
    2. dense_rank() over()
        - 동일값 = 동일순서
        - 누적X
    
    3. row_number() over()
        - rownum과 동일, 중복값도 등수를 매긴다
        - 게시판 만들때 사용
*/

-- tblInsa. 급여순으로 가져오시오. + 순위 표시

select a.*, rownum from
(select name, buseo, basicpay from tblInsa order by basicpay desc) a;

-- 정렬을 했을때 동일한값이 나오면 동일한 랭킹을 매긴다
select name, buseo, basicpay,
rank() over(order by basicpay desc) as rnum
from tblInsa; -- 8등, 8등 -> 10등


select name, buseo, basicpay,
dense_rank() over(order by basicpay desc) as rnum
from tblInsa; -- 8등,8등 -> 9등

select name, buseo, basicpay,
row_number() over(order by basicpay desc) as rnum
from tblInsa; -- rownum 동일

-- 급여 5위?

-- ORA-30483: 윈도우 함수를 여기에 사용할 수 없습니다
select name, buseo, basicpay,
row_number() over(order by basicpay desc) as rnum
from tblInsa
where (row_number() over(order by basicpay desc)) = 5;

-- 등수화 작업시 서브쿼리 필수 
select * from
    (select name, buseo, basicpay,
row_number() over(order by basicpay desc) as rnum
from tblInsa)
    where rnum = 5; 
    
-- 8등 2명 
select * from
    (select name, buseo, basicpay,
rank() over(order by basicpay desc) as rnum
from tblInsa)
    where rnum = 8; 

-- 순위 함수 + order by
--------------------------------------------------------------------
-- 순위 함수 (+ order by + partition by) > 그룹별 순위 정할때 사용

    select name, buseo, basicpay,
rank() over(partition by buseo order by basicpay desc) as rnum
from tblInsa;



select * from (select name, buseo, basicpay,
rank() over(order by basicpay desc) as rnum
from tblInsa) where rnum = 1;

-- 각 부서별 1등? 
select * from (select name, buseo, basicpay,
rank() over(partition by buseo order by basicpay desc) as rnum
from tblInsa) where rnum = 1;