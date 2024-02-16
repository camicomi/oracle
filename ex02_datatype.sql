-- ex02_datatype.sql

/*

관계형 데이터베이스
- 변수(X)  >  SQL은 프로그래밍 언어가 아니다. 
- SQL >  대화형 언어 >  DB  와 대화를 목적으로 하는 언어
- 절차가 없어서 제어문이 없다 , 한문장씩 실행되는 형태
- 자료형 > 데이터 저장하는 규칙 > 테이블 정의할 때 사용 > 컬럼의 자료형

ANSI-SQL  자료형
- 오라클 자료형

1. 숫자형
    -  정수, 실수
    a. number
        - (유효자리)38자리 이하의 숫자를 표현하는 자료형
        - 12345678901234567891012345678
        - 5~22byte 
        - 1x10^-130 ~ 9.9999x10^125
        
        - number : 정수  or 실수 
        - number(precision) : 전체 자릿수 지정  > 정수만 저장
        - number(precision, scale) : 전체 자릿수 > 정수/실수 저장

2. 문자형 > varchar2 사용
    - 문자 + 문자열
    - char vs nchar > n의 의미? 
    - char vs varchar > var의 의미? 
    
    a. char
        - 고정 자릿수 문자열 > 공간(컬럼)의 크기가 불변 
        - char(n): 최대 n자리 문자열, n(바이트)
        - char(n char) : 문자수
            - 최소 크기 : 1바이트
            - 최대 크기 : 2000바이트
        - 데이터 삽입 후 > 남은 공간을 공백으로 채운다.
    
    b. nchar
        - n: national > 오라클 인코딩과 상관없이 해당 컬럼을  UTF-16으로 동작
        - nchar(n) : 최대  n자리 문자열, n(문자수)
            - 최소 크기 : 1바이트
            - 최대 크기 : 1000바이트
    
    c. varchar2
        - varchar
        - 가변 자릿수 문자열 > 공간(컬럼)의 크기가 가변
        - varchar2(n) :  최대 n자리 문자열, n(바이트)
            - 최소 크기 : 1바이트
            - 최대 크기 : 4000바이트
        - 데이터 삽입 후 > 남은 공간을 제거한다. 
        
    d. nvarchar2
        - n: national > 오라클 인코딩과 상관없이 해당 컬럼을  UTF-16으로 동작
        - 가변 자릿수 문자열 > 공간(컬럼)의 크기가 가변
        - nvarchar2(n) :  최대 n자리 문자열, n(바이트)
            - 최소 크기 : 1바이트
            - 최대 크기 : 2000바이트
        - 데이터 삽입 후 > 남은 공간을 제거한다. 
        
    e. clob(UTF-8), nclob(UTF-16)
        - 대용량 텍스트
        - character large object 
        - 최대 128TB
        - 참조형 

3. 날짜/시간형 > date 사용
    a. date
        - 년월일시분초
        - 기원전 4712년 1월 1일 ~ 9999년 12월 31일

    b. timestamp
        - 년월일시분초 + 밀리초 + 나노초
    
    c. interval
        - 시간
        - 틱값 저장용


4. 이진 데이터형
    - 비 텍스트 데이터
    - 이미지, 영상, 음악, 실행 파일, 압축 파일 등
    - 잘 사용 안함
    - ex) 게시판(첨부파일), 회원가입(사진) > 파일명만 저장
    
    a. blob
        - 최대 128TB 
        
결론
1. 숫자 > number
2. 문자열 > varchar2
3. 날짜 > date 

자바
1. 숫자 > int(long), double
2. 문자열 > String
3. 날짜 > Calendar


테이블 선언(생성)
create table 테이블명 (
    컬럼 선언,
    컬럼 선언,
    컬럼 선언,
    컬럼명 자료형
)

num (이름) number(자료형) 

*/

-- create 로 만든 건 drop으로 지운다
drop table tblType;

--  헝가리안 표기법 > 자료형을 접두어로 사용
create table tblType (
    -- num number 
    -- num number(3) -- ()안의 숫자는 최대 자리수를 의미한다, -999 ~ 999 정수 가능
    -- num number(4,2) -- 전체 자릿수(소수 이하 포함), 소수 이하 자릿수, -99.99 ~ 99.99
    
    -- txt char(10) -- 오라클 어떤 인코딩?  UTF-8 (영어 10글자, 한글 3글자)
    
    -- txt1 char(10),
    -- txt2 varchar2(10) 
    
    txt nchar(10)
    -- txt char(10 char)
);

-- 데이터 추가하기
-- insert into 테이블 (컬럼명) values (값);

insert into tblType (num) values (100); -- 정수 리터럴 
insert into tblType (num) values (3.14); -- 실수 리터럴, 소수점이 절삭된다
insert into tblType (num) values (3.99); -- 반올림이 된다 
insert into tblType (num) values (999);
insert into tblType (num) values (-999);
insert into tblType (num) values (1234); -- 오버플로우, X
insert into tblType (num) values (99.99);
insert into tblType (num) values (-99.99);

insert into tblType (txt) values ('ABC'); -- 문자 리터럴
insert into tblType (txt) values ('ABCDEABCDE');
insert into tblType (txt) values ('ABCDEABCDEF'); -- 10바이트 초과

insert into tblType (txt) values ('홍길동');
insert into tblType (txt) values ('홍길동님');

insert into tblType (txt1, txt2) values ('A', 'B');
insert into tblType (txt1, txt2) values ('ABCDEFGHIJ', 'ABCDEFGHIJ');

insert into tblType (txt) values ('ABCDEFGHIJ');
insert into tblType (txt) values ('일이삼사오육칠팔구십');


-- 데이터 가져오기
select * from tblType; 