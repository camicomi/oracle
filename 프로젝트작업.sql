/* 모든 테이블 create문*/

/* 관리자 테이블 */

CREATE TABLE tblAdmin(
    admin_id varchar2(10),      -- 관리자 아이디
    admin_pw varchar2(10),      -- 관리자 비밀번호
    
    constraint tbladmin_seq_pk primary key(admin_id),
    constraint tbladmin_notnull check(admin_pw is not null)
);
--------------------------------------------------------------------------------------
/* 소속 테이블 */
CREATE TABLE tblAff (
	aff_seq  number,         -- 소속seq
	aff_name varchar2(10),   -- 소속 이름 
    
    constraint tblAff_aff_seq_pk primary key(aff_seq),
    constraint tblAff_notnull check(aff_name is not null)
);
--------------------------------------------------------------------------------------
/* LEVEL 테이블 */
CREATE TABLE tblLevel (
	level_seq  number,       -- 레벨 seq
	level_auth number,       -- LEVEL
    aff_seq    number,       -- 소속 seq
    
    constraint tblLevel_level_seq_pk primary key(level_seq),
    constraint tblLevel_notnull check(level_auth is not null and aff_seq is not null),
    constraint tblLevel_fk foreign key(aff_seq) references tblAff(aff_seq)
);
--------------------------------------------------------------------------------------

/* 로그인 테이블 */
CREATE TABLE tblLogin (
	login_seq number,         -- 로그인정보 seq
	login_id  varchar2(20),   -- 아이디
    login_level     number,         -- 레벨 seq
    
    constraint tblLogin_login_seq_pk primary key(login_seq),
    constraint tblLogin_notnull check(login_id is not null and login_level is not null),
    constraint tblLogin_fk foreign key(login_level) references tblLevel(level_seq)
);
--------------------------------------------------------------------------------------

/* 인사테이블 */
CREATE TABLE tblInsa (
	insa_seq NUMBER,    -- 인사 seq
	login_seq NUMBER,   -- 로그인 seq
    
    constraint tblInsa_insa_seq_pk primary key(insa_seq),
    constraint tblInsa_notnull check(insa_seq is not null and login_seq is not null),
    constraint insa_login_seq_fk foreign key(login_seq) references tblLogin(login_seq)
);
--------------------------------------------------------------------------------------

/* 토픽 테이블 */
CREATE TABLE tblAgen (
	agen_seq        NUMBER,   -- 토픽 seq
	agen_category   NUMBER,   -- 토픽카테고리
    
    constraint tblAgen_agen_seq_pk primary key(agen_seq),
    constraint tblAgen_notnull check(agen_category is not null)
);
--------------------------------------------------------------------------------------
/* 교육생 테이블 */
CREATE TABLE tblStudent (
	student_seq   number,       -- 교육생 seq
    student_name  varchar2(50), -- 이름
    student_ssn   varchar2(14), -- 주민번호
    student_tel   varchar2(13), -- 전화번호
    student_level number,       -- 레벨
    
    constraint tblStudent_student_seq_pk primary key(student_seq),
    constraint tblStudent_student_seq_fk foreign key(student_seq) references tblInsa(insa_seq),
    constraint tblStudent_notnull check(student_name is not null and student_ssn is not null and student_level is not null),
    constraint tblStudent_student_level_fk foreign key(student_level) references tblLevel(level_seq)
);
--------------------------------------------------------------------------------------
/* 출결 테이블 */
CREATE TABLE tblAttend (
	student_seq  number,                        -- 교육생 seq
    curr_date    date,                          -- 현재 날짜
    arri_date    date,                          -- 도착 날짜
    leave_date   date,                          -- 퇴근시간
    attend_stus  varchar2(6) default '결석',   -- 상태
    
    constraint tblAttend_pk primary key(student_seq, curr_date),
    constraint tblAttend_student_seq_fk foreign key(student_seq) references tblStudent(student_seq),
    constraint tblAttend_notnull check(attend_stus is not null)
);
--------------------------------------------------------------------------------------
/* 취업여부 테이블 */
CREATE TABLE tblEmplStus (
	student_seq number,     -- 교육생 seq
    emp_stus    char,       -- 취업여부(y/n)
    
    constraint tblEmplStus_pk primary key(student_seq),
    constraint tblEmplStus_student_seq_fk foreign key(student_seq) references tblStudent(student_seq),
    constraint tblEmplStus_emp_stus_check check (emp_stus in ('y', 'n'))
);
--------------------------------------------------------------------------------------



