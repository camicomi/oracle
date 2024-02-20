-- ex26_with.sql


/*



        [WITH <Sub Query>]
        SELECT column_list
        FROM table_name
        [WHERE search_condition]
        [GROUP BY group_by_expression]
        [HAVING search_condition] --- 독립적으로 사용 불가, group by  와 함께 
        [ORDER BY order_expression [ASC|DESC]];
        
        
        WITH <Sub Query>      1.
        SELECT 컬럼리스트       5. 컬럼 지정 (보고 싶은 컬럼만 가져오기) > Projection
        FROM 테이블            2.  테이블 지정
        WHERE 검색조건;         3. 조건 지정 (보고 싶은 행만 가져오기) > Selection
        GROUP BY 그룹기준       4.  그룹을 나눈다
        ORDER BY 정렬기준;      6. 정렬해서 
        
        with절
        - 인라인뷰(from 절 서브쿼리)에 이름을 붙이는 기술
        
        with절 > 임시 뷰명
        view > 영구 뷰명
        
        create or replace view 실명뷰
        
        with 테이블명 as <서브쿼리>
        select문;

*/

select * from (select name, buseo, jikwi from tblInsa where city = '서울');

with seoul as (select name, buseo, jikwi from tblInsa where city = '서울')
select * from seoul;

select * from (select name, age, couple from tblMen where weight < 90) a
    inner join (select name, age, couple from tblWomen where weight > 60) b
        on a.couple = b.name;
     
     -- 임시 뷰    
with a as (select name, age, couple from tblMen where weight < 90),
     b as (select name, age, couple from tblWomen where weight > 60)
select * from a
    inner join b
        on a.couple = b.name;
        
        
        
        
-- null 함수
-- null을 치환하는 함수

-- null value
-- 1. nvl(컬럼, 값)
-- 2. nvl2(컬럼, 값, 값)

select 
    name,
    case
        when population is not null then population
        when population is null then 0
    end
from tblcountry; 


select name, nvl(population, 0) from tblCountry;

- ORA-01722: 수치가 부적합합니다 
- 자료형이 달라서 안된다
select name, nvl(population, '인구없음') from tblCountry;

create table tblItem(
    seq number primary key,     --***
    name varchar2(100) not null,
    color varchar2(100) not null

);
-- 시퀀스 만들기 
-- 현재테이블에서 가장 큰 시퀀스를 찾아서 + 1 를 더하면 된다 > 하지만 맨 처음에는 null 이므로 안되는데?
-- 이럴때 nvl 사용!  
insert into tblItem (seq, name, color)
    values ((select nvl(max(seq), 0) + 1 from tblItem), '마우스', 'white');
    
select * from tblItem;

delete from tblItem;


select
    name, nvl2(population, 1, 2) -- 값이 있으면 1 반환, 없으면 2 반환
    from tblCountry;
    
select
    name, nvl2(population, population, 0) -- nvl와 동일
    from tblCountry;
    
    
select
    name, nvl2(population, '인구있음', '인구없음') -- 이건 가능
    from tblCountry;