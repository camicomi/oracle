-- ### decode ###################################


-- 1. tblInsa. 부장 몇명? 과장 몇명? 대리 몇명? 사원 몇명?

select count(decode(jikwi, '부장', 1)) as 부장, count(decode(jikwi, '과장', 1)) as 과장, count(decode(jikwi, '대리', 1)) as 대리, count(decode(jikwi, '사원', 1)) as 사원 from tblInsa;

-- 2. tblInsa. 간부(부장, 과장) 몇명? 사원(대리, 사원) 몇명?

select count(decode(jikwi, '부장', 1, '과장', 2)) as 간부, count(decode(jikwi, '대리', 1, '사원', 2)) as 사원 from tblInsa;

-- 3. tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?

select * from tblInsa;
-- decode 반환값 = basicpay 

select round(avg(basicpay) / count(decode(buseo, '기획부', 1))) as "기획부 평균 급여",
round(avg(basicpay) / count(decode(buseo, '영업부', 1))) as "영업부 평균 급여",
round(avg(basicpay) / count(decode(buseo, '총무부', 1))) as "총무부 평균 급여",
round(avg(basicpay) / count(decode(buseo, '개발부', 1))) as "개발부 평균 급여"
from tblInsa;

select round(avg(decode(buseo, '기획부', basicpay))) as 기획부, round(avg(decode(buseo, '영업부', basicpay))) as 영업부,
round(avg(decode(buseo, '총무부', basicpay))) as 총무부, round(avg(decode(buseo, '개발부', basicpay))) as 개발부
from tblInsa;

-- 4. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생?

-- substr 사용
-- substr (컬럼명, 시작위치, 가져올 문자개수)
select * from tblInsa where ssn like '%-1%' order by ssn;


-- 바꿀문자열을 생략해도 되네? 이해했다 컬럼명 자리 > substr(ssn, 8, 1)
select 
'19' || min(decode(substr(ssn, 8, 1), '1', substr(ssn, 1, 2))) as 남자,
'19' || max(decode(substr(ssn, 8, 1), '2', substr(ssn, 1, 2))) as 여자
from tblInsa;