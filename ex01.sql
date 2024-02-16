/*

Database   과목
- 각종 프로그램
    - Oracle 
    - MS-SQL
    - DB2
    - MySQL
    - MariaDB
    - PostreSQL
    - SQLite
    - MS Access
 
  자바는 오라클하고 연동하는 경우가 많다
  
    Oracle Database 1.0 
    ~
    Oracle Database 9i
    Oracle Database 11g 많이 쓰임
    Oracle Database 18c  많이 쓰임
    ~
    Oracle Database 23c
    
    
    Oracle Database 11g Enterprise Edition(기업용)
    Oracle Database 11g Express Edition(무료) > CPU 1,  최대 가용 메모리 1GB
    
    
    오라클(데이터베이스) <-> SQL Developer(클라이언트) <-> SQL <-> 사람
    SQL, Structured Query Language
    - 구조화된 질의 언어
    - 데이터베이스와 대화를 하기 위한 언어
    
    오라클 시스템 +  SQL 언어 
    
    1. 데이터베이스 관리자, DBA
        -  모든 것
    
    2. 데이터베이스 개발자
        - 모든 것
    
    3. 응용 프로그램 개발자(= 자바 개발자)
        - 모든 것 or 일부 내용 >  SQL  언어
    
    
    SQL 
    1. 데이터베이스 제작사와 독립적이다. 
        - 모든 데이터베이스에서 공통적으로 사용하기 위해 만들어진 언어
        - DB 제작사에서  SQL라는 언어를 자신의 제품을 적용
    2. 표준 SQL, ANSI-SQL
        - 모든 DB에 적용 가능한 SQL
        
    3. 제조사별  SQL
        - 특정  DB 에만 적용 가능한 SQL 
        - Oracle > PL/SQL
        - MS-SQL > T-SQL
        
     오라클 =  ANSI-SQL(60%) + DB 설계(10%)+ PL/SQL(30%)
     
     
     관계형 데이터베이스, Relational Database, RDB
     - 데이터를 표 형식으로 저장/관리한다.
     - SQL를 사용한다. 
     
     오라클
     - 데이터베이스(데이터의 집합) + 데이터베이스 관리 시스템 > Relational Database Management System
     - RDBMS
     
     ANSI-SQL
     1. DDL
        - Data Definition Language
        -  데이터 정의어
        - 테이블, 뷰, 사용자, 인덱스 등의 데이터베이스 오브젝트(객체)를 생성/수정/삭제하는 명령어
        - 구조를 생성/관리하는 명령어
        a. create : 생성
        b. drop : 삭제
        c. alter : 수정
        
        - 데이터베이스 관리자
        - 데이터베이스 개발자
        - 프로그래머(일부)
     
     2. DML
        - Data Manipulation Language
        - 데이터 조작어
        - 데이터를 추가/수정/삭제/조회하는 명령어
        - CRUD 
        - 사용빈도가 가장 높음
        a. select :  조회(읽기) > [R]ead
        b. insert : 추가(생성) > [C]reate
        c. update :  수정 > [U]date
        d. delete : 삭제 > [D]elete
        
        - 데이터베이스 관리자
        - 데이터베이스 개발자
        - 프로그래머(*********************) 
     
     3. DCL
     
        - Data Control Language 
        - 데이터 제어어
        - 계정 관리, 보안 관리, 트랜잭션 처리 등.. 
        a. commit
        b. rollback
        c. grant
        d. revoke
        
        - 데이터베이스 관리자
        - 데이터베이스 담당자
        - 프로그래머(일부)
     
     4. DQL
        - Data Query Language
        - DML  중에서 select 문을 따로 부르는 표현
     
     5. TCL
        - Transaction Control Language
        - DCL  중에서 commit, rollback 문을 따로 부르는 표현
        
        오라클 인코딩
        - 1.0 ~ 8 : EUC-KR
        - 9.i ~ 현재 :  UTF-8


        SQL > 대소문자를 구분하지 않는다.
        -  파란색 > 키워드(문법)
        - 검은색 > 식별자
        select * from tabs;
        SELECT * FROM TABS;
        
        *** 데이터(상수)는 대소문자를 구분한다.
        select * from tabs where table_name = 'JOBS';
        select * from tabs where table_name = 'jobs'; ( 못찾는다) 
        
        Alt + ' >  대소문자 변경 
        
        SELECT * FROM tabs ( 흔히 보는 스타일)

         Ctrl + space  미리보기
         
         우리는 전부 소문자로 하자
         
         책 가져오기...헐 
         
         새파일 만들기 
         오른쪽 클릭 > SQL 워크시트 열기
         

*/

select * from tabs;
SELECT * FROM TABS;
select * from tabs where table_name = 'JOBS';
select * from tabs where table_name = 'jobs';













