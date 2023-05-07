1.Requerimientos a responder: 


a) Jugador más joven por país y  Jugador más veterano por país.

SELECT MIN("Player Age") as minimo_edad, MAX("Player Age") as maximo_edad, "Country Moving to"
FROM public.jugadores
where "Country Moving to" is not null
group by "Country Moving to"
order by "Country Moving to"

b) Edad media de los jugadores.

SELECT AVG("Player Age") as media_edad
FROM public.jugadores


c) Jugadores transferidos por posición.

SELECT "Player Position", count(*) as count_transfer
FROM public.jugadores
group by "Player Position"
order by count_transfer desc

d) ¿Cuál es el valor de mercado del jugador mejor pagado en el conjunto de datos?

SELECT  MAX("Player Market Value (M)") as maximo_mercado
FROM public.jugadores

e) Nombre del Jugador mejor pagado (transferencia) en el conjunto de datos.

SELECT "Player Name", MAX("Fees Paid for Player (M)") as count_paid
from public.jugadores
group by "Player Name"
order by count_paid desc
limit 1

f) Nombre de los Jugadores mejores pagos (transferencia) por posición en el conjunto de datos.

WITH ranked as(
SELECT "Player Name","Player Position", "Fees Paid for Player (M)",
DENSE_RANK() OVER(PARTITION BY "Player Position"  ORDER BY "Fees Paid for Player (M)"  DESC) AS rank_player
FROM public.jugadores
)
select "Player Name","Player Position", rank_player, "Fees Paid for Player (M)"
from ranked
where rank_player = 1 	
order by "Player Position"


g) ¿Qué clubes de la Premier League han fichado nuevos jugadores según el
conjunto de datos?

SELECT   "Club Moving to"
FROM public.jugadores
where "New League" = 'Premier League' AND
"On Loan" = 'No'
group by "Club Moving to"
order by "Club Moving to"


h) ¿Cuántos jugadores son menores de 18 años y en qué país estarán jugando?

WITH ranked as(
SELECT "Player Name","Country Moving to", "Player Age",
DENSE_RANK() OVER(PARTITION BY "Country Moving to" ORDER BY "Player Age" asc) AS rank_player_age
FROM public.jugadores
where "Player Age" < 18
)
select "Player Name","Country Moving to", "Player Age", rank_player_age
from ranked
where rank_player_age = 1 	
order by "Country Moving to"



2. Consultas adicionales: 

a) Total pagado por país en transferencias 

SELECT  "Country Moving to", sum("Fees Paid for Player (M)") AS total_pais
FROM public.jugadores
where "Fees Paid for Player (M)" <> 0
group by "Country Moving to"
order by total_pais desc


b)Posición más cara del mercado:

SELECT  "Player Position ", "Player Market Value (M))"
FROM public.jugadores
order by "Player Market Value (M))" desc
limit 1

c)Posición por la cual se pagó más dinero en las transferencias:

SELECT  "Player Position", "Player Market Value (M)"
FROM public.jugadores
order by "Player Market Value (M)" desc
limit 1

d) Los 5 paises con mas cantidad de transferencias de la temporada

SELECT "Country Moving to", count(*) as count_transfer
FROM public.jugadores
group by"Country Moving to"
order by count_transfer desc
limit 5


e)Los 5 clubes con más cantidad de transferencias de la temporada

SELECT "Club Moving to", count(*) as count_transfer
FROM public.jugadores
group by "Club Moving to"
order by count_transfer desc
limit 5
 
f)Las 5 ligas con más cantidad de transferencias de la temporada

SELECT "New League", count(*) as count_transfer
FROM public.jugadores
group by "New League"
order by count_transfer desc
limit 5

g)Promedio pagado por posición:

SELECT  "Player Position", round(AVG("Fees Paid for Player (M)"),2) as promedio
from public.jugadores
where "Fees Paid for Player (M)"  > 0
group by "Player Position"

h)Diferencia entre valor de mercado y pagado en transferencias:

SELECT "Player Name", "Player Position", "Player Market Value (M)",  "Fees Paid for Player (M)",
("Fees Paid for Player (M)" - "Player Market Value (M)" ) AS diferencia 
FROM public.jugadores
WHERE "Fees Paid for Player (M)"  > 0

i)El club que gastó más dinero en las transferencias esta temporada

SELECT  "Club Moving to", SUM("Fees Paid for Player (M)") as paid
FROM public.jugadores
WHERE  "On Loan" = 'No'
GROUP BY "Club Moving to"
order by paid desc
limit 1
 

j) El país que gastó más dinero en las transferencias esta temporada

SELECT  "Country Moving to", SUM("Fees Paid for Player (M)") as paid
FROM public.jugadores
WHERE  "On Loan" = 'No'
GROUP BY "Country Moving to"
order by paid desc
limit 1

k)La liga que gastó más dinero en las transferencias esta temporada

SELECT  "New League", SUM("Fees Paid for Player (M)") as paid
FROM public.jugadores
WHERE  "On Loan" = 'No'
GROUP BY "New League"
order by paid desc
limit 1
