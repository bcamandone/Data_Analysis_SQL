--7) Obtener todos los empleados cuyo apellido comience con la letra “S”

SELECT p.LastName 
FROM HumanResources.Employee e 
JOIN Person.Person p 
ON e.BusinessEntityID = p.BusinessEntityID
AND p.LastName like 'S%'

--8) Obtener el nombre del producto menos vendido y la cantidad de veces que se vendio

SELECT TOP 1  pp.Name, COUNT(ss.ProductID) AS cantidad_vendida
FROM Production.Product pp
JOIN Sales.SalesOrderDetail ss
ON pp.ProductID = ss.ProductID
GROUP BY pp.Name
ORDER BY COUNT(ss.ProductID) 

--9) Obtener un listado con el nombre del producto y la cantidad vendida ordenando de mayor a menor

SELECT pp.Name, COUNT(ss.ProductID) AS cantidad_vendida
from Production.Product pp
JOIN Sales.SalesOrderDetail ss
ON pp.ProductID = ss.ProductID
GROUP BY pp.Name
ORDER BY COUNT(ss.ProductID) DESC

--10) Obtener el monto de las ventas totales por territorio y ordenar por total vendido de mayor a menor  

SELECT st.Name, SUM(so.TotalDue) AS total_vendido
FROM Sales.SalesOrderHeader so
JOIN Sales.SalesTerritory st
ON so.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY total_vendido DESC




