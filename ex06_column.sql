-- ex06_column.sql

-- 컬럼리스트에서 할 수 있는 행동
-- select 컬럼리스트

-- select 컬럼 명시
select name, jikwi, buseo from tblInsa;

-- 연산
select name || '님', basicpay * 2 from tblInsa;

-- 상수
select name, 100 from tblInsa;

/*


Java Stream > list.stream().distinct().forEach() 

distinct
- 컬럼 리스트에서 사용 
- 중복값 제거
- distinct 컬럼명(X) > distinct 컬럼리스트(O) 


*/

-- tblCountry 에 어떤 대륙이 있습니까?
select continent from tblCountry;
select distinct continent from tblCountry;

-- tblInsa. 어떤 부서들이 있습니까?
select distinct buseo from tblInsa;
select distinct jikwi from tblInsa;
select distinct city from tblInsa;

select distinct name from tblInsa; -- 동명이인 없다

select distinct buseo, name from tblInsa; -- 중복값 배제가 되지 않았다 

select distinct jikwi, city from tblInsa;

select distinct jikwi, city, buseo from tblInsa;


/*

    case
    - 대부분의 절에서 사용 가능 
    - 조건문 역할 > 컬럼값 조작
    - 조건을 만족하면 then 값을 반환
    - 조건을 만족하지 못하면 null을 반환

*/

select * from tblComedian;

delete from tblComedian;

INSERT INTO tblComedian VALUES ('재석', '유', 'm', 178, 64, '메뚜기');
INSERT INTO tblComedian VALUES ('명수', '박', 'm', 172, 66, '하찮은');
INSERT INTO tblComedian VALUES ('준하', '정', 'm', 184, 89, '정중앙');
INSERT INTO tblComedian VALUES ('동훈', '하', 'm', 169, 65, '상꼬마');
INSERT INTO tblComedian VALUES ('형돈', '정', 'm', 173, 85, '미존개오');
INSERT INTO tblComedian VALUES ('나래', '박', 'f', 148, 58, '박가래');
INSERT INTO tblComedian VALUES ('국주', '이', 'f', 167, 92, '김태우');
INSERT INTO tblComedian VALUES ('세호', '조', 'm', 167, 82, '프로 억울러');
INSERT INTO tblComedian VALUES ('준현', '김', 'm', 182, 113, '백돼지');
INSERT INTO tblComedian VALUES ('민상', '유', 'm', 183, 129, '이십끼');

COMMIT;


select last || first as name, gender from tblComedian;


select last || first as name, 
case
    -- when 조건 then 값
    when gender = 'm' then '남자'
    when gender = 'f' then '여자'

end as gender -- 끝
from tblComedian;


select last || first as name, 
case gender
    when 'm' then '남자'
    when 'f' then '여자'

end as gender
from tblComedian;

select name, continent,
case 
    when continent = 'AS' then '아시아'
    when continent = 'EU' then '유럽'
    when continent = 'AF' then '아프리카'  -- 자료형이 반드시 동일해야 한다
    -- else '기타'
    else continent -- 원본값을 돌려준다
    -- else name
end as continentName
from tblCountry;

select last || first as name, 
weight,
case 
when weight > 90 then '과체중'
when weight > 50 then '정상체중'
else '저체중'
end as state 
from tblComedian;


select last || first as name, 
weight,
case 
when weight >= 50 and weight <= 90 then '정상체중'
else '주의체중'
end as state2
from tblComedian;

select last || first as name, 
weight,
case 
when weight between 50 and 90 then '정상체중'
else '주의체중'
end as state3
from tblComedian;

-- 사원, 대리 > 현장직
-- 과장, 부장 > 관리직

select name, jikwi,
case
    when jikwi = '과장' or jikwi = '부장' then '관리직'
    else '현장직'
end,
case
    when jikwi in ('과장', '부장') then '관리직'
    else '현장직'
end,

case 
when jikwi like '%장' then '관리직'
    else '현장직'
end
from tblInsa;

select * from tblTodo;

select 
    title,
    case
        when completedate is null then '미완료'
        when completedate is not null then '완료'
    end
from tblTodo;