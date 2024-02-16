-- ex09_numerical_function.sql

/*


    숫자 함수
    - 수학 함수
    - Math.XXX()
    
    round()
    - 반올림함수
    - number round(컬럼명) :  정수 반환
    - number round(컬럼명, 소수이하 자릿수): 실수 반환
    


*/

select round(avg(basicpay)) from tblInsa; --1556527

select round(avg(basicpay), 1) from tblInsa; --1556526.7

select * from dual; -- 시스템 테이블 > 1행 테이블(***) 

select sysdate from tblInsa where num = 1001;

select sysdate from dual; -- 일종의 임시테이블 

select 
    3.5678,
    round(3.5678),
    round(3.5678, 1),
    round(3.5678, 2),
    round(3.5678, 3),
    round(3.5678, 0)

from dual;

/*


    floor(), trunc()
    - 절삭 함수
    - 무조건 내림 함수
    - number floor(컬럼명) : 정수 반환
    - number trunc(컬럼명) : 정수 반환
    - number trunc(컬럼명, 소수이하 자릿수) : 실수 반환

*/

select
    3.5678,
    floor(3.5678),
    trunc(3.5678),
    trunc(3.5678, 1),
    trunc(3.5678, 2),
    round(3.5678)
from dual;



/*
    ceil()
    - 무조건 올림 함수
    - 천장
    - number ceil(컬럼명)


*/

select 
    3.14,
    ceil(3.14)
from dual;


select
    ceil(3.000000000000000001),
    floor(3.99999999999999999)
from dual;


/*


    mod()
    - 나머지 함수
    - number mod(피제수, 제수)


*/

select
    10 / 3,
    mod(10, 3) as 나머지,
    floor(10 / 3) as 몫
from dual;

select
    abs(10), abs(-10),
    power(2, 2), power(2, 3), power(2, 4),
    sqrt(4), sqrt(9), sqrt(16)
from dual;

-- 책 챕터 2 , 6, 7

/*

    학사 관리 시스템
    
    1. 데이터 수집
        - 학생명, 강의실, 성적, 주소, 교수, 행정직원...
        
    2. 데이터 분류(관계)
        - 학생명, 주소, 나이, 연락처
        - 강의실, 호수, 총인원수
        - 교수명, 연락처, 담당과목
        
    3. 릴레이션 표현
        - 학생(학생명, 주소, 나이, 연락처)
        - 도메인
            - 학생명 : 2~3자 이내의 한글
            - 주소 : 도로명 주소
            - 나이 : 1이상의 정수
            - 연락처 : 전화번호
    
    4. 릴레이션 인스턴스(=레코드, 튜플)
        - 홍길동, 서울시, 20, 010-1234-5678
        
    5. 카디널리티 = 튜플의 개수 = 레코드의 개수 = 행 개수

*/ 