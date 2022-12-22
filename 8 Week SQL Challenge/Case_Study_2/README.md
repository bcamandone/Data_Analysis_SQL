![2](https://user-images.githubusercontent.com/86261762/207048889-5b397612-e7af-4c2f-878e-43c94e707c8e.png)

Consignas: 

Antes de comenzar a escribir sus consultas SQL, es posible que desee investigar los datos, ¡quizás desee hacer algo con algunos de esos valores nulos y tipos de datos en las tablas customer_orders y runner_orders!

## A. Métricas de pizza

1) ¿Cuántas pizzas se pidieron?

2) ¿Cuántos pedidos únicos de clientes se realizaron?

3) ¿Cuántos pedidos exitosos entregó cada repartidor
?
4) ¿Cuántas pizzas de cada tipo se entregaron?

5) ¿Cuántas pizzas vegetarianas y amantes de la carne ordenó cada cliente?

6) ¿Cuál fue el número máximo de pizzas entregadas en un solo pedido?

7) Para cada cliente, ¿cuántas pizzas entregadas tenían al menos 1 cambio y cuántas no tenían cambios?

8) ¿Cuántas pizzas se entregaron que tenían exclusiones y extras?

9) ¿Cuál fue el volumen total de pizzas ordenadas para cada hora del día?

10) ¿Cuál fue el volumen de pedidos para cada día de la semana?

## B. Repartidores y experiencia del cliente

1) ¿Cuántos repartidores se inscribieron para cada período de 1 semana? (es decir, la semana comienza el 2021-01-01)

2) ¿Cuál fue el tiempo promedio en minutos que tardó cada repartidor en llegar a la sede de Pizza Runner para recoger el pedido?

3) ¿Existe alguna relación entre la cantidad de pizzas y el tiempo de preparación del pedido?

4) ¿Cuál fue la distancia promedio recorrida por cada cliente?

5) ¿Cuál fue la diferencia entre los tiempos de entrega más largos y más cortos para todos los pedidos?

6) ¿Cuál fue la velocidad promedio de cada repartidor para cada entrega? ¿Observa alguna tendencia para estos valores?

7) ¿Cuál es el porcentaje de entrega exitosa para cada corredor?

## C. Optimización de ingredientes
1) ¿Cuáles son los ingredientes estándar para cada pizza?
 
2) ¿Cuál fue el extra más comúnmente añadido?

3) ¿Cuál fue la exclusión más común?

4) Genere un artículo de pedido para cada registro en la tabla pedidos_clientes en el formato de uno de los siguientes:

   Meat Lovers

   Meat Lovers - Exclude Beef

   Meat Lovers - Extra Bacon

   Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

5) Genere una lista de ingredientes separados por comas ordenados alfabéticamente para cada pedido de pizza de la tabla customer_orders y agregue 2x delante de cualquier ingrediente relevante
Por ejemplo: "Amantes de la carne: 2xTocino, Carne de res, ... , Salami"

6) ¿Cuál es la cantidad total de cada ingrediente utilizado en todas las pizzas entregadas ordenadas por el más frecuente primero?

## D. Precios y calificaciones

1) Si una pizza Meat Lovers cuesta $ 12 y una vegetariana cuesta $ 10 y no hubo cargos por cambios, ¿cuánto dinero ha ganado Pizza Runner hasta ahora si no hay tarifas de entrega?

2) ¿Qué pasa si hubo un cargo adicional de $ 1 por los extras de pizza?
Nota: Agregar queso cuesta $1 extra

3) El equipo de Pizza Runner ahora quiere agregar un sistema de calificación adicional que permita a los clientes calificar a su repartidor. ¿Cómo diseñaría una tabla adicional para este nuevo conjunto de datos? Genere un esquema para esta nueva tabla e inserte sus propios datos para las calificaciones de cada cliente exitoso. 
Nota: ordene entre 1 a 5.

4) Usando su tabla recién generada, ¿puede unir toda la información para formar una tabla que tenga la siguiente información para entregas exitosas?
customer_id

    order_id

    runner_id

    rating

    order_time

    pickup_time

    Time between order and pickup

    Delivery duration

    Average speed

    Total number of pizzas

5) Si una pizza Meat Lovers costaba $12 y una vegetariana $10, precios fijos sin costo por extras, y a cada repartidor se le paga $0.30 por kilómetro recorrido, ¿cuánto dinero le queda a Pizza Runner después de estas entregas?

## E.Bonus Questions 
Si Danny quiere ampliar su gama de pizzas, ¿cómo afectaría esto al diseño de datos existente? Escriba una declaración INSERT para demostrar qué sucedería si se agregara una nueva pizza Supreme con todos los ingredientes al menú de Pizza Runner.
