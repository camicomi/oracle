-- ex29_plsql.sql

/*


    PL/SQL
    - Oracle's Procedural Language extension to SQL
    - 기존의 ANSI-SQL + 절차 지향 언어 기능 추가(변수, 제어 흐름, 객체 정의 등)
    
    
    프로시저, Procedure
    - 메서드, 함수 등..
    - 순서가 있는 명령어들의 집합
    - 모든 PL/SQL 구문은 프로시저 내에서만 작성/동작이 가능하다
    - 프로시저 영역 <-> ANSI-SQL 영역
    
    1. 익명 프로시저
        - 1회용 코드 작성
    
    2. 실명 프로시저
        - 재사용
        - 저장
        - 데이터베이스 객체
        
    PL/SQL 프로시저 구조 
    
    1. 4개의 블럭으로 구성 (키워드를 사용해서 블럭을 만든다)
        - DECLARE
        - BEGIN
        - EXCEPTION
        - END
        
    2. DECLARE
        - 선언부
        - 프로시저 내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능
        
    3. BEGIN ~ END
        - 구현부
        - 구현된 코드를 가지는 영역(메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드? > ANSI-SQL + PL/SQL(연산, 제어 등)
        
    4. EXCEPTION
        - 예외처리부
        - catch 역할
        - 3번(BEGIN ~ END) > try 역할
        - 생략 가능
        
        <익명 프로시저>
        
    [DECLARE
        변수 선언;
        객체 선언;] -- 생략 가능
    BEGIN
        업무 코드;
        업무 코드;
        업무 코드;
    [EXCEPTION
        예외처리 코드;] -- 생략 가능
    END;


    다른 언어
    ANSI-SQL <> PL/SQL

    자료형 OR 변수 OR 제어 흐름
    
    PL/SQL 자료형
    - ANSI-SQL과 동일
    
    변수 선언하기
    - 변수명 자료형(길이) [not null] [default 값];

    PL/SQL 연산자
    - ANSI-SQL과 동일
    
    대입 연산자
    - ANSI-SQL
        ex) update table set column = '값'
    - PL/SQL
        ex) 변수 := 값;
        

*/

-- 명령어가 기본적으로 화면에 안나오도록 설정되어 있다
set serveroutput on; -- 현재 세션에서만 유효
set serverout on;
set serveroutput off; -- 끄기

-- 익명 프로시저 선언하기
begin

    dbms_output.put_line('Hello World!');

end;
/


-- end 뒤에 / 넣는 이유, Ctrl + enter 편하게 하기 위하여 


begin

    dbms_output.put_line('Hello World2!');

end;
/



declare
-- 변수명 자료형(길이) [not null] [default 값];
    num number;
    name varchar2(30);
    today date;
begin
    num := 10;
    dbms_output.put_line(num); -- 개발용 명령어
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    dbms_output.put_line(today);
    
    
end;
/


declare
    num1 number; -- 초기화를 하지 않으면  null이므로 쓸모 없다!
    num2 number;
    num3 number := 30; -- 선언과 동시에 초기화가 가능하다
    num4 number default 40;
--  num5 number not null; ORA-06550: 줄 6, 열10:PLS-00218: NOT NULL로 정의된 변수는 초기치를 할당하여야 합니다
    -- not null은 declare 블럭에서 초기화를 해야 한다
    num5 number not null := 50;
begin

    dbms_output.put_line('num1' || num1 * 20); --null
    
    num2 := 20;
    dbms_output.put_line(num2);
    
    num3 := null; --null 넣을 수 있다
    dbms_output.put_line(num3);
    
    dbms_output.put_line(num4);

    -- num5 := 50; 초기값이 아닌 치환으로 생각해서 에러 
    -- num5 := null;
    dbms_output.put_line(num5);

end;
/



-- https://toad.co.kr/product
-- https://www.jetbrains.com/ko-kr/datagrip/
-- https://dbeaver.io/

/*

    변수 > 어떤 용도로 사용?
    - 일반적인 값을 저장하는 용도 > 비중 낮음
    - select 결과를 담는 용도 > 비중 높음
    
    select into 절(PL/SQL)
    
    


*/


declare
    vbuseo varchar2(15); --변수

begin

    select buseo into vbuseo from tblInsa where name = '홍길동'; -- 순수 select문만 못쓴다
    
    dbms_output.put_line(vbuseo);
    
--    insert into tblTodo values ((select max(seq) + 1 from tblTodo), '할일', sysdate, null); --  이건 가능.. 

end;
/


-- 성과급 받는 직원
create table tblBonus (
    name varchar2(15)
);

-- 1. 개발부 + 부장 > select > name ?
-- 2. tblBonus > name > insert

insert into tblBonus (name)
    values ((select name from tblInsa where buseo = '개발부' and jikwi = '부장'));
    
select * from tblBonus;

declare
    vname varchar2(15);
    
begin

    --1.
    select name into vname from tblInsa where buseo = '개발부' and jikwi= '부장';
    
    -- 2. 변수생성
    insert into tblBonus (name) values (vname);
