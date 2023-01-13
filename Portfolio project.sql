select * from [Portfolio Project 2].dbo.dataset1
select * from [Portfolio Project 2].dbo.dataset2



-- number of rows in our dataset

select COUNT(*) from [Portfolio Project 2]..dataset1
select COUNT(*) from [Portfolio Project 2]..dataset2



--dataset for jharkhand & bihar
select * from [Portfolio Project 2]..dataset1
where state in ('Jharkhand' ,'Bihar')
order by state



--population of India
Select sum(population) Total_Pop from dataset2 



--Avg growth of India
select avg(growth)*100 Growth from dataset1



--Avg growth per state
Select state,avg(growth)*100 from dataset1
group by state



--Avg sex ratio per state(Use of round func,Descending func,order by)
Select state,round(avg(Sex_Ratio),0) Sex_Ratio from dataset1
Group by state
order by Sex_Ratio DESC



--Avg literacy rate(Having funct,order by which different funct are lined up --(eg having funct comes after group by but before order by))
Select state,round(avg(literacy),0) literacy from dataset1
Group by state
Having round(avg(literacy),0)>90
order by literacy DESC 



--Top 3 states showing highest growth% ratio(using top func)
Select top 3 state,avg(growth)*100 Growth_ratio from dataset1 group by state Order by Growth_ratio Desc


--bottom 3 states showing lowest sex ratio
Select top 3 state,round(avg(Sex_Ratio),0) Sex_Ratio from [Portfolio Project 2].. dataset1
Group by state
order by Sex_Ratio



--Top and bottom 3 states showing literacy rate(we will use 2 func,1-create temp table,union command)
drop table if exists #topstate
Create table #topstate
(	state nvarchar(255),
	topstate float
 )

Insert into #topstate
Select state,round(avg(Literacy),0) literacy from [Portfolio Project 2].. dataset1
Group by state
order by literacy desc

Select top 3 * from #topstate
order by #topstate.topstate desc

drop table if exists #bottomstate
Create table #bottomstate
(	state nvarchar(255),
	bottomstate float
 )

Insert into #bottomstate
Select state,round(avg(Literacy),0) literacy from [Portfolio Project 2].. dataset1
Group by state
order by literacy

Select top 3 * from #bottomstate
order by #bottomstate.bottomstate

-- we will use union func or opertaor to combine the tables

select * from(
Select top 3 * from #topstate
order by #topstate.topstate desc) a
union
select * from (
Select top 3 * from #bottomstate
order by #bottomstate.bottomstate)b
order by topstate




--states starting with letter a(using distinct func and like func)
select distinct state from [Portfolio Project 2]..dataset1
where lower(state) like 'a%' or LOWER(State) like '%b%'


--states starting with letter aand ending with the letter h(using distinct func and like func)
select distinct state from [Portfolio Project 2]..dataset1
where lower(state) like 'a%' and LOWER(State) like '%h'  



--find the total no of male and females using both the datasets
--joining the table(using joins)

Select d.state,sum(d.males) Males,sum(d.females) Females from 
(select c.District,c.State,round(population/(c.Sex_Ratio+1),0) as males,round((Sex_Ratio*c.Population)/(Sex_Ratio+1),0) as females from 
(select a.District,a.State,a.Sex_Ratio/1000 as Sex_Ratio,b.population from [Portfolio Project 2]..dataset1 as a
 left join [Portfolio Project 2]..dataset2 as b
	on a.District=b.District) as c) as d
group by d.State                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  