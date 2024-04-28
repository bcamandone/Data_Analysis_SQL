--1.¿Cuáles son los detalles de todos los coches vendidos en el año 2023?
select * 
from cars c
join sales s
on c.car_id = s.car_id
where purchase_date between '2023-01-01' and '2023-12-31'

--2.¿Cuál es la cantidad total de autos vendidos por cada vendedor?
select sp.name, count(s.car_id) as cantidad
from sales s 
join salespersons sp
using(salesman_id)
group by 1
order by 2 desc

--3.¿Cuál es el ingreso total generado por cada tipo de automóvil? Utilice la columna cost_$
select c.type, sum(cost_$) as ingreso_total
from cars c
join sales s
on c.car_id = s.car_id
group by 1
order by 2 desc

--4.Muestre el detalle de los autos vendidos en el año 2022 por el vendedor Tom Lee
select s.car_id, make, type, style, cost_$
from cars c
join sales s
on c.car_id = s.car_id
join salespersons sp
on s.salesman_id = sp.salesman_id 
where sp.name= 'Tom Lee' and  extract(year from s.purchase_date) = 2022

--5.¿Cuál es el nombre y ciudad del vendedor que vendió la mayor cantidad de autos en el año 2023?
WITH max_vendedor as(
SELECT sp.salesman_id, count(s.car_id) as cantidad, sp.name, sp.city
from sales s 
join salespersons sp
on s.salesman_id = sp.salesman_id 
where extract(year from s.purchase_date) = 2023
group by 1,3,4
order by 2 desc  
limit 1)
SELECT name, city
from max_vendedor

--6.¿Cuál es el nombre y la edad del vendedor que generó mayores ingresos en el año 2022?
with max_vendedor_ingresos as (
select sp.name, sp.age, sum(cost_$)
from sales s 
join salespersons sp
on s.salesman_id = sp.salesman_id 
join cars c 
on c.car_id = s.car_id
where extract(year from s.purchase_date) = 2022
group by 1,2
order by 3 desc  
limit 1)
select name, age
from max_vendedor_ingresos
