--ex21_view

/*
View , 뷰
- 데이터베이스 객체 중 하나 (테이블, 제약 사항, 시퀀스, 뷰..)
- 가상 테이블, 뷰 테이블 등..
- 원하는 데이터를 선택해서 사용자 정의를 해놓은 요소
- 테이블처럼 사용한다.(***)
- SQL(select)을 저장하는 객체(**********************)
- 자주 쓰는 select문을 저장한다

사용 목적
1. 자주 쿼리를 저장
2. 복잡하고 긴 쿼리를 저장
3. 저장 객체다 보니, 같이 데이터베이스를 사용하는 사용자끼리 공유 가능 > 재사용 or 협업 가능
(텍스트 쿼리의 단점 > 재사용이 불가함) 
4. 권한 통제 > 보안

create [or replace] view  뷰이름
as 
select 문;


*/ 

create or replace view vwInsa
as -- 연결부(as, is)
select * from tblInsa;

select * from viewInsa; --tblInsa 테이블의 복사본

-- 자주 반복 업무 > '영업부' + '서울' + select

create or replace view 영업부
as
select
    num, name, basicpay, substr(ssn, 8) as gender
    from tblInsa
    where buseo = '영업부' and city = '서울';

select * from 영업부;

-- 비디오 대여점 사장 > 날마다 업무
create or replace view vwCheck
as
select 
    m.name as 회원,
    v.name as 비디오,
    r.rentdate as 언제,
    r.retdate as 반납,
    --g.period as 대여기간,
    r.rentdate + g.period as 반납예정일,
    round(sysdate - (r.rentdate + g.period)) as 연체일,
    round((sysdate - (r.rentdate + g.period)) * g.price * 0.1) as 연체료 -- 수정사항 (다운로드 확인) 
    from tblRent r
    inner join tblVideo v
        on r.video = v.seq
            inner join tblMember m
                on m.seq = r.member
                    inner join tblGenre g
                        on g.seq = v.genre;  


update tblRent set retdate = '2007-02-03' where seq = 2;
update tblRent set retdate = '2007-02-08' where seq = 4;


select * from vwCheck;


create table tblTemp
as
select * from tblInsa;

select * from tblTemp;

-- 서울 직원 뷰
-- 1. select 문 2. create view 생성
create or replace view vwSeoul
as
select * from tblTemp where city = '서울'; -- 20명 <- 뷰 생성 시점

select * from vwSeoul; --20명, 위 명령어 저장(자바의 메서드 같음), 실시간 조회 -- 실명
select * from (select * from tblTemp where city = '서울'); -- 익명 , 동일


-- 원본 테이블 조작(tblTemp)
update tblTemp set city = '제주도' where num in (1001, 1005, 1008);

select * from tblTemp; --  원본 확인

select * from vwSeoul; -- 20명 > 17명







-- 신입 사원 > 업무 > 연락처 확인 > 문자 발송 
select * from tblInsa;

-- 권한 (컬럼 통제 불가, 테이블 통제 가능)
-- 복사테이블 X
create table tblMessage
as 
select name, tel, buseo, jikwi from tblInsa;

select * from tblMessage;  

-- 뷰 O , 정보통제 뷰 권한  
create or replace view vwMessage
as 
select name, tel, buseo, jikwi from tblInsa;

select * from vwMessage;


-- 뷰 사용 주의점!!
-- 1. select > 실행O > 뷰는 읽기 전용으로 사용한다. == 읽기 전용 테이블
-- 2. insert > 실행O > 절대 사용 금지!!
-- 3. update > 실행O > 절대 사용 금지!!
-- 4. delete > 실행O > 절대 사용 금지!!


select * from tblTodo;

-- 단순 뷰 > 뷰의 select가 1개의 테이블로 구성
create or replace view vwTodo
as
select * from tblTodo;
insert into vwTodo values (21, '뷰 만들기', sysdate, null);
update vwTodo set completedate = sysdate where seq = 21;
delete from vwTodo where seq = 21;

-- 복합 뷰 > 뷰의 select가 2개의 테이블로 구성(서브 or 조인 등)
select * from vwCheck;

-- insert into vwCheck (회원, 비디오, 언제, 반납, 반납예정, 연체일, 연체료) XXXXXXXX


/*

    테이블 > 5개(tblMember, tblBoard, tblLog, tblCheck, tblPrice)
    뷰 > 테이블 x N개


*/ 