## Glosario del proyecto

**Ventas brutas:** Es el total facturado sin restar ni excluir ningún gasto.

Fórmula en éste proyecto: *SUM(price_usd*items_purchased)*

**Margen de ganancia sobre ventas (ventas netas):** Indica la rentabilidad de un producto, servicio o negocio. Es expresado en porcentaje; mientras más alto sea el número, más rentable es el negocio. Se calcula como la diferencia entre las ventas de un producto y su costo.

Fórmula en éste proyecto: *SUM((price_usd -cogs_usd)*items_purchased)/SUM(price_usd*items_purchased)*

**Margen Absoluto:** Es el margen en términos monetarios no es porcentaje: 

*SUM((price_usd -cogs_usd)*items_purchased)*

**Campañas:** Conjunto de anuncios o anuncio para un período de tiempo determinado (Ejemplo camapaña de black friday, campaña de navidad)

**Ads o anuncios:** Publicidad en marketing digital que se crea en internet.

**Sesiones**: La cantidad de veces que se ingresa a una página web. No importa el usuario.

## El cliente


Te acaban de contratar para la empresa de ecommerce online llamada “**ositofeliz**” que se dedica a vender *ositos de peluche super atractivos*. Actualmente cuenta con *4 modelos de peluches.*

## El problema


Como miembro del equipo de la startup, te va a tocar trabajar con el CEO, el director de marketing y el Gerente de la web para analizar ciertas métricas que queremos medir.

Tu objetivo será analizar la situación actual de la empresa. Medir  la conversión de la web y usar datos para entender las ventas e impacto de los productos.

## Ejecución


### Análisis de ventas

1. Queremos saber cuales son las ventas por año y por mes en términos brutos y luego el margen absoluto.
2. ¿Cuales son las ventas brutas medias de cada mes y año, devuelve los TOP 3? ¿Que puedes observar?
3. ¿Cuál es el producto que mas vende en términos monetarios (Ventas brutas)?
4. ¿Cuál es el producto que deja más margen en términos monetarios?
5. ¿Podemos saber cúal es la fecha de lanzamiento de cada producto?
6. Calcula las ventas brutas por año asi como el margen numérico y porcentual de cada producto y ordénalo por producto.
7. ¿Cuáles son los meses con mayor venta bruta, devuelve los TOP 3? 
    
 ### Análisis de trafico web
    
8. ¿Cuales son los ads(anuncios) o contenidos que han atraído más sesiones?
9. Es lo mismo sesiones que usuarios?¿Cuál es la cantidad de usuarios individuales?
10. ¿Y por source o fuente? Cantidad de usuarios únicos y sesiones?
11. ¿Cúales son las sources o fuentes que han dado más ventas?
12. ¿Cúales son los meses que han atraido más tráfico?
13. Ya que vimos el mes que ha tenido más trafico, podrías ver de ese mes la cantidad de sesiones que han venido por movil y la cantidad que han venido por ordenador?
14. ¿Qué campañas son las que han dado más margen por productos?


Se utilizara MySql como motor de base de datos para responder a estar preguntas.
