-- ex17_delete.sql

/*

    delete
    - DML
    - 원하는 행을 삭제하는 명령어
    
    - delete [from] 테이블명 [where 절]


*/

commit;
rollback;

select * from tblInsa;

delete from tblInsa where num = 1001; -- num이 PK , 홍길동 퇴사

delete from tblInsa where buseo = '총무부'; -- 부서

delete from tblInsa;