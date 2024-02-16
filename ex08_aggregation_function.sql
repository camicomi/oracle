-- ex08_aggregation_function.sql

/*

    함수, Function
    1. 내장 함수(Bulit-in Function)
    2. 사용자 정의 함수(User Function) > ANSI-SQL(X), PL/SQL(O)
    
    집계 함수, Aggregation Function(****************************)
    - Java > count(), sum(), max(), min(), average()
    - 아주 쉬움 > 나중에 하는 수업과 결합 > 꽤 어려움 
    
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()

    1. count()
    - 결과 테이블의 레코드 수를 반환한다. 
    - number count(컬럼명)
    - null 값은 제외한다.(***)


*/

-- tblCountry;

select count(*) from tblCountry; -- 행의 갯수 반환
select count(name) from tblCountry;
select count(capital) from tblCountry;
select count(population) from tblCountry; -- null 값 제외

-- 모든 직원수?
select count(*) from tblInsa -- 60

--  연락처가 있는 직원수? 
select count(*) from tblInsa where tel is not uull;

--  연락처가 없는 직원수?
select count(*) from tblInsa where tel is null;

-- 전체직원수 - 연락처기 있는 직원수
 select count(*) - count(tel) from tblInsa;
 
-- tblInsa. 어떤 부서들이 있나요?
select distinct buseo from tblInsa;

-- tblInsa.   몇개의 부서가 있나요? 
select count(distinct buseo) from tblInsa;

-- tblComedian. 남자수? 여자수?
select * from tblComedian;


select count(*) from tblComedian where gender = 'm'; -- 8
select count(*) from tblComedian where gender = 'f'; -- 2

--  남자수와 여자수를 1개의 테이블로 가져오시오.  ******* 자주 사용되는 패턴

select
    count(case
        when gender = 'm' then 1
    end) AS 남자인원수,
    count(case 
        when gender = 'f' then 1
    end) AS 여자인원수
from tblComedian;

select * from tblInsa;

--  tblInsa. 기획부 몇명? 총무부 몇명? 개발부 몇명? 나머지부서 몇명? > 1개의 테이블

select count(*) from tblInsa where buseo = '기획부'; --7
select count(*) from tblInsa where buseo = '총무부'; --7
select count(*) from tblInsa where buseo = '개발부'; --14

select
    count(case
        when buseo = '기획부' then 1
        end) AS 기획부,
    count(case
        when buseo = '총무부' then 1
        end) AS 총무부,
    count(case
        when buseo = '개발부' then 1
        end) AS 개발부,
    count(case 
        when buseo not in ('기획부', '총무부', '개발부') then 1
        end) AS 나머지,
    count(*) AS 총인원수
    from tblInsa;


/*

    2. sum()
    -  해당 컬럼의 합을 구한다.
    - number sum(컬럼명)
    - 숫자형 적용 가능
    


*/

select sum(population), sum(area) from tblCountry;
select sum(name) from tblCountry; -- ORA-01722: 수치가 부적합합니다
select sum(ibsadate) from tblInsa; -- ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 DATE임

select 
    sum(basicpay) as "지출 급여 합",
    sum(sudang) as "지출 수당 합",
    sum(basicpay) + sum(sudang) as "총 지출",
    sum(basicpay + sudang) as "총 지출"
    from tblInsa;

select sum(*) from tblInsa;

/*

    3. avg()
    - 해당 컬럼의 평균값을 구한다.
    - number avg(컬럼명)
    - 숫자형 적용 가능
    - 합 / 레코드수 > null 제외 

*/

-- tblInsa. 평균 급여?
select sum(basicpay) / 60 from tblInsa; --1556526
select sum(basicpay) / count(*) from tblInsa; --1556526
select avg(basicpay) from tblInsa; --1556526

-- tblCountry. 평균 인구수?
select sum(population) / 14 from tblCountry; -- 14475
select sum(population) / count(*) from tblCountry; -- 14475
select avg(population) from tblCountry; --15588 다른 이유? null 값 차이 

-- 회사 > 성과급 지급 > 출처 > 1팀 공로
-- 1. 균등 지급 > 총지급액 / 모든 직원수 = sum() / count(*)
-- 2. 차등 지급 > 총지급액 / 1팀 직원수 = sum() / count(1팀) = avg()

/*


    4. max()
    - object max(컬럼명)
    - 최댓값 반환
    
    5. min()
    - object min(컬럼명)
    - 최솟값 반환
    
    - 숫자형, 문자형, 날짜형 모두 적용 가능


*/

select max(basicpay), min(basicpay) from tblInsa;  -- 숫자형
select max(name), min(name) from tblInsa;  -- 문자형
select max(ibsadate), min(ibsadate) from tblInsa;  -- 날짜형

select 
    count(*) as 직원수,
    sum(basicpay) as 총급여합,
    avg(basicpay) as 평균급여,
    max(basicpay) as 최고급여,
    min(basicpay) as 최저급여
from tblInsa;

-- 집계 함수 사용 시 주의점!!!

-- ORA-00937: "not a single-group group function"
-- 컬럼 리스트에서는 집계함수와 일반컬럼을 동시에 사용할 수 없다.

-- 요구사항] 직원들 이름과 총직원수를 가져오시오.
select name, count(*) from tblInsa; 
select name from tblInsa;
select count(*) from tblInsa;

-- 2. ORA-00934: "group function is not allowed here"
-- where절에는 집계 함수를 사용할 수 없다.
-- where절 > 개인(레코드)에 대한 조건절

-- 요구사항] 평균 급여보다 더 많이 받는 직원들?
select avg(basicpay) from tblInsa; --15556526

select * from tblInsa where basicpay >= 1556526;
select * from tblInsa where basicpay >= avg(basicpay);