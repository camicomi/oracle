-- ex18_groupby.sql

/*

        [WITH <Sub Query>]
        SELECT column_list
        FROM table_name
        [WHERE search_condition]
        [GROUP BY group_by_expression]
        [HAVING search_condition]
        [ORDER BY order_expression [ASC|DESC]];
        
        SELECT 컬럼리스트 4. 컬럼 지정 (보고 싶은 컬럼만 가져오기) > Projection
        FROM 테이블     1.  테이블 지정
        WHERE 검색조건;  2. 조건 지정 (보고 싶은 행만 가져오기) > Selection
        GROUP BY 그룹기준 3.  그룹을 나눈다
        ORDER BY 정렬기준; 5. 정렬해서 
        
        group by절
        - 특정 기준으로 레코드를 그룹으로 나눈다 (수단)
            > 각각의 그룹을 대상으로 집계함수를 실행한다 (목적)

*/

-- tblInsa. 부서별 평균 급여?
select * from tblInsa;

select round(avg(basicpay)) from tblInsa; -- 155만원 전체 60명

select distinct buseo from tblInsa; -- 7개

select round(avg(basicpay)) from tblInsa where buseo = '기획부'; --185
select round(avg(basicpay)) from tblInsa where buseo = '총무부'; --171
select round(avg(basicpay)) from tblInsa where buseo = '개발부'; --138
select round(avg(basicpay)) from tblInsa where buseo = '영업부'; --160
select round(avg(basicpay)) from tblInsa where buseo = '홍보부'; --145
select round(avg(basicpay)) from tblInsa where buseo = '인사부'; --153
select round(avg(basicpay)) from tblInsa where buseo = '자재부'; --141

-- ORA-00979: GROUP BY 표현식이 아닙니다. > 집계함수 필요
select 
*
from tblInsa group by buseo; -- group by 그룹기준

select 
    buseo,
    round(avg(basicpay)) as "부서별 평균 급여",
    count(*) as "부서별 인원수",
    sum(basicpay) as "부서별 총 지급액",
    max(basicpay) as "부서내의 최고 급여",
    min(basicpay) as "부서내의 최저 급여"
from tblInsa group by buseo; -- group by 그룹기준

-- 남자수? 여자수?
select count(decode(gender, 'm', 1)) as "남자수",
       count(decode(gender, 'f', 1)) as "여자수"
from tblComedian;


select
    gender,
    count(*)
from tblComedian
    group by gender;


select
jikwi,
count(*)
from tblInsa
group by jikwi;

select
city,
count(*)
from tblInsa
group by city;

-- ORA-00979: GROUP BY 표현식이 아닙니다.
-- 집계함수와 개인데이터 동일하게 사용할 수 없다
select
count(*), name
from tblInsa
    group by buseo;
    
    
-- group by 에 들어가는 데이터와 상수는 집계함수와 함께 사용할 수 있다
select
count(*), buseo, 100
from tblInsa
    group by buseo;
    

select
count(*), buseo
from tblInsa
    group by buseo
    order by count(*) desc;
   
-- 별칭 가능 
select
count(*) as cnt, buseo
from tblInsa
    group by buseo
    order by cnt desc;
    
    
-- 다중 그룹 생성 가능
select
count(*), buseo, jikwi
from tblInsa
    group by buseo, jikwi
    order by buseo, jikwi;
    

select
count(*), jikwi, buseo
from tblInsa
    group by jikwi, buseo
    order by jikwi, buseo;
    
    
    
-- 급여별 그룹
-- 100만원 이하 
-- 100만원 ~ 200만원
-- 200만원 이상
select
basicpay,
count(*)
from tblInsa
    group by basicpay;
    
    
    
select
    -- basicpay, 사용불가 
    (floor(basicpay / 1000000) + 1) * 100 || '만원 이하' as money,
    count(*)
from tblInsa
    group by floor(basicpay / 1000000);
    
    
-- tblInsa. 남자? 여자?

select
substr(ssn, 8, 1),
count(*)
from tblInsa 
group by substr(ssn, 8, 1);


select 
case
    when completedate is not null then 1
    else 2
end, -- case end 는 한개의 컬럼이다
count(*)
from tblTodo 
group by case
    when completedate is not null then 1
    else 2
end;  --   복잡해보여도 어쩔수없음 group by가 먼저 실행되므로 as 사용 불가

-- tblInsa. 과장+부장 몇명? 사원+대리 몇명? 