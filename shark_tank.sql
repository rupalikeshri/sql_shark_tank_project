-- total episodes

select count(distinct epno) from data1;

--pitches

select count(distinct brand) from data1;

--pitches converted

select sum(a.converted_not_converted) as funding_recieved ,count(*) as total_pitches from (
select amount_invested_lakhs , case when amount_invested_lakhs>0 then 1 else 0   end as converted_not_converted from data1) a;


--success percenatge

select  (cast(sum(a.converted_not_converted) as float)/cast(count(*) as float))*100 from (
select amount_invested_lakhs , case when amount_invested_lakhs>0 then 1 else 0   end as converted_not_converted from data1) a; 

--total male

select  sum(male) from data1;

--total females

select sum(female) from data1;

--gender ratio

select sum(female)/sum(male) from data1;
   
--total invested amount

select sum(Amount_Invested_lakhs) from data1;

--average equity taken by the sharks

select AVG(equity_takenp) from data1 where equity_takenp>0;

--highest amount invested

select max(amount_invested_lakhs) from data1;

--highest equity taken by the sharks

select max(equity_takenp) from data1;

--pitches with atleast one women contestant

select sum(female_count) from
(select female,case when female> 0 then 1 else 0 end as female_count from data1) a;

--pitches converted having atleast one female

select sum(b.female_count) from (
select case when a.female>0 then 1 else 0 end  as female_count, a.* from(
(select * from data1 where Deal!='no deal')) a)b;

--avg number of teammebers

select avg(team_members) from data1;

--avg amount invested per deal

select avg(amount_invested_lakhs) as amount_invested_per_deal from
(select * from data1 where deal!='no deal')a;

-- avg age group of contestants

select avg_age, count(avg_age) cnt from data1 group by avg_age order by cnt desc;

--location with maximum contestant 


select locations, count(locations) cnt from data1 group by Locations order by cnt desc;
 
--which sector had maximum deals

select sector,count(sector) as max_cnt from data1 group by sector order by max_cnt desc;

--partner deals

select partners, count(partners) as cnt from data1 where partners!='-' group by partners order by cnt  desc;

--making the matrix

select 'ashneer' as keyy, COUNT(ashneer_amount_invested) from data1 where ashneer_amount_invested is not null 

select 'ashneer'as keyy,  count(ashneer_amount_invested) from data1 where ashneer_amount_invested is not  null  and ashneer_amount_invested!=0;

select 'ashneer' as keyy, sum(c.ashneer_amount_invested),avg(c.ashneer_equity_takenp)
from(select * from data1 where ashneer_equity_takenp!=0 and ashneer_equity_takenp is not null) c;


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount,n.avg_equity_taken from 

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'ashneer' as keyy, COUNT(ashneer_amount_invested) as total_deals_present from data1 where ashneer_amount_invested is not null ) a
inner join (
select 'ashneer'as keyy,  count(ashneer_amount_invested) as total_deals from data1
where ashneer_amount_invested is not  null  and ashneer_amount_invested!=0) b

on a.keyy=b.keyy)m

inner join 


(select 'ashneer' as keyy, sum(c.ashneer_amount_invested) as total_amount,avg(c.ashneer_equity_takenp) as avg_equity_taken
from(select * from data1 where ashneer_equity_takenp!=0 and ashneer_equity_takenp is not null) c) n
 
 on m.keyy=n.keyy;


 -- which is the startup in which the highest amount has been invested in each domain/sector



 select c.* from 
 (select brand, amount_invested_lakhs,sector,rank() over(partition by sector order by amount_invested_lakhs desc) rnk
 from data1) c 
 where c.rnk=1;


