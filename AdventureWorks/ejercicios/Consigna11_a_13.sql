--11) Crear una consulta que muestre el nombre del empleado, sus horas de vacaciones y un incremento de horas de vacaciones de un 15% para los que tienen menos de 50 hs. de vacaciones, 
--un 10% para los que tienen entre 50 y 70 hs. de vacaciones y un 5 % para el resto.

SELECT FirstName, vacationhours,
CASE
WHEN vacationhours < 50 THEN vacationhours * 1.15
WHEN vacationhours >= 50 AND vacationhours <70 THEN vacationhours *
1.1
ELSE vacationhours*1.05
END AS 'Licencia Bonificada'
FROM
HumanResources.Employee e join Person.Person p on e.BusinessEntityID =
p.BusinessEntityID
Order By vacationhours

--12) Informar la cantidad de Empleados masculinos y femeninos (en una sola fila).
  
SELECT
Count(CASE WHEN Gender = 'M' THEN 1 END) AS Hombres,
Count(CASE WHEN Gender = 'F' THEN 1 END) AS Mujeres
FROM HumanResources.Employee

--13) Del Departamento de Recursos Humanos se quiere saber los empleados que cobran mensual (PayFrequency 1) o por Quincena (PayFrequency 2), generar un reporte con
--Nombre, Apellido, Cargo y una nueva columna que especifique lo antes mencionado (“Mensual” o “Quincena”).
  
SELECT p.FirstName, p.LastName, e.JobTitle,
'Pago' = CASE eph.PayFrequency
WHEN 1 THEN 'Mensual'
WHEN 2 THEN 'Por Quincena'
ELSE 'N/A'
END
FROM Person.Person p
join HumanResources.Employee e on p.BusinessEntityID = e.BusinessEntityID
join HumanResources.EmployeePayHistory eph on e.BusinessEntityID =
eph.BusinessEntityID