end;
/

select * from tblBonus;

desc tblInsa;

declare
    vname varchar2(15); -- 반드시 테이블 정보를 확인하고 작성
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin

    -- select into 절
    -- select name into vname, buseo into vbuseo, 
    -- jikwi into jikwi, basicpay into basicpay 
    -- from tblInsa where num = 1001;

        -- 다대다로 한다
        -- into 사용시
        -- 1. 컬럼의 개수와 변수의 개수 일치
        -- 2. 컬럼의 순서와 변수의 순서 일치
        -- 3. 컬럼과 변수의 자료형 일치
        
    select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay from tblInsa where num = 1001;

--     select name, buseo, jikwi, basicpay from tblInsa where num = 1001;

    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
        dbms_output.put_line(vbasicpay);



end;
/



/*

    타입 참조
    %type
    - 사용하는 테이블의 특정 컬럼의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
    
    %rowtype
    - 행 전체 참조(여러개의 컬럼을 참조)



*/


declare
    -- vbuseo varchar2(15);
    vbuseo tblInsa.buseo%type;
begin
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;
/


declare

    vname tblInsa.name%type;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;

begin
    select name, buseo, jikwi, basicpay
        into vname, vbuseo, vjikwi, vbasicpay
    from tblInsa where num = 1001;

    dbms_output.put_line(vname);
        dbms_output.put_line(vbuseo);
            dbms_output.put_line(vjikwi);
                dbms_output.put_line(vbasicpay);

end;
/

drop table tblBonus;

create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num), -- 직원번호(FK)
    bonus number not null
);

-- 프로시저 선언하기
-- 1. 서울, 부장, 영업부
-- 2. tblBonus > 지급 > 보너스(급여 * 1.5)

declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;


begin
    select 
        num, basicpay into vnum, vbasicpay 
    from tblInsa
        where city = '서울' and jikwi = '부장' and buseo = '영업부';

    insert into tblBonus (seq, num, bonus)
        values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbasicpay * 1.5);

end;
/
select * from tblBonus;

select * from tblBonus b
    inner join tblInsa i
        on i.num = b.num;
        
        

select * from tblMen; --10
select * from tblWomen; --10

-- 무명씨 > 성전환 수술 > tblMen -> tblWomen 옮기기
-- 1. '무명씨' > tblMen > select 
-- 2. tblWomen > insert
-- 3. tblMen > delete

declare
    -- vname tblMen.name%type;
    -- vage tblMen.age%type;
    -- vheight tblMen.height%type;
    -- vweight tblMen.weight%type;
    -- vcouple tblMen.couple%type;
    
    vrow tblMen%rowtype; -- 레코드 전체를 저장할 수 있는 변수
    
begin
    --1. select name, age, height, weight, couple into vrow
    select * into vrow from tblMen where name = '무명씨';

--    dbms_output.put_line(vrow); -- 집합으로써 안됨

    dbms_output.put_line(vrow.name);    
    dbms_output.put_line(vrow.age);    
    
    --2. 
    insert into tblWomen (name, age, height, weight, couple)
        values (vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
        
    --3. 
    delete from tblMen where name = vrow.name;
    
end;
/


select * from tblMen;
select * from tblWomen;



---------------------------------------------------


/*


    제어문
    1. 조건문
    2. 반복문
    3. 분기문



*/

declare
    vnum number := 10;
begin
    if vnum > 0 then -- true 절
        
        -- 구현부; 
        -- 만족하면 실행 
        dbms_output.put_line('양수');
    else --  false 절
        dbms_output.put_line('양수 아님');
        
    end if;

end;
/



declare
    vnum number := 10;
begin
    if vnum > 0 then  
        dbms_output.put_line('양수');
    elsif vnum < 0 then -- else if, elsif, elseif 등..
        dbms_output.put_line('음수');
    else 
        dbms_output.put_line('0');
    end if;

end;
/





-- tblInsa. 남자직원 / 여자직원 > 다른 업무
declare
    vgender char(1); -- 주민번호에서 1자리만 추출

begin
    select substr(ssn, 8, 1) into vgender from tblInsa where num = 1049;
    
    if vgender = '1' then
        dbms_output.put_line('남자 업무');
    elsif vgender = '2' then
        dbms_output.put_line('여자 업무');
    end if;

end;
/

-- 직원 1명 선택 > 보너스 지급
-- 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 사원/대리 > basicpay * 2

declare
    vnum tblInsa.num%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
    vbonus number; -- 일반변수

begin

    -- 1.  
    select 
        num, jikwi, basicpay into vnum, vjikwi, vbasicpay 
    from tblInsa
        where num = 1005;
        
    -- 1.5

    if vjikwi = '과장' or vjikwi = '부장' then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('사원', '대리') then
        vbonus := vbasicpay * 2;    
    end if; 
    
    -- 2.
        insert into tblBonus (seq, num, bonus)
        values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);


