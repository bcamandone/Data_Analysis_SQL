-- 1) ¿Cuál es el promedio de km por año?

SELECT round(avg(km_driven)), year 
	FROM public."Autos"
	group by year
	order by year 
  
-- 2) El promedio de km de los autos del año 2018 es 27.234, ¿hay algún auto por debajo de ese promedio? Obtener el precio, el nombre y el km de los autos que cumplan con esa condición. Ordenar por precio.
-- a)  realizar una consulta con el dato del promedio brindado en la consigna
-- b) realizar una subconsulta para obtener el dato de promedio 

SELECT name, selling_price, km_driven
	FROM public."Autos"
	where km_driven < 27234 and year = 2018
	order by  selling_price


SELECT name, selling_price, km_driven, year
	FROM public."Autos"
	where km_driven < (select avg(km_driven) from public."Autos" where year = 2018)
	and year =  2018
	order by selling_price

-- 3) Obtener una lista con los distintos modelos de autos y la cantidad que existe de cada uno. Ordenar en forma descendente 

SELECT distinct name, count(*) as cantidad 
FROM public."Autos"
group by name
order by cantidad desc 

  
  
