-- 10.

/*

문자열 함수

대소문자 변환
- upper(), lower(), initcap()
- varchar2 upper(컬럼명)
- varchar2 lower(컬럼명)
- varchar2 initcap(칼럼명)

*/ 

select
    first_name,
    upper(first_name),
    lower(first_name),
    initcap(first_name)
from employees;

select
    'abc', initcap('abc')
from dual;

-- 이름(first_name)에 'an' 포함된 직원? > 대소문자 구분없이

select
    first_name
from employees
    -- where first_name like '%an%' or first_name like '%AN%' 
    --          or first_name like '%An%' or first_name like '%aN%';
    where upper(first_name) like '%AN%';
    

/*

     문자열 추출 함수
     - substr()
     - varchar2 substr(컬럼명, 시작위치, 가져올 문자 개수)
     - varchar2 substr(컬럼명, 시작위치)

*/

select 
    name,
    substr(name, 1, 2)
    substr(name, 1)
    from tblCountry;