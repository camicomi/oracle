-- ex03_select.sql

/*

        SQL 
        - Query 
        - 시퀄(SEQUEL)
        
        
        SELECT문
        - DML, DQL 
        - SQL은 SELECT로 시작해서 SELECT로 끝난다. 
        - CRUD
        - 데이터베이스의 테이블로부터 데이터를 가져오는 명령어(읽기, 조회)
        
        * [] 절은  필요에 따라 적을 수 있고, 안적을수도 있다
        [WITH <Sub Query>]
        SELECT column_list
        FROM table_name
        [WHERE search_condition]
        [GROUP BY group_by_expression]
        [HAVING search_condition]
        [ORDER BY order_expression [ASC|DESC]];
        
        
        
        SELECT column_list -- 원하는 컬럼을 지정 > 해당 컬럼만 가져와라.
        FROM table_name -- 데이터 소스. 어떤 테이블로부터 데이터를 가져와라.

        각 절의 실행 순서
        2. SELECT
        1. FROM

*/
-- 두개의 절로 생성
select * -- 모든 컬럼
from tblType;  

-- HR > EMPLOYEES

-- 테이블구조 보기
desc employees;

select * from employees;

select *
from employees;

select * from tblCountry; -- 14
select * from tblComedian; -- 10
select * from tblDiary; -- 10 
select * from tblInsa; -- 60
select * from tblMen; -- 10
select * from tblWomen; -- 10 
select * from tblTodo; -- 20

-- select >  결과 테이블(Result Table, ResultSet)
select *  -- 모든 컬럼
from tblCountry;

select name -- 단일 컬럼
from tblCountry;

select capital, name -- 다중 컬럼 > 컬럼 순서 > 자유롭게
from tblCountry;

select
    name, length(name)
from tblCountry;

-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
-- 00942. 00000 -  "table or view does not exist"
select
    name, length(name)
from tblCountr;

-- ORA-00904: "NAM": 부적합한 식별자
-- 00904. 00000 - "%s: invalid identifier"
select
    nam, length(name)
from tblCountry;