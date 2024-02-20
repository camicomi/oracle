-- ### group by ###################################


-- 1. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.

SELECT family as "종" , round(avg(leg),2) as "평균 다리 갯수" FROM tblZoo
    GROUP BY family;


-- 2. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.

SELECT 
    trans_type as "교통수단명", 
    sum(total_acct_num) as "총 교통사고 발생 수",
    sum(death_person_num) as "총 사망자수", 
    round(sum(death_person_num)/sum(total_acct_num),3) as "사건 당 평균 사망자" 
FROM traffic_accident
    where total_acct_num > 0
        GROUP BY trans_type;
        
    
-- 3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.

SELECT 
    count(case
        when breath in ('lung') then 1
    end) as "변온,폐 호흡",
    count(case
        when breath in ('gill') then 1
    end) as "변온,아가미 호흡"
FROM tblzoo
    GROUP BY thermo
        HAVING thermo = 'variable';
        
        
-- 4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.

SELECT family||decode(sizeof,'small','소형','medium','중형','large','대형') as 분류, count(family) FROM tblzoo
    GROUP BY family,sizeof 
        ORDER BY family asc, sizeof desc;
        

-- 5. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.

SELECT 
    email, count(email)
FROM tbladdressbook 
    group by email having count(email) > 1;
    

-- 6. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.

SELECT substr(name,1,1) FROM tbladdressbook group by substr(name,1,1) having count(substr(name,1,1)) >= 100;


-- 7. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?

SELECT job,
    round(count(case
        when substr(address,1,2) like ('%서울%') then 1 
    end)/count(job)*100,2)||'%' as "서울 거주자",
     round(count(case
        when substr(address,1,2) not like ('%서울%') then 1 
    end)/count(job)*100,2)||'%' as "(비)서울 거주자"   
FROM tbladdressbook group by job having job in ('건물주','건물주자제분');

