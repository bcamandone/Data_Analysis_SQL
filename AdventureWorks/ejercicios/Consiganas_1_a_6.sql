-- 1) Obtener el ID de persona y el nombre de todas las personas que son jefes.

SELECT p.BusinessEntityID, p.FirstName, p.LastName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.JobTitle LIKE 'Chief%'

-- 2) Obtener el ID de persona, el nombre de la persona y el mail de cada uno de ellos.
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.EmailAddress
FROM Person.EmailAddress e
JOIN Person.Person p ON e.BusinessEntityID= p.BusinessEntityID

-- 3) Obtener el ID de persona, el nombre de persona y el teléfono de cada persona que su apellido comience con ‘A’
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.Person p
JOIN Person.PersonPhone pp ON p.BusinessEntityID= pp.BusinessEntityID
WHERE p.LastName LIKE 'A%'

-- 4) Obtener el ID de producto, el nombre del producto y la descripción de la subcategoría de cada producto de color ROJO, AZUL o NEGRO solamente de los
productos que TIENEN SUBCATEGORIA.

SELECT p.ProductID, p.Name, ps.Name
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID =
ps.ProductSubcategoryID
WHERE p.Color IN ('RED', 'BLUE', 'BLACK')

-- 5) Obtener el ID de producto, el nombre del producto y la descripción de la subcategoría de TODOS LOS PRODUCTOS.

SELECT p.ProductID, p.Name, ps.Name
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID =
ps.ProductSubcategoryID

-- 6) Obtener un listado que muestre el ID de cliente, el ID del store y el nombre del mismo (concatenado en un mismo campo) de todos los clientes.

SELECT concat(c.CustomerID,', ',c.StoreID,', ', s.Name)
FROM Sales.Customer c
JOIN Sales.Store s ON c.StoreID=s.BusinessEntityID
