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
         
-- 4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
        select count(*) from tblZoo group by rollup(sizeof, family);

-- 5. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
        select * from tblAddressBook;
    
    
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

select substr(name, 1, 1), count(*) from tblAddressBook group by substr(name, 1, 1)  having count(*) >= 100; 


-- 7. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?

select * from tblAddressBook;
select hometown, count(*) from tblAddressBook where job in ('건물주', '건물주자제분') group by hometown;

select hometown, count(*) as 인원수,
(count(case 
when hometown = '서울' then '서울'
end) / count(*) * 100) as 서울인원수,
(count(case
when hometown <> '서울' then '지방'
end) / count(*) * 100) as 지방인원수
from tblAddressBook 
where job in ('건물주', '건물주자제분') group by hometown;

-- 비율 계산

