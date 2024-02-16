-- ### select절 + from절 ###################################

-- 1.tblCountry
-- 모든 행과 모든 컬럼을 가져오시오.
select * from tblCountry;


-- 2.tblCountry
-- 국가명과 수도명을 가져오시오.
select name, capital from tblCountry;


-- 3.tblCountry
-- 아래와 같이 가져오시오
-- [국가명]    [수도명]   [인구수]   [면적]    [대륙] <- 컬럼명(Alias)
-- 대한민국   서울        4403       101       AS     <- 데이터
select
    name as "국가명",
    capital as "수도명",
    population as "인구수",
    area as "면적",
    continent as "대륙"
from tblCountry;


-- 4.tblCountry
-- 아래와 같이 가져오시오
-- [국가정보] <- 컬럼명
-- 국가명: 대한민국, 수도명: 서울, 인구수: 4403   <- 데이터
select
    '국가명: ' || name  || ', 수도명: ' || capital || ', 인구수: ' || population as "국가정보"
from tblCountry;


-- 5.
-- 아래와 같이 가져오시오.employees
-- [이름]       [이메일]         [연락처]     [급여]
-- Steven King  SKING@gmail.com	 515.123.4567 $24000
select
    first_name || ' ' || last_name as "이름",
    email || '@gmail.com' as "이메일",
    phone_number as "연락처",
    '$' || salary as "급여"
from employees;


-- ### where절 ###################################

-- 6.tblCountry
-- 면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
select
    name, area
from tblCountry
    where area <= 100;


-- 7.tblCountry
-- 아시아와 유럽 대륙에 속한 나라를 가져오시오.
select *
from tblCountry
    where continent in ('AS', 'EU');


-- 8.employees
-- 직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
select
    first_name || ' ' || last_name as "name",
    phone_number
from employees
    where job_id = 'IT_PROG';


-- 9.employees
-- last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
select
    first_name || ' ' || last_name as "name",
    phone_number,
    hire_date
from employees
    where last_name = 'Grant';


-- 10.employees
-- 특정 매니저(manager_id: 120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
select
    first_name || ' ' || last_name as "name",
    salary,
    phone_number
from employees
    where manager_id = 120;


-- 11.employees
-- 특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
select
    first_name || ' ' || last_name as "name",
    phone_number,
    email,
    department_id
from employees
    where department_id in (60, 80, 100);


-- 12.tblInsa
-- 기획부 직원들 가져오시오.
select *
from tblInsa
    where buseo = '기획부';


-- 13.tblInsa
-- 서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호 가져오시오.
select
    name, jikwi, tel
from tblInsa
    where jikwi = '부장' and city = '서울';


-- 14.tblInsa
-- 기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
select
    *
from tblInsa
    where (basicpay + sudang) >= 1500000 and city = '서울';


-- 15.tblInsa
-- 수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
select
    *
from tblInsa
    where sudang <= 150000 and jikwi in ('대리', '사원');


-- 16.tblInsa
-- 수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오.
select
    *
from tblInsa
    where (basicpay * 12) >= 20000000 and city = '서울' and jikwi in ('과장', '부장');


-- 17.tblInsa
-- 국가명 'O국'인 나라를 가져오시오.
select
    *
from tblCountry
    where name like '_국';


-- 18.employees
-- 연락처가 515로 시작하는 직원들 가져오시오.
select 
    *
from employees
    where phone_number like '515%';

    
-- 19.employees
-- 직업 ID가 SA로 시작하는 직원들 가져오시오.
select
    *
from employees
    where job_id like 'SA%';
    

-- 20.employees
-- first_name에 'de'가 들어간 직원들 가져오시오.
select
    *
from employees
    where first_name like '%de%';


-- 21.tblInsa
-- 남자 직원만 가져오시오.
select
    *
from tblInsa
    where ssn like '%-1%';


-- 22.tblInsa
-- 여자 직원만 가져오시오.
select
    *
from tblInsa
    where ssn like '%-2%';   


-- 23.tblInsa
-- 여름에(7,8,9월) 태어난 직원들 가져오시오.
select
    *
from tblInsa
    where ssn like '__07%' or  ssn like '__08%' or  ssn like '__09%';


-- 24.tblInsa
-- 서울, 인천에 사는 김씨만 가져오시오.    
select
    *
from tblInsa
    where city in ('서울', '인천') and name like '김%';


-- 25.tblInsa
-- 영업부/총무부/개발부 직원 중 사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.
select
    *
from tblInsa
    where buseo in ('영업부', '총무부', '개발부') and jikwi in ('사원', '대리') and tel like '010%';


-- 26.tblInsa
-- 서울/인천/경기에 살고 입사일이 2008~2010년 사이인 직원들을 가져오시오.
select
    *
from tblInsa
    where city in ('서울', '인천', '경기') and ibsadate between '2008-01-01' and '2010-12-31';


-- 27.employees
-- 부서가 아직 배정 안된 직원들을 가져오시오. (department_id가 없는 직원)
select
    *
from employees
    where department_id is null;

