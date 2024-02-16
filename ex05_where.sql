-- ex05_where.sql

/*

      [WITH <Sub Query>]
        SELECT column_list
        FROM table_name
        [WHERE search_condition]
        [GROUP BY group_by_expression]
        [HAVING search_condition]
        [ORDER BY order_expression [ASC|DESC]];
        
        실행 순서를 반드시 알고 있어야 셀렉문을 잘 사용할 수 있다 
        
        SELECT 컬럼리스트 3. 컬럼 지정 (보고 싶은 컬럼만 가져오기) > Projection
        FROM 테이블     1.  테이블 지정
        WHERE 검색조건;  2. 조건 지정 (보고 싶은 행만 가져오기) > Selection
        
        where절 
        - 레코드(행)을 검색한다.
        - 원하는 레코드만 추출 > 결과셋 생성


*/

-- 자바의 for 문처럼

select name, height -- 열을 추출
from tblMen
where height >= 180; -- 행을 추출


select
    *
from tblCountry
    where capital = '서울';

select
    *
from tblCountry
    where capital <> '서울';
    
select
    *
from tblCountry
    where population >= 5000;
    
select
    *
from tblCountry
    where continent = 'AS' or continent = 'AF';
    

-- tblComedian
-- select * from tblComedian;
-- 1. 몸무게가 60kg 이상이고, 키가 170cm 미만인 사람을 가져오시오.

select *
from tblComedian where weight >= 60 and height < 170;

-- 2. 몸무게가 70kg 이하인 여자만 가져오시오.
select *
from tblComedian where weight <= 70 and gender = 'f';

-- tblInsa
-- select * from tblInsa; 
-- 3. 부서가 '개발부'이고, 급여가 150만원 이상 받는 직원을 가져오시오.
select * from tblInsa where buseo = '개발부' and basicpay >= 1500000;

-- 4. 급여 + 수당을 합한 금액이 200만원 이상 받는 직원을 가져오시오. 
select * from tblInsa where basicpay + sudang >= 2000000;



/*

    between
    - where 절에서 사용 > 조건으로 사용
    - 컬럼명 between 최솟값 and 촤댓값
    - 범위 조건
    - 가독성 향상
    - 최솟값, 최댓값 포함 O


*/ 

select * from tblInsa where basicpay >= 1000000 and basicpay <= 1200000;

select * from tblInsa where basicpay <= 1200000 and basicpay >= 1000000;
select * from tblInsa where 1200000 >= basipay and basicpay >= 1000000;

select * from tblInsa where basicpay between 1100000 and 1320000;  

/*
    SQL 실행과정
    
    [사람] <-> [SQL Developer] <-> [Oracle Database] <-> [Table(Data)]
    
    - 실행 비용이 횟수와 상관없이 항상 동일하다.(*****)
    
    1.  접속
        - 호스트명 : 접속할 오라클 서버의  IP  주소(or   도메인명) > "localhost"
        - 포트번호 : "1521"
        - SID : "xe"
        - 사용자명 : "hr"
        - 암호 : "java1234"
    2. SQL 작성 >  SQL Developer 에서
        - "select * from tblCountry;" 작성
        - 실행 > Ctrl + Enter > 해당 SQL를 오라클 서버에게 전송하는 역할(***)
    3. 오라클 서버에서
        - 전달받은 SQL을 수신
        - 구문 분석(파싱)
        - 컴파일
        - SQL 실행 > 데이터 읽기 > 결과셋(서버 메모리)
        - 결과셋 > 클라이언트에게 반환
        
    4. SQL  Developer 에서
        - 결과셋 > 출력

*/
select * from tblCountry;


-- 비교 연산
-- 1. 숫자형
select * from tblInsa where basicpay >= 1000000 and basicpay <=1200000;
select * from tblInsa where basicpay between 1000000 and 1200000;

-- 2. 문자형(문자코드)
select * from tblInsa where name >= '이순신'; --name.compareTo('이순신')
select * from employees where first_name >= 'J' and first_name <= 'L';
select * from employees where first_name between 'J' and 'L';

-- 3. 날짜시간형 (문자열) 
select * from tblInsa where ibsadate > '2010-01-01';
select * from tblInsa where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31';
select * from tblInsa where ibsadate between '2010-01-01' and '2010-12-31';

/*

    in
    - where절에서 사용 > 조건으로 사용
    - 열거형 조건
    - 컬럼명 in (값, 값, 값)
    - 가독성 향상
    
*/

-- tblInsa.개발부 + 총무부 + 홍보부
select * from tblInsa where buseo = '개발부' or buseo = '총무부' or buseo = '홍보부';
select * from tblInsa where buseo in ('개발부', '총무부', '홍보부');

-- 서울 or 인천 + 과장 or 부장 + 급여(250~300)
select * from tblInsa
    where city in ('서울', '인천')
        and jikwi in ('과장', '부장')
        and basicpay between 2500000 and 3000000;

desc tblInsa;

/*

    like
    - where절에서 사용 > 조건으로 사용
    - 패턴 비교
    - 컬럼명 like '패턴 문자열'
    - 정규식의 초간단 버전
    
    패턴 문자열의 구성요소
    1. _ : 임의의 문자 1개(.)
    2. % " 임의의 문자 N개. 0~무한대(.*) 

*/
-- 김OO
select name from tblInsa;
select name from tblInsa where name like '김__';
select name from tblInsa where name like '_길_';
select name from tblInsa where name like '__수';
select name from tblInsa where name like '_수'; -- 아무도 못찾음

select * from employees where first_name like 'S_____';


select name from tblInsa where name like '김%';
select name from tblInsa where name like '%동';
select name from tblInsa where name like '%수%';

select * from tblInsa where ssn like '_____-2_____';
select * from tblInsa where ssn like '%-2%';

/*

RDBMS에서의 null
- 컬럼값(셀)이 비어있는 상태
- null 상수 제공
- 대부분의 언어는  null은 연산의 대상이 될 수 없다.(********)


    null 조건
    - where절에서 사용
    - 컬럼명 is null
    - 컬럼명 is not null


*/ 

-- 인구수가 미기재된 나라?
select * from tblCountry where population = null;  -- X
select * from tblCountry where population is null; 

-- 인구수가 기재된 나라?
select * from tblCountry where population <> null; -- X
select * from tblCountry where not population is null; 
select * from tblCountry where population is not null;  -- ***

-- 연락처가 없는 직원?
select * from tblInsa where tel is null;
select * from tblInsa where tel is not null;

-- 실행 완료한 일? 
select * from tblTodo where completedate is not null;

-- 실행 미완료한 일?
select * from tblTodo where completedate is null;

-- 도서관 > 대여 테이블(컬럼 : 대여날짜, 반납날짜)

-- 아직 반납을 안한 사람?
select * from 대여 where 반납날짜 is null;

-- 반납이 완료된 사람?
select * from 대여 where 반납날짜 is not null;
