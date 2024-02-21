
-- ex28_modeling.sql

/*

    데이터베이스 설계
    1. 요구사항 수집 및 분석
    2. 개념 데이터 모델링
    3. 논리 데이터 모델링
    4. 물리 데이터 모델링
    4.5 정규화
    5. 데이터베이스 구축(구현)
    
    데이터 모델링
    - 요구 분석 기반 > 수집한 데이터 > 분석 > 저장 구조 > 도식화 > 산출물(ERD)
    - 데이터를 저장하기 위한 데이터 구조를 설계하는 작업
    - ERD 만드는 작업
    - 개념 > 간단한 표현의 설계도 > 테이블 이름 + 속성 + 관계 정도만 기술
    - 논리 > 관계형 데이터베이스 기본 설정 > 속성(자료형, 길이) + 도메인 정의 + 키..
    - 물리 > 물리적인 식별자 + 실제 DBMS에 맞는 세부 설정

    <데이터베이스 개론과 실습> p.69
    Relation > 관계 > 테이블
    Relationship > 관계 > 테이블간의 관계

    1. ERD, Entity Relationship Diagram
    - 엔티티(테이블)간의 관계를 표현한 그림
    - 데이터베이스 모델링 기법 중 하나
    - 손, 오피스, 전문툴(eXERD, ER-Win, 온라인 툴..)
    
    2. Entity, 엔티티
    - 다른 Entity와 분류(구분)될 수 있고, 다른 Entity에 대해 정해진 관계를 맺을 수 있는 데이터 단위
    - 릴레이션 = 엔티티 = 레코드 = (자바) 인스턴트 = (자바) 객체 > 집합 (=테이블, (자바)클래스)
    예 : 학생(이름, 나이, 주소, 연락처, 반, 번호)  > 학생 == 릴레이션(집합의 정의)
    
        엔티티 : 테이블에 대한 정의, 테이블 자체 X
        a. 학생 정보 관리
            - 정보 수집 : 아이디, 학생명, 나이, 주소, 연락처 등 -> 속성들
            - 학생(아이디, 학생명, 나이, 주소, 연락처)
        b. 강의실 정보 관리
            - 정보 수집 : 강의실명, 크기, 인원수, 용도 등
            - 강의실(강의실명, 크기, 인원수, 용도) -> 강의실이라는 엔티티를 정의한 것
            
    3. Attribute, 속성
    - 엔티티를 구성하는 요소
    - 속성의 집합 = 엔티티
    - 컬럼
    
    4. Relationship, 관계
    - 하나의 엔티티안에 있는 속성이 다른 엔티티의 속성과 연관 
    - 엔티티와 엔티티간의 관계
    - 선 > 레코드와 레코드의 관계, 엔티티와 엔티티 간의 관계... 
    
    5. Relation, 관계
    - 하나의 엔티티내의 속성간의 관계
    - 학생(아이디, 학생명, 나이..)
    
    
    
    
    ERD > Entity, Attribute, Relationship 등 표현하는 방법
    - 피터첸 or IE > 많이 사용 
    
    직원(번호, 이름, 급여, 주소) 
    - 프로젝트(번호, 프로젝트명)
    
    1. Entity
    - 사각형
    - 이름을 작성
    - ERD 내의 엔티티명은 중복 불가능
    - 엔티티 하나당 사각형 하나
    
    2. Attribute
    - 원
    - 엔티티와 선으로 연결(소속 표시)
    - 기본키(PK) 이름 밑에 밑줄 표시
    
    3. Relationship
    - 엔티티와 엔티티의 관계
    - 마름모
    - n : 다수 관계 
    
    
    
    - 속성엔 차수 없음 
    - 대여는 관계이고, 엔티티는 아니다
    - 관계에도 속성 OO 
    - draw.io
    
    
    관계 차수
    - 몇개의 엔티티와 몇개의 엔티티가 관계를 맺는지 표현
    - IE(새발)
    
    1. 1:1
    2. 1:N
    3. n:n
    
--------------------------------------------

    [비디오 대여점] > 모델링 산출물
    1. ERD 작성(개념 모델링)  draw.io
    2. 논리 다이어그램(eXERD)
    3. 물리 다이어그램(eXERD) 구축/개발 용도 

1 > 2단계로 갈 때,   
2단계에서 FK 가 만들어진다 
차수 수정 (속성 - 스페이스)
> 속성을 가지는 관계는 논리 단계에서 엔티티화된다(대여)
> 엔티티 속성(도메인) 채워넣기(주석같은느낌..?)
> 데이터 타입도.. 


--------------------------------------------

    모델링 작업 > ERD > 올바르게 작성? > 검증 > 정규화 > 안정성 높고, 작업하기 편한 ERD
    
    
    정규화, Normalization
    - 자료의 손실이나 불필요한 정보를 없애고, 데이터의 일관성을 유지하며, 
      데이터 종속성을 최소화해주기 위해 ERD를 수정하는 작업
    - 우리가 만든 ERD > 비정형 상태, 비정규화 상태 > 정규화 상태
    - 제1정규화 > 제2정규화 > 제3정규화 등.. (권장사항)
    
    
    관계형 데이터베이스 시스템이 지향하는 데이터베이스의 상태
    1. 최대한 null을 가지지 않는다.
    2. 중복값을 가지지 않는다.
    3. 원자값을 가진다.
    
    정규화 목적
    1. null 최대한 제거
    2. 중복값 제거
    3. 복합값 제거
    4. 자료의 삽입 이상, 갱신 이상, 삭제 이상 현상 제거
    
    이상 현상, Anomaly
    1. 삽입 이상
        - 특정 테이블에 데이터를 삽입할 때 원하지 않는 데이터까지 같이 넣어야 하는 상황
    
    2. 갱신 이상
        - 동일한 데이터가 2개 이상의 테이블에 동시에 저장되는 현상
    
    3. 삭제 이상
        - 특정 테이블에서 데이터를 삭제할 때 원하지 않는 데이터까지 같이 삭제해야 하는 현상
        
        
    함수 종속
    - 하나의 테이블 내에서 컬럼끼리의 관계 표현
    - 정규화는 '부분 함수 종속'이나 '이행 함수 종속'을 모두 없애고, 
      모든 컬럼의 관계를 '완전 함수 종속'으로 만드는 작업이다.
      
      1. 완전 함수 종속
      2. 부분 함수 종속
      3. 이행 함수 종속
      
    
    정규화
    - 1NF, 2NF, 3NF(Normal Form)
    
    제 1 정규화, 1NF
    - 모든 컬럼(속성)은 원자값을 가진다
    - 여러개로 분리 가능한 값을 1개의 컬럼안에 넣지 말 것!
    - 1개 테이블 > (정규화) > 2개 이상의 테이블
    
    
    제 2 정규화, 2NF
    - 기본 키가 아닌 모든 컬럼은 기본키에 완전 함수 종속이어야 한다
    - 부분 함수 종속 발견!! > 부분 함수 종속 제거!!
    - 복합키를 가지는 테이블에서 발견된다.
    - 1개 테이블 > (정규화) > 2개 이상의 테이블
 
 
    제 3 정규화, 3NF
    - 기본 키가 아닌 모든 컬럼은 기본키에 완전 함수 종속이어야 한다
    - 이행 함수 종속 발견!! > 이행 함수 종속 제거!!
    - 1개 테이블 > (정규화) > 2개 이상의 테이블    
    
    역정규화
    - 정규화된 결과를 다시 원래대로 되돌린다

    - 다운로드 > 정규화.xlsx
*/
