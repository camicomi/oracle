-- ### group by ###################################

-- 1. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.

    select * from tblZoo;
    
    select family, round(avg(leg)) from tblZoo group by family;


select * from traffic_accident;
-- 2. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
        select 
        TRANS_TYPE,
        count(total_acct_num),
        count(death_person_num),
        round(avg(death_person_num))
        from traffic_accident group by TRANS_TYPE;
    
-- 3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
         select * from tblZoo;
         
         select count(*) from tblZoo where thermo = 'variable' group by breath;
         
-- 4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
    
        -- varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열, 찾을 문자열, 바꿀 문자열, [찾을 문자열, 바꿀 문자열]xN)
        select family || decode(sizeof, 'small', '소형', 'medium', '중형', 'large', '대형') as 분류, count(family) from tblZoo group by family,sizeof;

-- 5. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
        select * from tblAddressBook;
        select email, count(email) from tblAddressBook group by email having count(email) > 1;
    
    
-- 3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
    select * from tblZoo;
    
    select breath, count(family) from tblZoo where thermo = 'variable' group by breath;
        
-- 4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
        select *  from tblZoo;
        
        select sizeof, family, count(*) from tblZoo group by sizeof, family;

-- 5. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
    select * from tblAddressBook;

    
    select email from tblAddressBook group by email having count(*) > 1;

-- 6. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.

-- 성씨 추출
select substr(name, 1, 1) from tblAddressBook;

select substr(name, 1, 1) from tblAddressBook group by substr(name, 1, 1)  having count(*) >= 100; 


-- 7. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?




select job, 
round(count(case 
when substr(address,1,2) like ('%서울%') then 1
end)/count(job)*100, 1) || '%' as "서울 거주자",
round(count(case
when substr(address,1,2) not like ('%서울%') then 1
end)/count(job)*100, 1) || '%' as "지방 거주자"
from tbladdressbook group by job having job in ('건물주', '건물주자제분');