-- 1. 과정 수강 이력
CREATE TABLE tblStudentCrsHis (
	sch_seq NUMBER NOT NULL, /* SEQ */
	student_seq NUMBER NOT NULL, /* 교육생SEQ */
	sch_sdate DATE NOT NULL, /* 시작일 */
	sch_edate DATE, /* 종료일 */
	sch_planedate DATE NOT NULL, /* 종료예정일 */
	crsHis_seq NUMBER NOT NULL /* 과정이력SEQ */
);

ALTER TABLE tblStudentCrsHis
	ADD
		CONSTRAINT PK_tblStudentCrsHis
		PRIMARY KEY (
			sch_seq
		);   
        
select * from tblStudentCrsHis;
drop table tblStudentCrsHis;

-- 1. 과정 수강 이력 더미데이터

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 101, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-04-30', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1001);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 102, TO_DATE('2023-02-20', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-06-16', 'YYYY-MM-DD'), 1002);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 103, TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2023-05-25', 'YYYY-MM-DD'), TO_DATE('2023-05-26', 'YYYY-MM-DD'), 1003);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 104, TO_DATE('2023-04-05', 'YYYY-MM-DD'), TO_DATE('2023-07-20', 'YYYY-MM-DD'), TO_DATE('2023-07-21', 'YYYY-MM-DD'), 1004);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 105, TO_DATE('2023-05-12', 'YYYY-MM-DD'), TO_DATE('2023-08-30', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'), 1005);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 106, TO_DATE('2023-06-25', 'YYYY-MM-DD'), TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-11', 'YYYY-MM-DD'), 1006);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 107, TO_DATE('2023-07-30', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'), TO_DATE('2023-11-06', 'YYYY-MM-DD'), 1007);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 108, TO_DATE('2023-08-18', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), TO_DATE('2023-12-21', 'YYYY-MM-DD'), 1008);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 109, TO_DATE('2023-09-09', 'YYYY-MM-DD'), TO_DATE('2023-12-30', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 1009);