end;
/


select * from tblBonus;

select * from tblBonus b
    inner join tblInsa i
        on i.num = b.num;
        
        

/*

    case문
    - ANSI-SQL의 case와 동일
    - 자바: switch문, 다중 if문


*/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin
    select continent into vcontinent from tblCountry where name = '대한민국';
    
    case
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case; 
    
    dbms_output.put_line(vresult);
    
        case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case; 
    
    dbms_output.put_line(vresult);

end;
/


/*

    반복문
    
    1. loop
        - 단순 반복
    
    2. for loop
        - loop 기반
        - 횟수 반복(자바 for)
    
    3. while loop
        - loop 기반
        - 조건 반복(자바 while)




*/ 


begin

    -- 무한루프
    loop
    dbms_output.put_line('구현부');
    end loop;  

end;
/


declare
    vnum number := 1;
begin
    loop 
        dbms_output.put_line(vnum);
        vnum := vnum + 1; -- 증감식
        
       -- exit when 조건; -- 조건을 만족하면 탈출
       exit when vnum > 10;
    end loop;
end;
/


create table tblLoop (
    seq number primary key,
    data varchar2(100) not null
); 

create sequence seqLoop;

-- data > 항목0001, 항목0002, ...항목 1000

declare
    vnum number := 1;

begin
    loop
        insert into tblLoop (seq, data)
            values (seqLoop.nextVal, '항목' || lpad(vnum, 4, '0'));
            
        vnum := vnum + 1;
        exit when vnum > 1000;
    end loop;

end;
/

select * from tblLoop;


/*


    2. for loop
    
    for (int n : list) {
    
    } -- 자바, 향상된 FOR 문
    
    for (int n in list) {
    
    } -- 



*/

begin

    for i in 1..10 loop -- i 는 자동으로 만들어진 변수
     dbms_output.put_line(i);
    end loop;

end;
/


create table tblGugudan (

    dan number not null,
    num number not null, 
    result number not null,
    constraint tblgugudan_dan_num_pk primary key(dan, num) -- 복합키(Composite Key)

);

create table tblGugudan (

    dan number not null,
    num number not null, 
    result number not null
    ); 
alter table tblGugudan
    add constraint tblgugudan_dan_num_pk primary key(dan, num);
    
    
begin
    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan (dan, num, result)
                values (dan, num, dan*num);        
        end loop;
    end loop;
end;
/

select * from tblGugudan;





begin 

 --   for i in 1..10 loop -- 조작 불가 , 10..1 X , 반드시 올라가야 함 
     for i in reverse 1..10 loop 
        dbms_output.put_line(i); -- 11 - i 로도 할 수 있지만
    end loop; 

end;
/


-- 3. while loop
declare
    vnum number := 1;
begin
    while vnum <= 10 loop  -- while 조건 loop 
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
    end loop;

end;
/

------------0222

/*

    사용빈도 높음
    
    select > 결과셋 > PL/SQL 변수 대입
    
    1. select into
        - 결과셋의 레코드가 1개일 때만 사용이 가능하다
        예) select continent into vcontinent from tblCountry where name = '대한민국';
        
    
    2. cursor
        - 결과셋의 레코드가 N개일 때만 사용이 가능하다.
        - 반드시 루프 함께 사용 (필수, 커서 탐색 용도) 
        
        
    declare
         변수 선언;
         커서 선언; --  결과셋 참조 객체
    begin
        커서 열기;
            loop
                데이터 접근(루프 1회전 > 레코드 1개 접근) <- 커서 사용
            end loop;
        커서 닫기; 
    end;

다음번에 데이터가 있는지 없는지 확인하고, 데이터를 가져옴
대부분의 커서는 전진만 하고, 후진은 못함
다시 보고 싶으면 커서 를 다시 생성해서 봐야 한다. 
자바: 
while (iter.hasNext()) {
iter.next()
)

*/
set serveroutput on;

declare
    vname tblInsa.name%type;
--    vname varchar2(30); --null 허용
    vcnt number;
begin

    select count(*) into vcnt from tblInsa where num = 1001;

    if vcnt > 0 then
-- ORA-01403: 데이터를 찾을 수 없습니다.
    select name into vname from tblInsa; -- where num = 1001; ORA-01422: 실제 인출은 요구된 것보다 많은 수의 행을 추출합니다
    dbms_output.put_line(vname);
    else
    dbms_output.put_line('없음');
    end if;
    
end;
/

/*
create view vwTest
as 
select문; 

cursor vcursor
is select문;
*/

declare
    -- cursor 커서명 is select문;
    cursor vcursor is select name from tblInsa; -- 정의 O, 실행X
    
    vname tblInsa.name%type;
