-- ex14_sequence.sql

/*


     시퀀스, Sequence
     - 데이터베이스 객체 중 하나(테이블, 제약사항, 시퀀스)
     - 오라클 전용 객체(다른 DBMS 제품에는 없음)
     - 일련 번호를 생성하는 객체(*****) 1,2,3,4,5,...
     - 주로 식별자를 만드는데 사용한다 > PK 값으로 사용한다
     
     시퀀스 객체 생성하기
     - create sequence 시퀀스명;
     
     시퀀스 객체 삭제하기
     - drop sequence 시퀀스명;
     
     시퀀스 객체 사용하기
     - 시퀀스명.nextVal > 함수 > 호출 시 일련 번호 반환
     - 시퀀스명.currVal > 현재 일련 번호를 호출 (몇번까지 했는지 확인할 때, 숫자증가X (잘 사용X))



*/

- DB Object > 헝가리언 표기법
- tblXXX
- seqXXX

create sequence seqNum;

select seqNum.nextVal from dual;


drop table tblMemo;

create table tblMemo (
    seq number constraint tblmemo_seq_pk primary key, 
    name varchar2(30),  
    memo varchar2(1000),
    regdate date
); 

create sequence seqMemo; --  시퀀스끼리 독립적

insert into tblMemo(seq, name, memo, regdate) 
values (seqMemo.nextVal, '홍길동', '메모', sysdate);

select * from tblMemo;

delete from tblMemo;

-- 쇼핑몰 > 상품 번호 > ABC001 > ABC101
select 'ABC' || seqNum.nextVal from dual; --ABC13
select 'ABC' || lpad(seqNum.nextVal, 3, '0') from dual; --ABC014


-- NEXTVal 먼저 실행 후 가능 > 그래서 잘 사용 X 
-- ORA-08002: 시퀀스 SEQNUM.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
select seqNum.currVal from dual;


/*

    시퀀스 객체 생성하기
    
    Create sequence 시퀀스명      옵션(순서 상관X)
                    increment by n --증감치
                    start with n -- 시작값
                    maxvalue n -- 최댓값
                    minvalue n -- 최솟값
                    cycle -- 순환 유무
                    cache n; -- 임시 저장


*/

drop sequence seqTest;

create sequence seqTest
                --increment by -1;
                --start with 10  -- 시드값
                --maxvalue 10 -- 시퀀스값의 최대치 ( minvalue는 increment 를 음수로 지정했을때 사용)
                --minvalue 1
                --cycle -- 단독으로 못갖고옴 (maxvalue, cache) 순환하는 일련번호 1~10이면, 10다음 1로 
                cache 20 -- 기본값이 20 ,비정상적으로 종료시 동기화하는 텀을 일컫는다 > 21로 시작, 정상적인 종료시, 하드웨어에 저장하고 종료하기 때문에  X.  
                ;
                

select seqTest.nextVal from dual; -- 시작은 1부터, 하지만 다음부터 increment +, 음수면 -1부터 시작