-- ex20_join.sql

/*

    관계형 데이터베이스 시스템이 지양하는 것들
    - 테이블을 다시 수정해야 고쳐지는 것들 > 구조적 문제!!
   
   1. 테이블에 기본키가 없는 상태 > 데이터 조작 불가능(레코드 식별 불가능)
   2. null이 많은 상태의 테이블 > 공간 낭비 + SQL 작업 불편
   3. 데이터가 중복되는 상태 > 공간 낭비 + 데이터 조작 문제 발생(일관성 저하)
   4. 하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다. (99, 90, 77  X)
   
   


*/

-- 직원정보
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create table tblStaff (
    seq number primary key,         -- 직원번호(PK)
    name varchar2(30) not null,     -- 직원명
    salary number not null,         -- 급여
    address varchar2(300) not null, -- 거주지
    project varchar2(300)           -- 담당프로젝트
);

insert into tblStaff (seq, name, salary, address, project)
values (1, '홍길동', 300, '서울시', '홍콩 수출');

insert into tblStaff (seq, name, salary, address, project)
values (2, '아무개', 250, '인천시', 'TV 광고');

insert into tblStaff (seq, name, salary, address, project)
values (3, '하하하', 350, '의정부시', '매출 분석');

select * from tblStaff;

-- '홍길동'에게 담당 프로젝트가 1건 추가 > '고객 관리'
-- 홍콩 수출 + 고객 관리
update tblStaff set
project = project || ',고객관리'
where seq = 1;

-- 데이터 중복
insert into tblStaff (seq, name, salary, address, project)
values (4, '홍길동', 300, '서울시', '고객관리');

insert into tblStaff (seq, name, salary, address, project)
values (5, '호호호', 250, '서울시', '게시판 관리, 회원 응대');

insert into tblStaff (seq, name, salary, address, project)
values (6, '후후후', 250, '부산시', '불량 회원 응대');

select * from tblStaff;

-- '회원 응대' > 담당자?
select * from tblStaff where project = '회원 응대'; -- X
select * from tblStaff where project like '%회원 응대%'; -- 정확한 담당자를 찾기 어려움

-- 원인 : 테이블 스키마(구조)가 잘못된 상태
-- 해결 : 테이블 재구성
drop table tblStaff;
drop table tblProject;

-- 참조 방향 결정
-- : 테이블(레코드) 생성 시간을 고려

-- 자식이 부모를 참조할 수 있듯이,  나중에 태어난 데이터가 먼저 태어난 데이터를 참조 

--  문제가 되는 테이블을 독립적으로 생성

-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지)
create table tblStaff(
    seq number primary key,         -- 직원번호(PK)
    name varchar2(30) not null,     -- 직원명
    salary number not null,         -- 급여
    address varchar2(300) not null -- 거주지
);

-- 프로젝트(번호(PK), 담당 프로젝트, 담당 직원 번호)   

create table tblProject(

    seq number primary key,  -- 프로젝트번호(PK)
    project varchar2(100) not null, -- 프로젝트명
    staff_seq number not null   -- 담당직원번호

);