begin
    open vcursor; -- 커서 열기 > select 실행 > 결과셋을 커서가 참조
    
        -- 커서 == 컬럼이라고 생각
        -- fetch 커서 into 변수 = select 컬럼 into 변수
       -- fetch vcursor into vname; -- 커서 한칸 전진, 첫번째 사람..  
       --  dbms_output.put_line(vname);
        
       --  fetch vcursor into vname; -- 커서 한칸 더 전진 , 두번째 사람..
       --  dbms_output.put_line(vname);
       
       
       loop
        fetch vcursor into vname;
        exit when vcursor%notfound;
        dbms_output.put_line(vname);
  
  
--       탈출       
--        if vcursor%notfound then -- boolean 값
--            dbms_output.put_line('O');
--        else
--            dbms_output.put_line('X');
--        end if;
        
        end loop;
        
    close vcursor; -- 커서 닫기
end;
/

-- '기획부' > 이름, 직위, 급여 >  출력
declare

    cursor vcursor
    is
    select name, jikwi, basicpay from tblInsa where buseo = '기획부';
    
    vname tblInsa.name%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;

begin

    open vcursor;
    loop
    -- select name, jikwi, basicpay into vname, vjikwi, vbasicpay
    fetch vcursor into vname, vjikwi, vbasicpay;
    exit when vcursor%notfound; -- 없을때까지
    
    -- 업무 > 기획부 직원 한명씩 접근
    dbms_output.put_line(vname || ',' || vjikwi || ',' || vbasicpay);
    
    end loop;
    close vcursor;

end;
/


-- 문제. tblBonus
-- 모든 직원에게 보너스 지급
-- 60명 전원
-- 과장/부장 > 1.5배
-- 사원/대리 > 2배

declare

   cursor vcursor
    is
    select num, basicpay, jikwi from tblInsa; -- 60명 전원
     
    vnum tblInsa.num%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
    vbonus number; 
    
begin

   open vcursor;
    loop
    
    fetch vcursor into vnum, vbasicpay, vjikwi;
    exit when vcursor%notfound;
    
    if vjikwi in('과장','부장') then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in('사원','대리') then
        vbonus := vbasicpay * 2;
        end if;
        
    insert into tblBonus (seq, num, bonus)
    values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);
    
    
    end loop;
    close vcursor;

end;
/

select * from tblBonus;



-- 커서 탐색
-- 1. 커서 + loop > 기본 
-- 2. 커서 + for loop > 간단

-- 60명 직원 정보 전부 출력
declare
    cursor vcursor is select * from tblInsa;
    --vrow tblInsa%rowtype;    
begin
    --open vcursor;
    for vrow in vcursor loop        
        --fetch vcursor into vrow;
        --exit when vcursor%notfound;
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
    end loop;    
    --close vcursor;
end;
/


declare
    cursor vcursor is select * from tblInsa;   
begin
    for vrow in vcursor loop        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
    end loop;    
end;
/

select * from tblInsa;






-----------------------------------
-- 예외처리
-- : 실행부에서(begin~end) 발생하는 예외를 처리하는 블럭 > exception 블럭
-- : 자바의 catch절 역할과 동일




declare
    vname tblInsa.name%type;
begin
-- ORA-01403: 데이터를 찾을 수 없습니다. "no data found"
    dbms_output.put_line('111');
    select name into vname from tblInsa where num = 1000;
    dbms_output.put_line('222');
    dbms_output.put_line(vname);
    dbms_output.put_line('333');

exception
    when others then
        dbms_output.put_line('예외 처리');

end;
/

-- https://docs.oracle.com/cd/E11882_01/timesten.112/e21639/exceptions.htm#TTPLS196 북마크

-- 예외 발생 > 기록(log)
create table tblLog (
    seq number primary key,             -- PK
    code varchar2(7) not null,          -- 상태코드
    message varchar2(1000) not null,    -- 예외 메시지
    regdate date default sysdate not null   -- 발생시각
);

create sequence seqLog;


declare
    vcnt number;
    vname varchar2(15);
begin

    select count(*) into vcnt from tblCountry; --  where name = '러시아';
    dbms_output.put_line(100 / vcnt);
    
    select name into vname from tblInsa where num = 1000;
    dbms_output.put_line(vname);
    
exception

--    when 예외종류 then
--        예외처리코드; x N  하나 실행되면, 나머지는 실행되지 않고 빠져나간다 다중  Catch 문처럼

   when ZERO_DIVIDE then
    dbms_output.put_line('0으로 나누기');
    insert into tblLog values (seqLog.nextVal, 'A001', '가져온 레코드가 없습니다.', default);
 
   
    when NO_DATA_FOUND then
    dbms_output.put_line('데이터 없음');
    insert into tblLog values (seqLog.nextVal, 'B003', '직원이 존재하지 않습니다.', default);
    
    when others then  -- 기타등등
    dbms_output.put_line('나머지 예외');
    insert into tblLog values (seqLog.nextVal, 'Z009', '기타 에외가 발생했습니다.', default); 
    
end;
/

select * from tblLog; -- 프로젝트 수행시 log 필수

-------------------------------------------------------------익명 프로시저


-------------------------------------------------------------실명 프로시저