INSERT INTO tblStudentCrsHis (sch_seq, student_seq, sch_sdate, sch_edate, sch_planedate, crsHis_seq)
VALUES ((SELECT nvl(MAX(sch_seq), 0) + 1 FROM tblStudentCrsHis), 110, TO_DATE('2023-10-03', 'YYYY-MM-DD'), TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-16', 'YYYY-MM-DD'), 1010);


-- 2. 관리자
CREATE TABLE tblAdmin (
	admin_id VARCHAR2(10) NOT NULL, /* 아이디 */
	admin_pw VARCHAR2(10) NOT NULL /* 비밀번호 */
);



-- 2. 관리자 더미데이터
INSERT INTO tblAdmin (admin_id, admin_pw)
VALUES ('admin1', 'password1');

INSERT INTO tblAdmin (admin_id, admin_pw)
VALUES ('admin2', 'password2');

INSERT INTO tblAdmin (admin_id, admin_pw)
VALUES ('admin3', 'password3');

INSERT INTO tblAdmin (admin_id, admin_pw)
VALUES ('admin4', 'password4');

INSERT INTO tblAdmin (admin_id, admin_pw)
VALUES ('admin5', 'password5');

select * from tblAdmin;


-- 3. 레벨
CREATE TABLE tblLevel (
	level_seq NUMBER NOT NULL, /* 레벨 SEQ */
	level_auth NUMBER NOT NULL, /* LEVEL */
	aff_seq NUMBER NOT NULL /* 소속 SEQ */
);

ALTER TABLE tblLevel
	ADD
		CONSTRAINT PK_tblLevel
		PRIMARY KEY (
			level_seq
		);


-- 3. 레벨 더미데이터
INSERT INTO tblLevel (level_seq, level_auth, aff_seq)
VALUES ((SELECT nvl(MAX(level_seq), 0) + 1 FROM tblLevel), 1, 1);

INSERT INTO tblLevel (level_seq, level_auth, aff_seq)
VALUES ((SELECT nvl(MAX(level_seq), 0) + 1 FROM tblLevel), 2, 2);

INSERT INTO tblLevel (level_seq, level_auth, aff_seq)
VALUES ((SELECT nvl(MAX(level_seq), 0) + 1 FROM tblLevel), 3, 3);

select * from tblLevel;

-- 4. 소속
CREATE TABLE tblAff (
	aff_seq NUMBER NOT NULL, /* SEQ */
	aff_name VARCHAR2(10) NOT NULL /* 소속이름 */
);

ALTER TABLE tblAff
	ADD
		CONSTRAINT PK_tblAff
		PRIMARY KEY (
			aff_seq
		);


delete from tblAff;
select * from tblAff;
-- 4. 소속 더미데이터
INSERT INTO tblAff (aff_seq, aff_name)
VALUES ((SELECT nvl(MAX(aff_seq), 0) + 1 FROM tblAff), '관리자');

INSERT INTO tblAff (aff_seq, aff_name)
VALUES ((SELECT nvl(MAX(aff_seq), 0) + 1 FROM tblAff), '교사');

INSERT INTO tblAff (aff_seq, aff_name)
VALUES ((SELECT nvl(MAX(aff_seq), 0) + 1 FROM tblAff), '교육생');

-- 5. 출결
CREATE TABLE tblAttend (
	student_seq NUMBER NOT NULL, /* 교육생SEQ */
	curr_date DATE NOT NULL, /* 현재날짜 */
	arri_date DATE, /* 도착시간 */
	leave_date DATE, /* 퇴근시간 */
	attend_stus VARCHAR2(6) NOT NULL /* 상태 */
);

-- attend_stus의 default 값은 '결석'이며, 종류에는 정상, 지각, 조퇴, 외출, 병가, 기타 가 있다.

ALTER TABLE tblAttend
	ADD
		CONSTRAINT PK_tblAttend
		PRIMARY KEY (
			student_seq,
			curr_date
		);
        

select * from tblAttend;        
-- 5.  출결 더미데이터
-- 더미 데이터 삽입
INSERT INTO tblAttend (student_seq, curr_date, arri_date, leave_date, attend_stus)
VALUES (101, TO_DATE('2024-02-29', 'YYYY-MM-DD'), TO_DATE('2024-02-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-02-29 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), '정상');

INSERT INTO tblAttend (student_seq, curr_date, arri_date, leave_date, attend_stus)
VALUES (102, TO_DATE('2024-02-29', 'YYYY-MM-DD'), TO_DATE('2024-02-29 08:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-02-29 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), '조퇴');

INSERT INTO tblAttend (student_seq, curr_date, attend_stus)
VALUES (103, TO_DATE('2024-02-29', 'YYYY-MM-DD'), '결석');

INSERT INTO tblAttend (student_seq, curr_date, attend_stus)
VALUES (104, TO_DATE('2024-02-29', 'YYYY-MM-DD'), '결석');

INSERT INTO tblAttend (student_seq, curr_date, arri_date, leave_date, attend_stus)
VALUES (105, TO_DATE('2024-02-29', 'YYYY-MM-DD'), TO_DATE('2024-02-29 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-02-29 18:20:00', 'YYYY-MM-DD HH24:MI:SS'), '지각');

INSERT INTO tblAttend (student_seq, curr_date, attend_stus)
VALUES (106, TO_DATE('2024-02-29', 'YYYY-MM-DD'), '결석');

INSERT INTO tblAttend (student_seq, curr_date, arri_date, leave_date, attend_stus)
VALUES (107, TO_DATE('2024-02-29', 'YYYY-MM-DD'), TO_DATE('2024-02-29 09:08:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-02-29 17:55:00', 'YYYY-MM-DD HH24:MI:SS'), '정상');

INSERT INTO tblAttend (student_seq, curr_date, attend_stus)
VALUES (108, TO_DATE('2024-02-29', 'YYYY-MM-DD'), '기타');

INSERT INTO tblAttend (student_seq, curr_date, attend_stus)
VALUES (109, TO_DATE('2024-02-29', 'YYYY-MM-DD'), '병가');

INSERT INTO tblAttend (student_seq, curr_date, arri_date, leave_date, attend_stus)
VALUES (110, TO_DATE('2024-02-29', 'YYYY-MM-DD'), TO_DATE('2024-02-29 09:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-02-29 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), '조퇴');

-- 6. 성적

CREATE TABLE tblScore (
	score_seq NUMBER NOT NULL, /* 성적SEQ */
	crsHis_seq NUMBER NOT NULL, /* 과정이력SEQ */
	subj_seq NUMBER NOT NULL, /* 과목SEQ */
	student_seq NUMBER NOT NULL, /* 교육생SEQ */
	prac_score NUMBER, /* 실기점수 */
	theory_score NUMBER, /* 필기점수 */
	attend_score NUMBER NOT NULL /* 출결점수 */
);

-- attend_score은 최소 20점 이상입니다. 
-- prac_score + theory_score + attend_score = 100 이어야 합니다. 

ALTER TABLE tblScore
	ADD
		CONSTRAINT PK_tblScore
		PRIMARY KEY (
			score_seq
		);
        
select * from tblScore;
        
-- 6. 성적 더미데이터
INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1001, 2001, 101, 30, 40, 30);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1002, 2002, 102, 35, 40, 25);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1003, 2003, 103, 25, 35, 40);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1004, 2004, 104, 40, 40, 20);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1005, 2005, 105, 30, 40, 30);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1006, 2006, 106, 35, 45, 20);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1007, 2007, 107, 25, 35, 40);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1008, 2008, 108, 40, 40, 20);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1009, 2009, 109, 30, 40, 30);