insert into tblStaff (seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff (seq, name, salary, address) values (2, '아무개', 250, '인천시');
insert into tblStaff (seq, name, salary, address) values (3, '하하하', 350, '부산시');

insert into tblProject (seq, project, staff_seq) values (1, '홍콩 수출', 1); --홍길동
insert into tblProject (seq, project, staff_seq) values (2, 'TV 광고', 2); --아무개
insert into tblProject (seq, project, staff_seq) values (3, '매출 분석', 3); --하하하
insert into tblProject (seq, project, staff_seq) values (4, '노조 협상', 1); --홍길동
insert into tblProject (seq, project, staff_seq) values (5, '대리점 분양', 2); --아무개

select * from tblStaff;
select * from tblProject;

-- 'TV 광고' 담당자?
-- 2	TV 광고	2
select * from tblProject where project = 'TV 광고';
select * from tblStaff where seq = 2;

select * from tblStaff where seq = (select staff_seq from tblProject where project = 'TV 광고');

-- A. 신입 사원 입사 > 신규 프로젝트 배정
-- A.1  신입 사원 추가(O)
insert into tblStaff (seq, name, salary, address) values (4, '호호호', 250, '성남시');

select * from tblStaff;

--  A.2 신규 프로젝트 배경(O)
insert into tblProject (seq, project, staff_seq) values (6, '자재 매입', 4);

select * from tblProject;

-- A.3 신규 프로젝트 추가 > 존재하지 않음에도 에러 (X) > 논리 오류 !! 
-- ORA-02291: 무결성 제약조건(HR.SYS_C008487)이 위배되었습니다- 부모 키가 없습니다
insert into tblProject (seq, project, staff_seq) values (7, '고객 유치', 5);

select * from tblStaff where seq = (select staff_seq from tblProject where project = '고객 유치');

-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제 > 에러(X) > 논리 에러
-- ORA-02292: 무결성 제약조건(HR.SYS_C008487)이 위배되었습니다- 자식 레코드가 발견되었습니다
delete from tblStaff where seq = 1;

-- B.2 '홍길동' 삭제 > 업무 인수 인계(위임)
update tblProject set staff_seq = 2 where staff_seq = 1;

-- B.3 '홍길동' 삭제 
delete from tblStaff where seq = 1;

select * from tblStaff;
select * from tblProject;






-- 직원정보
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create table tblStaff (
    seq number primary key,         -- 직원번호(PK)
    name varchar2(30) not null,     -- 직원명
    salary number not null,         -- 급여
    address varchar2(300) not null, -- 거주지
    project varchar2(300)           -- 담당프로젝트
); --  부모테이블


-- 프로젝트(번호(PK), 담당 프로젝트, 담당 직원 번호)   

create table tblProject(

    seq number primary key,  -- 프로젝트번호(PK)
    project varchar2(100) not null, -- 프로젝트명
    staff_seq number not null references tblStaff(seq)   -- 담당직원번호(FK)

); -- 자식테이블

-- drop table tblStaff; 불가 ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다 
-- drop table tblProject;  > drop table tblStaff;   자식> 부모



-- eXERD 설계도 만드는 프로그램 
-- 2개
-- 고객 테이블
create table tblCustomer (
    seq number primary key,             -- 고객번호(PK)
    name varchar2(30) not null,         -- 고객명
    tel varchar2(15) not null,          -- 연락처
    address varchar2(100) not null      -- 주소

);

-- 판매내역 테이블
create table tblSales (
    seq number primary key,                         -- 판매번호(PK)
    item varchar2(50) not null,                     -- 제품명
    qty number not null,                            -- 수량
    regdate date default sysdate not null,          -- 판매날짜
    cseq number not null references tblCustomer(seq)  -- 고객번호(FK) 

);

-- 4개

-- 장르
create table tblGenre (
    seq number primary key,     -- 장르번호(PK)
    name varchar2(30) not null, -- 장르명
    price number not null,      -- 대여가격
    period number not null      -- 대여기간(일)
);

-- 비디오
create table tblVideo (
    seq number primary key,     -- 비디오번호(PK)
    name varchar2(100) not null, -- 제목
    qty number not null,        -- 수량
    company varchar2(50) null,  -- 제작사
    director varchar2(50) null, -- 감독
    major varchar2(50) null,    --  주연배우
    genre number not null references tblGenre(seq) -- 장르번호(FK)
);

-- 회원 테이블
create table tblMember (
    seq number primary key,     -- 회원번호(PK)
    name varchar2(30) not null, -- 고객명
    grade number(1) not null,   -- 회원등급(1,2,3)
    byear number(4) not null,   -- 생년
    tel varchar2(15) not null,  -- 연락처
    address varchar2(300) null, -- 주소
    money number not null       -- 예치금
);

-- 대여
create table tblRent (
    seq number primary key,     -- 대여번호(PK)
    member number not null references tblMember(seq),   -- 회원번호(FK)
    video number not null references tblVideo(seq),     -- 비디오번호(FK)
    rentdate date default sysdate not null,             -- 대여시각
    retdate date null,                                  -- 반납시각
    remart varchar2(500) null                           -- 비고
);

-- 다운로드 customer.vide.data.sql

create sequence genreSeq;
create sequence videoSeq;
create sequence memberSeq;
create sequence rentSeq;

-- 데이터 파일 실행

select * from tblCustomer;
select * from tblSales;

select * from tblGenre;
select * from tblVideo;
select * from tblMember;
select * from tblRent;

-- 안되면, 인덱스 변경(...Seq.NEXTVAL > 숫자)


/*

    조인, Join
    - (서로 관계를 맺은) 2개(1개) 이상의 테이블을 1개의 결과셋으로 만드는 기술
    
    
    조인의 종류
    1. 단순 조인, cross join
    2. 내부 조인, inner join ***
    3. 외부 조인, outer join ***
    4. 셀프 조인, self join
    5. 전체 외부 조인, full outer join
    
    1. 단순 조인, cross join, 카티션 곱, 데카르드 곱
    - 모든 조인의 기본 동작
    - A 테이블 X B 테이블
    - 쓸모없다 > 가치 있는 행과 가치 없는 행이 뒤섞여 있어서
    - 다량 더미 데이터 생성시(유효성 낮음)
    

*/


select * from tblCustomer; -- 3 명
select * from tblSales; -- 9건

select * from tblCustomer cross join tblSales; --ANSI-SQL(수업)
select * from tblCustomer, tblSales; --Oracle 전용

/*

    2. 내부 조인, inner join ***
    - 단순 조인에서 유효한 레코드만 추출한 조인
    
    select 컬럼리스트 from 테이블A cross join 테이블B;
    
    select 컬럼리스트 from 테이블A inner join 테이블B on 테이블A.PK = 테이블B.FK;

    select 
        컬럼리스트 
    from 테이블A
        inner join 테이블B
            on 테이블A.PK = 테이블B.FK;

*/

-- ORA-00905: 누락된 키워드
select * from tblCustomer inner join tblSales; -- 조건절 필요 PK = FK


select * from tblCustomer inner join tblSales on tblCustomer.seq = tblSales.cseq;

-- ORA-00918: 열의 정의가 애매합니다  seq가 Sales 에도 있어서
select
    seq
from tblCustomer 
    inner join tblSales
        on tblCustomer.seq = tblSales.cseq;
        
        
select
    c.seq as 고객번호,
    s.seq as 판매번호,
    c.name
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;
-- 테이블의 별칭은 외자로 작성한다


-- 고객 테이블 + 판매 테이블
-- > 어떤 고객(c.name)이 어떤 물건(s.item)을 몇개(s.qty) 사갔습니까?
select
    c.name as 고객명,
    s.item as 제품명,
    s.qty as 수량
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;
        
-- 조인은 선으로 연결된 것들끼리 

-- 조인 vs 서브쿼리
-- > 어떤 고객(c.name)이 어떤 물건(s.item)을 몇개(s.qty) 사갔습니까?
-- 메인 쿼리(자식테이블) + 상관 서브쿼리(부모테이블)

select
    item,
    qty,
    cseq,
    (select name from tblCustomer where seq = tblSales.cseq)
from tblSales;


-- 비디오 + 장르 조인
select
    *
from tblGenre g -- 부모 (순서는 상관없지만, 나중에를 위해)
    inner join tblVideo v -- 자식
        on g.seq = v.genre;
        
-- 비디오 + 장르 + 대여 조인
select
    *
from tblGenre g 
    inner join tblVideo v 
        on g.seq = v.genre
            inner join tblRent r
                on r.video = v.seq;
                
                
-- 비디오 + 장르 + 대여 + 회원 조인
select
    m.name as 누가,
    v.name as 무엇을,
    r.rentdate as 언제,
    g.price as 얼마
from tblGenre g 
    inner join tblVideo v 
        on g.seq = v.genre
            inner join tblRent r
                on r.video = v.seq
                    inner join tblMember m
                        on m.seq = r.member;
                        
                        

----

select
    e.first_name || ' ' || e.last_name as 직원명,
    d.department_name as 부서명,
    l.city as 도시명,
    c.country_name as 국가명,
    r.region_name as 대륙명,
    j.job_title as 직업명
from employees e
    inner join departments d
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j
                                        on j.job_id = e.job_id;
                                        
                                        


/*


    3. 외부 조인, outer join ***
    - 내부 조인의 반댓말(X)
    - 내부 조인 결과 + a(내부 조인에 포함되지 않은 부모 테이블의 나머지 레코드)
    
    select 
        컬럼리스트
        from 테이블A
            inner join 테이블B
                on 테이블A.PK = 테이블B.FK;
                
    

    select 
        컬럼리스트
        from 테이블A (left|right) outer join 테이블B  // left 테이블 A, right 테이블 B
                on 테이블A.PK = 테이블B.FK;

*/

select * from tblCustomer; -- 3명
select * from tblSales; -- 9건

insert into tblCustomer values (4, '호호호', '010-1234-5678', '서울시');
insert into tblCustomer values (5, '후후후', '010-1234-5678', '서울시');


-- 내부 조인
-- > 물건을 한번이라도 구매한 이력이 있는 고객의 정보와 구매내역을 가져오시오.
select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;
        
-- 외부조인
-- > 물건을 한번이라도 구매한 이력이 있는 고객의 정보와 구매내역을 가져오시오. 
-- > 물건을 한번도 구매 안한 고객의 정보까지 같이 가져오시오.
select * from tblCustomer c
    left outer join tblSales s   -- 보편적으로 부모 테이블을 가르킨다 
        on c.seq = s.cseq;
        
        
select * from tblStaff; -- 3명
select * from tblProject; -- 6건

-- 부모 데이터가 100% 참조되어 있으면, inner , outer  차이 없으므로..

update tblProject set staff_seq = 4 where staff_seq = 3;

-- 내부조인 > 프로젝트를  최소 1건 이상 담당하고 있는 직원 + 프로젝트정보
select 
    *
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;
        
-- 외부조인 > 담당 프로젝트 유무와 상관없이 모든 직원을 가져오시오. + 프로젝트 정보

select
    *
from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;
        
-- 비디오 + 대여 > 대여가 한번이라도 발생했던 비디오 + 대여기록

select
    *
from tblVideo v
    inner join tblRent r
        on v.seq = r.video;
        
-- 비디오 + 대여 > 대여와 상관없이 모든 비디오 + 대여기록

select
    *
from tblVideo v
    left outer join tblRent r
        on v.seq = r.video;
        
        
-- 회원 + 대여 > 대여를 최소 1회 이상 했던 회원 + 대여 내역

select
    *
from tblMember m
    inner join tblRent r
        on m.seq = r.member;
        
-- 회원 + 대여 > 대여와 무관하게 모든 회원 + 대여 내역

select
    *
from tblMember m
    left outer join tblRent r
        on m.seq = r.member
            where r.seq is null; -- 회원가입만 하고 대여는 안한 회원
            
            
-- 대여 기록이 있는 회원의 이름과 연락처?
select distinct m.name, m.tel from tblMember m
    inner join tblRent r
        on m.seq = r.member;
        
-- 대여 기록이 있는 회원의 이름과 연락처? + 대여 횟수(group by)?
select m.name, 
(select tel from tblMember where name = m.name), 
count(*) from tblMember m
    inner join tblRent r
        on m.seq = r.member
            group by m.name;
            
            
select m.name, m.tel, count(*) from tblMember m
    inner join tblRent r
        on m.seq = r.member
            group by m.name, m.tel;
            

select m.name, m.tel, count(*) from tblMember m
    inner join tblRent r
        on m.seq = r.member
            group by m.name, m.tel
                order by count(*) asc;     
                
                
/*

    1. 단순조인
    2. 내부조인
    3. 외부조인
    ===============
    1. 셀프조인 + 내부조인
    2. 셀프조인 + 외부조인

    4. 셀프 조인, self join
    - 1개의 테이블을 사용하는 조인 
    - 테이블의 자기 스스로와 관계를 맺는 경우에 사용
    


*/

-- 직원 테이블 
create table tblSelf (
    seq number primary key,             -- 직원번호(PK)
    name varchar2(30) not null,         -- 직원명
    department varchar2(30) not null,   -- 부서명
    super number null references tblSelf(seq) -- 상사번호(FK)
);

insert into tblSelf values (1, '홍사장', '사장실', null);
insert into tblSelf values (2, '김부장', '영업부', 1);
insert into tblSelf values (3, '박과장', '영업부', 2);
insert into tblSelf values (4, '최대리', '영업부', 3);
insert into tblSelf values (5, '정사원', '영업부', 4);
insert into tblSelf values (6, '이부장', '개발부', 1);
insert into tblSelf values (7, '하과장', '개발부', 6);
insert into tblSelf values (8, '신과장', '개발부', 6);
insert into tblSelf values (9, '황대리', '개발부', 7);
insert into tblSelf values (10, '허사원', '개발부', 9);

-- 직원 명단을 가져오시오. 단, 상사의 이름까지
-- 1. join
-- 2. sub query 
-- 3. 계층형 쿼리(오라클 전용)

-- as 필수 

select 
s2.name as 직원명,
s2.department as 부서명,
s1.name as 상사명
from tblSelf s1        -- 역할 : 부모테이블 > 상사
    inner join tblSelf s2       -- 역할 : 자식테이블 > 직원
        on s1.seq = s2.super;
        
        

select 
s2.name as 직원명,
s2.department as 부서명,
s1.name as 상사명
from tblSelf s1       
    right outer join tblSelf s2       
        on s1.seq = s2.super;
        
        

select name as 직원명, 
department as 부서명,
(select name from tblSelf s1 where seq = s2.super) as  상사명 
from tblSelf s2; -- 직원테이블



/*


    5. 전체 외부 조인, full outer join
    - 서로 참조하고 있는 관계에서 사용
    


*/

select * from tblMen;   --  부모
select * from tblWomen;  -- 자식

-- 커플인 남/녀를 가져오시오.
select 
m.name as 남자,
w.name as 여자
from tblMen m
    inner join tblWomen w
        on m.name = w.couple;
        
-- 

select 
m.name as 남자,
w.name as 여자
from tblMen m
    right outer join tblWomen w
        on m.name = w.couple;
        
        
select 
m.name as 남자,
w.name as 여자
from tblMen m
    full outer join tblWomen w
        on m.name = w.couple;
        
        
        
drop table tblStaff;
drop table tblProject;

create table tblStaff(
    seq number primary key,         -- 직원번호(PK)
    name varchar2(30) not null,     -- 직원명
    salary number not null,         -- 급여
    address varchar2(300) not null -- 거주지
);
 

create table tblProject(

    seq number primary key,  -- 프로젝트번호(PK)
    project varchar2(100) not null, -- 프로젝트명
    staff_seq number null   -- 담당직원번호

);

insert into tblStaff (seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff (seq, name, salary, address) values (2, '아무개', 250, '인천시');
insert into tblStaff (seq, name, salary, address) values (3, '하하하', 350, '부산시');

insert into tblProject (seq, project, staff_seq) values (1, '홍콩 수출', 1); --홍길동
insert into tblProject (seq, project, staff_seq) values (2, 'TV 광고', 2); --아무개
insert into tblProject (seq, project, staff_seq) values (3, '매출 분석', 3); --하하하
insert into tblProject (seq, project, staff_seq) values (4, '노조 협상', 1); --홍길동
insert into tblProject (seq, project, staff_seq) values (5, '대리점 분양', 2); --아무개

-- 추가, 담당자 미정
insert into tblStaff (seq, name, salary, address) values (4, '호호호', 250, '인천시');
insert into tblStaff (seq, name, salary, address) values (5, '후후후', 350, '부산시');

insert into tblProject (seq, project, staff_seq) values (6, '재고 관리', null); 
insert into tblProject (seq, project, staff_seq) values (7, '가격 인상', null); 
insert into tblProject (seq, project, staff_seq) values (8, '신제품 개발', null); 

select * from tblStaff;
select * from tblProject;

select * from tblStaff s inner join tblProject p on s.seq = p.staff_seq;

select * from tblStaff s left outer join tblProject p on s.seq = p.staff_seq;
select * from tblStaff s right outer join tblProject p on s.seq = p.staff_seq;

select * from tblStaff s full outer join tblProject p on s.seq = p.staff_seq;