/*

    프로시저
    1. 익명 프로시저
        - 1회용
    
    2. 실명 프로시저
        - 저장 > 재사용

    실명 프로시저
    - 저장 프로시저(Stored Procedure)
    
    1. 저장 프로시저, Stored Procedure
        - 매개변수 / 반환값 존재  > 구성 자유 
        
    2. 저장 함수, Stored Function
        - 매개변수 / 반환값 > 필수 
        
    
    익명 프로시저 선언
    [declare
        변수 선언;
        커서 선언;]
    begin
        구현부;
    [exception
        예외처리;]
    end;
    
    
    저장 프로시저 선언
    
    create [or replace] procedure 프로시저명
    is(as) -- 생략 불가
    [   변수 선언;
        커서 선언;]
    begin
        구현부;
    [exception
        예외처리;]
    end;
    
*/ 


-- 즉시 실행
declare
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;
/


-- 저장 프로시저 (메서드!!! 호출 따로 해야됨)
create or replace procedure procTest
is
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;
/


-- 프로시저 호출
procTest; -- ANSI-SQL 공간이므로 그냥 부를수  X

begin
    procTest;
end;
/

-- 자바 연동시..
execute procTest;
exec procTest;
call procTest();


-- 메서드 > 매개변수 + 반환값

-- 1. 매개변수가 있는 프로시저 
create or replace procedure procTest(pnum number) -- 매개변수
is
    vnum number; -- 일반변수
begin
    vnum := pnum * 2;
    dbms_output.put_line(vnum);
    
end procTest; -- 필수는 아니고 선택, 가독성 높이기 위해..
-- 컴파일 > DB 저장됐다..

begin
    procTest(100);

end;
/

create or replace procedure procTest(pwidth number, pheight number)
is
    varea number;
begin

    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin
    procTest(100, 200);
end;


--
-- 1. 프로시저의 매개변수 > 길이 표현(X), not null 표현(X)
-- 2. is(as) 생략 불가능
create or replace procedure procTest (
      pname varchar2
)
is 
begin
dbms_output.put_line('안녕하세요.' || pname || '님');
end procTest;
/

begin
    procTest('홍길동');
end;
/

-- default 추가

create or replace procedure procTest(
    pwidth number, -- default 10 불가, 뒤에서부터 채워나갈 수 있다 ,  전부도 불가
    pheight number default 10
)
is 
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin
    -- procTest(10, 20);
    procTest(10); --width(10) * height(10) default 값
end;


/*

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    - Call by value > 값을 넘기는 동작 (값을 복사해서 넘김, Side effect X)
    - Call by Reference > 주소를 넘기는 동작 (Side effect O)
    
    1. in > 기본
    2. out 
    3. in out > X (거의 안씀) 


*/

create or replace procedure procTest (
    pnum1 number,                -- in parameter (기본)
    pnum2 in number,
    presult out number,            -- out parameter, 반환값 역할, 주소값 복사됨
    presult2 out number,
    presult3 out number
)
is
begin
    presult := pnum1 + pnum2;
    presult2 := pnum1 - pnum2;
    presult3 := pnum1 * pnum2;
end procTest;
/

-- 'TO_NUMBER(SQLDEVBIND1Z_1)' 식은 피할당자로 사용될 수 없습니다 (result 절)
-- out parameter 은 절대 상수를 넣을 수 없다. 변수를 넣어야 한다.
begin
    procTest(10, 20, 0);
end;
/


declare
    vtemp number;  -- null
    vtemp2 number;
    vtemp3 number;
begin
    procTest(10, 20, vtemp, vtemp2, vtemp3); 

    dbms_output.put_line(vtemp);
    dbms_output.put_line(vtemp2);
    dbms_output.put_line(vtemp3);
end;
/


/*

    문제
    1. procTest1
    - 부서 전달(인자 1개) > in
    - 해당 부서의 직원 중 급여를 가장 많이 받는 사람의 번호를 반환 > out
    - 호출 + 번호 출력
    
    2. procTest2
    - 직원 번호 전달 > in
    - 같은 지역에 사는 직원수? 같은 직위의 직원수? 해당 직원보다 급여를 더 많이 받는 사람 수? > out x 3개
    - 호출 + 인원수X3개 출력

*/

--1. 
create or replace procedure procTest1 (
    pbuseo varchar2,
    pnum out number
)
is
begin
    
    select num into pnum from tblInsa
        where basicpay = (select max(basicpay) from tblInsa where buseo = pbuseo)
            and buseo = pbuseo;
    
end procTest1;
/

declare
    vnum number;
begin
    procTest1('개발부', vnum);
    dbms_output.put_line(vnum);
end;
/




--2. 직원 번호 전달 > in
    - 같은 지역에 사는 직원수? 같은 직위의 직원수? 해당 직원보다 급여를 더 많이 받는 사람 수? > out x 3개
    
create or replace procedure procTest2 (
    pnum in number, -- 직원번호
    pcnt1 out number,
    pcnt2 out number,
    pcnt3 out number
    )
