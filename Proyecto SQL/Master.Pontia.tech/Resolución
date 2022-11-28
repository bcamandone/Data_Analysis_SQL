
#Análisis de Ventas 

#1 Queremos saber cuales son las ventas por año y por mes en términos brutos y luego el margen absoluto.

SELECT 
EXTRACT( YEAR_MONTH FROM created_at) month_year,
FORMAT(SUM(items_purchased*price_usd),2,'de_DE') as ventas_brutas,
FORMAT(SUM(items_purchased*cogs_usd),2,'de_DE') as costo_de_ventas,
FORMAT (SUM(items_purchased*(price_usd-cogs_usd)),2,'de_DE') as margen_absoluto
FROM ositofeliz.orders
GROUP BY month_year
ORDER BY month_year;

#2 ¿Cuales son las ventas brutas medias de cada mes y año, devuelve los TOP 10? ¿Que puedes observar?

SELECT 
EXTRACT( YEAR_MONTH FROM created_at) month_year,
FORMAT(AVG(items_purchased*price_usd),2,'de_DE') as ventas_brutas
FROM ositofeliz.orders
GROUP BY month_year
ORDER BY ventas_brutas DESC
LIMIT 10;

# 3 ¿Cuál es el producto que mas vende?

SELECT 
p.product_name,
FORMAT(SUM(o.items_purchased*o.price_usd),2,'de_DE') as ventas_brutas
FROM ositofeliz.orders o
LEFT JOIN ositofeliz.order_items oi on o.order_id = oi.order_id
LEFT JOIN ositofeliz.products p on p.product_id = oi.product_id
GROUP BY product_name
ORDER BY SUM(items_purchased*o.price_usd) DESC
LIMIT 1;

# 4 ¿Cuál es el producto que deja más margen?

SELECT 
p.product_name,
FORMAT(SUM(o.items_purchased*(o.price_usd-o.cogs_usd)),2,'de_DE') as margen_absoluto
FROM ositofeliz.orders as o
LEFT JOIN ositofeliz.order_items as oi on o.order_id = oi.order_id
LEFT JOIN ositofeliz.products as p on p.product_id = oi.product_id
GROUP BY product_name
ORDER BY SUM(o.items_purchased*(o.price_usd-o.cogs_usd)) DESC
LIMIT 1;

# 5 ¿Podemos saber cúal es la fecha de lanzamiento de cada producto?

# La fecha de la primera venta de un producto
# Fecha de la primera visualización del user
# Fecha de creación de producto
# Tomar como fecha la de la creación de la campaña de marketing.

SELECT 
MIN(o.created_at) as fecha_minima,
product_name
FROM ositofeliz.orders as o
LEFT JOIN ositofeliz.order_items as oi on oi.order_id = o.order_id
LEFT JOIN ositofeliz.products p on p.product_id = oi.product_id
GROUP BY product_name;

# 6 Calcula las ventas netas por año asi como el margen numérico
# y porcentual de cada producto y ordénalo por producto.

SELECT 
YEAR(o.created_at) as año,
product_name,
FORMAT(sum(items_purchased*o.price_usd),2,'de_DE') as ventas_brutas,
format(sum(items_purchased*(o.price_usd-o.cogs_usd)),2,'de_DE') as margen_absoluto,
format(sum(items_purchased*(o.price_usd-o.cogs_usd))/sum(items_purchased*o.price_usd),2,'de_DE')  as margen_porcentual
FROM ositofeliz.orders as o
LEFT JOIN ositofeliz.order_items as oi on oi.order_id = o.order_id
left join ositofeliz.products as p on p.product_id = oi.product_id
GROUP BY año,product_name

# 7 ¿Cuáles son los meses de ventas brutas mas fuertes? 

SELECT 
MONTH(created_at) as mes,
FORMAT(SUM(price_usd),2) as ventas_brutas
FROM ositofeliz.orders
GROUP BY mes
ORDER BY SUM(price_usd) desc;


# Análisis WEB 

# 8 ¿Cuales son los ads o contenidos que han atraído más sesiones?

SELECT 
utm_content,
format(COUNT(website_session_id),2) as sesiones
FROM ositofeliz.website_sessions
GROUP BY utm_content
ORDER BY COUNT(website_session_id) desc;

# 9 Es lo mismo sesiones que usuarios?¿Cuál es la cantidad de usuarios individuales?

SELECT 
utm_content,
format(COUNT(website_session_id),2) as sesiones,
FORMAT(COUNT(DISTINCT user_id),2) as usuarios
FROM ositofeliz.website_sessions
GROUP BY utm_content
ORDER BY COUNT(website_session_id) desc;

# 10 ¿Y por source o fuente? Cantidad de usuarios y sesiones?

SELECT 
utm_source,
format(COUNT(website_session_id),2) as sesiones,
FORMAT(COUNT(DISTINCT user_id),2) as usuarios
FROM ositofeliz.website_sessions
GROUP BY utm_source
ORDER BY COUNT(website_session_id) desc

# 11 ¿Cúales son las sources o fuentes que han dado más ventas?

SELECT 
utm_source,
FORMAT(sum(price_usd),2) AS ventas_brutas
FROM ositofeliz.website_sessions s
LEFT JOIN ositofeliz.orders o on o.website_session_id = s.website_session_id
GROUP BY utm_source
ORDER BY sum(price_usd) DESC

#12 ¿Cúales son los meses que han atraido más tráfico?

SELECT 
month(created_at) as mes,
format(COUNT(website_session_id),2) as sesiones
FROM ositofeliz.website_sessions
GROUP BY mes
ORDER BY COUNT(website_session_id) desc

# 13 Ya que vimos que el mes de noviembre es el que ha tenido más trafico, podrías ver de ese mes la cantidad de sesiones que han venido por movil y 
#la cantidad que han venido por ordenador?

SELECT 
device_type,
format(COUNT(website_session_id),2) as sesiones
FROM ositofeliz.website_sessions
where month(created_at)=11
GROUP BY device_type
ORDER BY COUNT(website_session_id) desc

# 14 ¿Qué campañas son las que han dado más margen por productos?

SELECT 
utm_Campaign,
product_name,
FORMAT(SUM(o.price_usd - o.cogs_usd),2) as margen
FROM ositofeliz.orders o 
LEFT JOIN ositofeliz.order_items oi on oi.order_id = o.order_id
LEFT JOIN ositofeliz.products p on p.product_id = p.product_id
LEFT JOIN ositofeliz.website_sessions s on o.website_session_id = s.website_session_id
GROUP BY 
utm_Campaign,
product_name
