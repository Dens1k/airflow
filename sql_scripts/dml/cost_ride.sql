--Скрипт показывает среднюю стоимость 1-ой поездки в развере дня и месяца
--для чистоты выборки убраны выбросы 
--конечный селект позволяет увидеть самые дорогие дни, с общим оборотом и 
--информиацией в разрезе месяца 

with t1 as (
select cast(tpep_pickup_datetime as date) as tpep_pickup_datetime, count(*) as total_order, round(sum(total_amount)) as total_amount
from public.yellow_taxi_data 
group by cast(tpep_pickup_datetime as date)
), avg_day_cost as (
select t1.* , concat_ws('-',extract(year from tpep_pickup_datetime),extract(month from tpep_pickup_datetime)) as year_mnth, round(total_amount/total_order) as avg_day_cost
from t1 
where total_order > (select avg(total_order) from t1)/10
), avg_mnth_cost as (
select year_mnth, round(avg(avg_day_cost)) avg_mnth_cost
from avg_day_cost
group by year_mnth
)
select d.*, n.avg_mnth_cost 
from avg_day_cost d
join avg_mnth_cost n
	on d.year_mnth = n.year_mnth 
order by avg_day_cost desc  