INSERT INTO tblScore (score_seq, crsHis_seq, subj_seq, student_seq, prac_score, theory_score, attend_score)
VALUES ((SELECT nvl(MAX(score_seq), 0) + 1 FROM tblScore), 1010, 2010, 110, 35, 45, 20);

-- 7. 시험문제 파일 등록여부

drop table tblTestStus;

CREATE TABLE tblTestStus (
	ts_seq NUMBER NOT NULL, /* 등록여부SEQ */
	ts_stus CHAR NOT NULL, /* 등록여부 */
	ts_type VARCHAR2(6) NOT NULL, /* 실기/필기여부 */
	subj_seq NUMBER NOT NULL, /* 과목SEQ */
	crsHis_seq NUMBER NOT NULL /* 과정이력SEQ */
);

-- ts.stus는 'Y' 아니면 'N'으로만 등록된다.
-- ts.type 은 '실기' 아니면 '필기'로만 등록된다. 

ALTER TABLE tblTestStus
	ADD
		CONSTRAINT PK_tblTestStus
		PRIMARY KEY (
			ts_seq
		);

  
-- 7. 시험문제 파일등록여부 더미데이터

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (1, 'Y', '실기', 2001, 1001);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (2, 'Y', '필기', 2002, 1002);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (3, 'Y', '실기', 2003, 1003);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (4, 'N', '필기', 2004, 1004);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (5, 'N', '실기', 2005, 1005);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (6, 'Y', '필기', 2006, 1006);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (7, 'Y', '실기', 2007, 1007);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (8, 'N', '필기', 2008, 1008);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (9, 'N', '실기', 2009, 1009);

INSERT INTO tblTestStus (ts_seq, ts_stus, ts_type, subj_seq, crsHis_seq)
VALUES (10, 'Y', '필기', 2010, 1010);