is
begin
        select count(*) into pcnt1 from tblInsa
            where city = (select city from tblInsa where num = pnum);

        select count(*) into pcnt2 from tblInsa
            where jikwi = (select jikwi from tblInsa where num = pnum);    

        select count(*) into pcnt3 from tblInsa
            where basicpay > (select basicpay from tblInsa where num = pnum);
            
end;
/

declare
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;
begin
    procTest2(1001, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;
/

select * from tblStaff;
select * from tblProject;

-- 직원 퇴사 프로시저, procDeleteStaff
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인?
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제


create or replace procedure procDeleteStaff (
    pseq number,            -- 퇴사할 직원번호
    pstaff number,          -- 위임받을 직원번호
    presult out number      -- 성공(1) or 실패(0)
)
is
    vcnt number; --퇴사 직원의 담당 프로젝트 개수
begin
    -- 1. 퇴사 직원이 담당 프로젝트가 있는지?
    select count(*) into vcnt from tblProject where staff_seq = pseq;
    
    -- 2. 조건 > 위임 유무 결정
    if vcnt > 0 then
        -- 3. 위임
        update tblProject set staff_seq = pstaff where staff_seq = pseq;
    else
        -- 3. 아무것도 안함
        null; -- 개발자의 의도 표현
    end if;
    
    -- 4. 퇴사
    delete from tblStaff where seq = pseq;
    
    -- 5. 성공
    presult := 1;
    
exception

    -- 5. 실패
    when others then
    presult := 0;
end procDeleteStaff;
/




declare
    vresult number;
begin
    procDeleteStaff(1, 2, vresult);
    if vresult = 1 then
        dbms_output.put_line('퇴사 성공');
    else
        dbms_output.put_line('퇴사 실패');
    end if;
    
end;
/


-- 직원 퇴사 프로시저, procDeleteStaff
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인?
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제

-- 2.위임 받을 직원 > 현재 프로젝트를 가장 적게 담당 직원에게 자동으로 위임
-- 동률 > rownum = 1 

select * from tblStaff;
select * from tblProject;



create or replace procedure procDeleteStaff (
    pseq number,            -- 퇴사할 직원번호
    presult out number      -- 성공(1) or 실패(0)
)
is
    vcnt number; --퇴사 직원의 담당 프로젝트 개수
    vseq number; -- 위임받을 직원 번호
begin
    --1. 퇴사 직원이 담당 프로젝트가 있는지?
    select count(*) into vcnt from tblProject where staff_seq = pseq;
    
    --2. 조건 > 위임 유무 결정
    if vcnt > 0 then
    
        --2.5 가장 프로젝트를 적게 담당한 직원?
        select seq into vseq from
            (select seq, nvl(cnt, 0) as cnt from 
                    (select staff_seq, count(*) as cnt from tblProject
                        where staff_seq is not null
                            group by staff_seq) a
                                right outer join tblStaff s
                                    on a.staff_seq = s.seq
                                        order by cnt asc)
                                            where rownum = 1;
    
        
        --3. 위임
        update tblProject set staff_seq = vseq where staff_seq = pseq;        
        
    else
        --3. 아무것도 안함
        null; --개발자의 의도 표현
    end if;
    
    --4. 퇴사
    delete from tblStaff where seq = pseq;
    
    --5. 성공
    presult := 1;

exception
    
    -- 5. 실패
    when others then
        presult := 0;

end procDeleteStaff;
/




declare
    vresult number;
begin

    procDeleteStaff(3, vresult);
    
    if vresult = 1 then
        dbms_output.put_line('퇴사 성공');
    else
        dbms_output.put_line('퇴사 실패');
    end if;
    
end;
/



/* 
    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수

    저장 함수, Stored Function > 함수(function)
    - 저장 프로시저와 동일
    - 반환값이 반드시 존재!!
    

*/

-- num1 + num2 > 합 반환

-- 프로시저
create or replace procedure procSum (
    pnum1 in number,
    pnum2 in number,
    presult out number
)
is
begin
    presult := pnum1 + pnum2;
end procSum;
/


-- 함수
-- 자바 public int sum(n1, n2)


create or replace function fnSum(pnum1 in number, pnum2 in number
) return number --return 타입
is
begin
    return pnum1 + pnum2;
end fnSum;
/



declare
    vresult number;
begin

    procSum(10, 20, vresult);
    dbms_output.put_line(vresult);
    
    vresult := fnSum(30, 40); == PL/SQL에서 잘 사용 안한다 > ANSI-SQL에서 사용한다
    dbms_output.put_line(vresult);
end;
/


select
    name, buseo, jikwi, fnGender(ssn) 
from tblInsa;



create or replace function fnGender(pssn varchar2) return varchar2
is
begin
    return case
                when substr(pssn, 8, 1) = '1' then '남자'
                when substr(pssn, 8, 2) = '2' then '여자'
    end;

end fnGender;
/


-- 프로시저 : 일련의 흐름을 가지는 명령어 집합 = 모듈
-- 함수 : ANSI-SQL의 반복되는 업무

/*
    프로시저
    1. 프로시저
    2. 함수
    3. 트리거

    트리거, Trigger
    - 프로시저의 한종류
    - 개발자의 호출이 아닌, 미리 지정한 특정 사건이 발생하면 시스템이 자동으로 호출하는 프로시저
    - 에약(사건) > 감시 > 사건 발생 > 프로시저 호출

    - 특정 테이블 지정 > 지정 테이블을 오라클이 감시
        > 사건 발생(insert / update / delete 데이터 상태에 대한 변화) > 미리 준비한 프로시저 호출
        
    
    트리거 구문
    
    create or replace trigger 트리거명
        before|after
        insert|update|delete
        on 테이블명
        [for each row]   ----------여기까지 사건
    declare                     ---- 사건이 발생하면 여기서부터 호출
        선언부;
    begin
        구현부;
    exception
        에외처리부;
    end;

*/


-- tblInsa > 직원 삭제
create or replace trigger trgInsa
    before      --삭제가 발생하기 직전에 구현부를 실행해라!!
    delete      --삭제가 발생하는지 검사?
    on tblInsa  --tblInsa 테이블에서
begin

    dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss') || ' 트리거가 실행되었습니다.');
    
    -- 목요일에는 퇴사가 불가능
    if to_char(sysdate, 'dy') = '목' then
    
        --강제로 에러 발생
        --: throw new Exception()
        --: -20000 ~ -29999
        raise_application_error(-20001, '목요일에는 퇴사가 불가능합니다.');
    
    end if;
    
end trgInsa;
/

select * from tblInsa;

delete from tblInsa where num = 1006;

delete from tblBonus;


-- *** 오라클 사용자가 생성한 모든 식별자(테이블명, 컬럼명 등)를
-- 저장할 때 대문자로 저장한다.

-- 트리거 확인
select trigger_name, table_name, status from user_triggers where table_name = 'TBLINSA';
select * from user_triggers where table_name = 'tblInsa';

-- 트리거 중지
alter trigger trgInsa disable; --DISABLED

-- 트리거 작동
alter trigger trgInsa enable;


-- 로그 기록
-- tblDiary > 감시 > 사건 > 로그

create table tblLogDiary (
    seq number primary key,                 --PK
    message varchar2(1000) not null,        --메시지
    regdate date default sysdate not null   --시간
);

create sequence seqLogDiary;

-- 하나의 트리거로 동시에 사건을 감시 가능
create or replace trigger trgDiary
    after
    insert or update or delete
    on tblDiary
declare
    vmessage varchar2(1000);
begin

    -- dbms_output.put_line('trgDiary 호출됨');
    
    if inserting then
    -- dbms_output.put_line('trgDiary 호출됨 - 삽입'); 
        vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
    -- dbms_output.put_line('trgDiary 호출됨 - 수정');
        vmessage := '기존 항목이 수정되었습니다.';
    elsif deleting then
    -- dbms_output.put_line('trgDiary 호출됨 - 삭제'); 
        vmessage := '기존 항목이 삭제되었습니다.';
    end if;
    
    insert into tblLogDiary values (seqLogDiary.nextVal, vmessage, default);

end trgDiary;
/


insert into tblDiary values (11, '눈이 많이 왔습니다.', '눈', sysdate);

update tblDiary set subject = '함박눈이 많이 왔습니다.' where seq = 11;

delete from tblDiary where seq = 11;

select * from tblDiary;
select * from tblLogDiary;

alter trigger trgDiary disable;

/*

    [for each row]
    1. 생략
        - 문장(Query) 단위 트리거, Table Level Trigger
        
    2. 사용
        - 행(Record) 단위 트리거


*/

create or replace trigger trgMen
    after
    delete
    on tblMen
    for each row
-- 변수 안만들거니까 declare 생략
begin
    dbms_output.put_line('레코드를 삭제했습니다' || :old.name || ',' || :old.age); -- for each row 
end trgMen;
/

select * from tblMen; -- 조세호 삭제..

delete from tblMen where name = '조세호'; -- 멘트 1
delete from tblMen; -- 멘트1
-- 적용받는 행의 갯수와 상관없이 멘트는 한번만 실행 -> 문장 단위 트리거

rollback;

delete from tblMen where name = '조세호'; -- 멘트 1
delete from tblMen; --



create or replace trigger trgMen
    after -- before 도 가능 , 매개변수가 넘어오기 때문에,,,, 
    update -- insert 과거가 없고 새로 탄생했기 때문에 new만 참조. old는 사용X
    -- delete 는  new X, old O
    on tblMen
    for each row
begin
dbms_output.put_line('레코드를 수정했습니다. >' || :old.name); -- update 발생 전
dbms_output.put_line('수정 전 나이 >' || :old.age);
dbms_output.put_line('수정 후 나이 >' || :new.age); -- update 발생 후
dbms_output.put_line('전 여친 >' || :old.couple); 
dbms_output.put_line('현 여친 >' || :new.couple);

end trgMen;
/


update tblMen set age = age + 1 where name = '홍길동';
update tblMen set couple = '무명씨' where name = '홍길동';

insert into tblMen values ('강호동', 30, 180, 90, '호호호');

delete from tblMen where name = '강호동';

select * from tblMen;


-- 정리
-- insert > :old(X), :new(O)
-- update > :old(O), :new(O)
-- delete > :old(O), :new(X)


-- 퇴사 > 프로젝트 위임

select * from tblStaff;
select * from tblProject;

delete from tblStaff; -- 데이터 삭제
truncate table tblStaff; -- 데이터 삭제

delete from tblProject; -- delete
truncate table tblProject; -- Shift + delete, rollback 불가

drop table tblStaff; -- 테이블 삭제

commit;
rollback;





create or replace trigger trgDeleteStaff
    before                  -- 3. 하기 전에
    delete                  -- 2. 퇴사
    on tblStaff             -- 1. 직원 테이블에서
    for each row            -- 4. 해당 직원 정보
begin

    --5. 사용 > 위임
    update tblProject set
        staff_seq = 3
            where staff_seq = :old.seq; -- 퇴사하는 직원 번호
    
end trgDeleteStaff;
/

select * from tblStaff;

delete from tblStaff where seq = 1;




-------------------0223

-- 회원 테이블, 게시판 테이블
-- 포인트 정책
-- 1. 글 작성 > 포인트 + 100
-- 2. 글 삭제 > 포인트 - 50

create table tblUser (
    id varchar2(30) not null,
    point number not null

);

alter table tblUser
    add constraint tbluser_id_pk primary key(id);

create table tblBoard (
    seq number not null,
    subject varchar2(2000) not null,
    id varchar2(30) not null
);

alter table tblBoard
    add constraint tblboard_seq_pk primary key(seq);
    
alter table tblBoard
    add constraint tblboard_id_fk foreign key(id) references tblUser(id);
    
create sequence seqBoard;


insert into tblUser values ('hong', 1000);

-- 1. 글을 쓴다.(삭제한다.)
-- 2. 포인트를 누적(차감)한다.

-- Case 1. Hard Coding
-- 개발자 직접 제어
-- 실수 > 일부 업무 누락

-- 1.1 글쓰기
insert into tblBoard values (seqBoard.nextVal, '게시판입니다', 'hong');

-- 1.2 포인트 누적하기
update tblUser set point = point + 100 where id = 'hong';

-- 1.3 글삭제하기
delete from tblBoard where seq = 1;

-- 1.4 포인트 차감하기
update tblUser set point = point - 50 where id = 'hong';

-- 결과 확인
select * from tblBoard;
select * from tblUser;


-- Case2. 프로시저(메서드)

-- 1. 글쓰기
create or replace procedure procAddBoard (
    pid varchar2,  -- 매개변수로 받는다
    psubject varchar2
)
is
begin

    insert into tblBoard values (seqBoard.nextVal, psubject, pid);
    
    update tblUser set point = point + 100 where id = pid;

end procAddBoard;
/

-- 2. 삭제하기
create or replace procedure procDeleteBoard(
    pseq number -- 글번호를 알아내서 게시물 삭제
)
is
    vid tblUser.id%type;
begin
    -- 삭제하기 전에 지우려는 글번호의 작성자 아이디 알아내기
    select id into vid from tblBoard where seq = pseq;
    
    delete from tblBoard where seq = pseq;
    update tblUser set point = point - 50 where id = vid;
    
    
end procDeleteBoard;

-- 실제로 적용
begin
   procAddBoard('hong', '안녕하세요');
end;
/

begin
   procDeleteBoard(2);
end;
/

-- SQL Developer > 그외도구일 경우, SQL*PLUS desc 테이블명; show user; set serveroutput on 명령어 동작 안함 


-- Case 3. 트리거
create or replace trigger trgBoard
    after
    insert or delete
    on tblBoard
    for each row -- 누가 쓰고 누가 삭제했는지 관련 정보가 필요하므로 사용! 
begin
-- 글은 외부에서 이미 썼기 때문에 트리거가 발생한 것이므로, 트리거는 포인트작업만 진행
    if inserting then
        update tblUser set point = point + 100 where id = :new.id; 
        -- new, old는 방금 사건이 일어난 Board table의 레코드를 말한다 
    elsif deleting then
        update tblUser set point = point - 50 where id = :old.id;
        end if;

end trgBoard;
/

-- 글쓰기는 ANSI 에서 
insert into tblBoard values (seqBoard.nextVal, '금요일입니다', 'hong');

delete from tblBoard where seq = 3;

select * from tblBoard;
select * from tblUser;

-- 포인트가 고정이 아니라면? 프로시저에서는 매개변수로 사용하면 되지만, 트리거에서는 고정작업밖에 안되므로 변화된값을 확보할 방법이 없다
