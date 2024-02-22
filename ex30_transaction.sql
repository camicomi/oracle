--ex30_transaction
/*

트랜잭션, Transaction

- 데이터를 조작하는 업무의 물리적(시간적)단위
- 1개 이상의 명령어를 묶어놓은 단위
- *** 트랜잭션을 어떻게 처리할 것인가? 
- 안전장치

-> 각작업시 임시메모리 적용 -> 실제 적용 명령어(커밋) or (롤백)

트랜잭션 명령어(DCL > TCL)
1. commit
2. rollback
3. savepoint

*/ 

create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

select * from tblTrans;

-- 우리가 하는 행동(SQL) > 시간순으로 기억(*****************)

-- 로그인 직후 (접속) > 트랜잭션이 시작됨
-- 트랜잭션 > 모든 명령어(X) > insert, update, delete 명령어만 트랜잭션에 포함된다.
-- insert, update, delete 작업 > 오라클(HDD) 적용(X),  임시 메모리 적용(O)

select * from tblTrans; -- 진짜 DB에서 가져옴

delete from tblTrans where name = '박문수'; -- 현재 트랜잭션에 포함

select * from tblTrans; -- 처음에 가져온 것을 임시 메모리에 복사하여 보여줌

-- 박문수 되살리기
rollback; -- 현재 트랜잭션의 시작으로 돌아감 (delete가 있는 곳으로), 새로운 트랜잭션 시작.

select * from tblTrans;

delete from tblTrans where name = '박문수';

rollback; -- rollback 실행 이후, 

select * from tblTrans;

delete from tblTrans where name = '박문수'; 

commit; -- 현재 트랜잭션에 있던 일을 모두 현실화시키는 것..

select * from tblTrans;

insert into tblTrans values ('호호호', '기획부', '사원');
update tblTrans set jikwi = '상무' where name = '홍길동';

select * from tblTrans;

commit;

-- 공식이 없어서 어디서부터 어디까지 transion ? 
-- 본인이 설정.. 
-- git push 너무 많으면 안좋음.. 


/*

    트랜잭션이 언제 시작해서 ~ 언제 끝나는지? 
    
    새로운 트랜잭션이 시작하는 시점
    1. 클라이언트 접속 직후
    2. commit 실행 직후
    3. rollback 실행 직후
    4. DDL 실행 직후
    
    현재 트랜잭션이 종료되는 시점
    1. commit >  DB에 반영 O
    2. rollback > DB에 반영 X
    3. 클라이언트 접속 종료
        a. 정상 종료
            - 현재 트랜잭션에 반영이 안된 명령어가 남아 있으면 > 질문?
        b. 비정상 종료
            - 트랜잭션을 처리할만한 시간적인 여유가 없는 경우
            - rollback
    4. DDL 실행(*** 주의!!)
            -  create, alter, drop > 실행 > 즉시 commit 실행
            - DDL 성격 > 구조 변경 > 데이터 영향 미침 > 사전에 미리 저장(commit)
            

*/

delete from tblTrans where name = '홍길동';
select * from tblTrans;

-- 새접속
select * from tblTrans;

delete from tblTrans where name = '홍길동';

select * from tblTrans;

commit; -- 어디부터 시작해야할지 모르겠다면 날리고 시작

update tblTrans set jikwi = '사장' where name = '홍길동';

select * from tblTrans;

-- 시퀀스 객체 생성
create sequence seqTrans; -- commit 호출

rollback;

select * from tblTrans; -- 여전히 '사장'이다 왜? create 에서 시작했으므로 


-- savepoint

select * from tblTrans;

insert into tblTrans values ('후후후', '기획부', '사원');

savepoint a;

delete from tblTrans where name = '홍길동';

savepoint b;

update tblTrans set buseo = '개발부' where name = '후후후';

select * from tblTrans;

rollback to b; -- update만 취소

select * from tblTrans;

rollback to a;

select * from tblTrans;

rollback; -- 완전 처음으로


-- SQL 작성 + 트랜잭션 활용
-- 프로그램 작성 + 트랜잭션 활용


