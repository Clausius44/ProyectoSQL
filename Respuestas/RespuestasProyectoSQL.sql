/*DataProject: Lógica Consultas SQL
 * 
 *  2. Muestra los nombres de todas las películas con una clasificación por
edades de 'R'. */
SELECT 
	f.title AS titulo
FROM film AS f
WHERE f.rating = 'R'
;

/*3. Encuentra los nombres de los actores que tengan un “actor_id entre 30
y 40.*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo, 
	a.actor_id AS id_actor
FROM actor AS a
WHERE a.actor_id BETWEEN 30 AND 40
;

/*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
SELECT 
	f.title AS titulo
FROM film AS f
WHERE f.language_id = f.original_language_id
;

/*5. Ordena las películas por duración de forma ascendente.*/
SELECT 
	f.title AS titulo, 
	f.length AS duracion
FROM film AS f
ORDER BY f.length ASC

/*6. Encuentra el nombre y apellido de los actores que tengan ‘Allen en su apellido*/
-- Ya que la BBDD tiene los nombres en mayusculas he usado 'Allen' pero lo he adaptado la BBDD
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo
FROM actor AS a 
WHERE a.last_name LIKE upper('%Allen%')
;

/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla "film" y muestra la clasificación junto con el recuento.*/
SELECT 
	f.rating AS clasificacion, 
	count(f.title) AS cantidad
FROM film AS f
GROUP BY f.rating
;

/*8. Encuentra el título de todas las películas que son ‘PG13 o tienen una duración mayor a 3 horas en la tabla film.*/
SELECT 
	f.title AS titulo, 
	f.length AS duracion
FROM film AS f
WHERE f.rating = 'PG-13'
OR f.length > 180
;

/*9. cuentra la variabilidad de lo que costaría reemplazar las películas.*/
SELECT 
	variance(f.replacement_cost) AS varianza
FROM film AS f
;

/*10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/
-- He pensado que hacer dos querys limitadas y unirlas era mas entendible
(SELECT 
	f1.title AS titulo, 
	f1.length AS duracion
	FROM film AS f1
	ORDER BY f1.length ASC
	LIMIT 1)
UNION ALL
(SELECT 
	f2.title AS titulo, 
	f2.length AS duracion
	FROM film AS f2
	ORDER BY f2.length DESC
	LIMIT 1)
;

/*11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/
SELECT 
	p.amount AS coste,
	p.payment_date AS fecha
FROM payment AS p
ORDER BY p.payment_date DESC
LIMIT 1
OFFSET 2
;

/*12. Encuentra el título de las películas en la tabla “film que no sean ni ‘NC17 ni ‘G en cuanto a su clasificación.*/
SELECT 
	f.title AS titulo,
	f.rating AS clasificacion
FROM film AS f
WHERE f.rating NOT IN ('NC-17', 'G')
;

/*13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.*/
SELECT 
	f.rating AS clasificación, 
	concat(round(avg(f.length), 2), ' minutos') AS duración_promedio
FROM film AS f
GROUP BY f.rating
;

/*14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos*/
SELECT 
	f.title AS titulo_pelicula,
	f.length AS duración
FROM film AS f
WHERE f.length > 180
;

/*15. Cuánto dinero ha generado en total la empresa?*/
SELECT 
	round(sum(p.amount), 2) AS total_generado
FROM payment AS p
;

/*16. Muestra los 10 clientes con mayor valor de id.*/
SELECT 
	concat(c.first_name, ' ', c.last_name) AS nombre_completo,
	c.customer_id AS id_cliente
FROM customer AS c
ORDER BY c.customer_id DESC
LIMIT 10
;

/*17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo
FROM film AS f
JOIN film_actor AS fa
ON f.film_id = fa.film_id
JOIN actor AS a
ON fa.actor_id = a.actor_id
WHERE f.title = upper('Egg Igby')
;

/*18. Selecciona todos los nombres de las películas únicos.*/
SELECT 
	DISTINCT f.title AS titulo
FROM film AS f
;

/*19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film.*/
SELECT 
	f.title AS titulo, 
	c."name" AS categoria, 
	f.length AS duracion
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
WHERE c."name" = 'Comedy'
AND f.length > 180
;

/*20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/
-- He creado una CTE que solo calcula el promedio de duracion por categoría, de otra forma era muy liado
WITH duracion_categoria AS(
	SELECT 
		c."name" AS nombre_categoria, 
		round(avg(f.length), 2) AS duracion
	FROM film AS f
	JOIN film_category AS fc
	ON fc.film_id = f.film_id
	JOIN category AS c
	ON fc.category_id = c.category_id
	GROUP BY c."name"
	)
SELECT 
	dc.nombre_categoria, 
	duracion AS duracion
FROM duracion_categoria AS dc
WHERE dc.duracion > 110
;

/*21 ¿Cuál es la media de duración del alquiler de las películas?*/
SELECT 
	round(avg(f.rental_duration), 2) AS promedio_alquiler
FROM film AS f
;

/*22. ¿Cuál es la media de duración del alquiler de las películas?*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo
FROM actor AS a 
;

/*23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente*/
SELECT 
	date(r.rental_date) AS fecha, 
	count(r.rental_id) AS cantidad
FROM rental AS r
GROUP BY date(r.rental_date)
ORDER BY cantidad DESC
;

/*24. Encuentra las películas con una duración superior al promedio.*/
SELECT 
	f.title AS titulo, 
	f.length AS duracion
FROM film AS f
WHERE f.length > (SELECT avg(f2.length)
FROM film AS f2)
;

/*25. Averigua el número de alquileres registrados por mes.*/
SELECT EXTRACT('Month'
FROM r.rental_date) AS mes, count(r.rental_id) AS cantidad
FROM rental AS r
GROUP BY EXTRACT('Month'
FROM r.rental_date)
ORDER BY EXTRACT('Month'
FROM r.rental_date)
;

/*26. Encuentra el promedio, la desviación estándar y varianza del total pagado*/
SELECT 
	round(avg(p.amount), 2) AS promedio, 
	round(variance(p.amount), 2) AS varianza, 
	round(stddev(p.amount), 2) AS desviacion_estandar
FROM payment AS p 

/*27. ¿Qué películas se alquilan por encima del precio medio?*/
-- Creo una CTE para encontrar el valor promedio
WITH promedio_precio AS (
	SELECT 
		p_tempo.amount AS precio
	FROM payment AS p_tempo
	)
SELECT 
	f.title AS titulo, 
	p.amount AS precio
FROM film AS f
JOIN inventory AS i 
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN payment AS p
ON r.rental_id = p.rental_id
WHERE p.amount > (SELECT avg(pp.precio)
FROM promedio_precio AS pp)
;

/*28. Muestra el id de los actores que hayan participado en más de 40 películas.*/
-- He creado una vista que me de la cantidad de peliculas, nombre e id de cada actor
SELECT 
	acp.nombre_completo, 
	acp.cantidad
FROM actor_cantidad_peliculas AS acp
WHERE acp.cantidad > 40
;

/*29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.*/
SELECT 
	f.title AS titulo, 
	count(f.film_id) AS cantidad_disponible
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
;

/*30. Obtener los actores y el número de películas en las que ha actuado.*/
-- Ya tenia la vista hecha y la he reutilizado
SELECT 
	acp.nombre_completo, 
	acp.cantidad
FROM actor_cantidad_peliculas AS acp
;

/*31  Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.*/
SELECT 
	f.title AS titulo, 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo
FROM film AS f
LEFT JOIN film_actor AS fa
ON f.film_id = fa.film_id
LEFT JOIN actor AS a
ON fa.actor_id = a.actor_id
ORDER BY f.title 
;

/*32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo, 
	f.title AS titulo
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id 
LEFT JOIN film AS f
ON f.film_id = fa.film_id 
; 

/*33. Obtener todas las películas que tenemos y todos los registros de alquiler.*/	
SELECT 
	f.title AS titulo, 
	r.rental_id AS registro_alquiler
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
WHERE r.inventory_id = i.inventory_id 
;

/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
SELECT 
	concat(c.first_name, ' ', c.last_name) AS nombre_cliente, 
	sum(p.amount) AS cantidad_total, 
	c.customer_id AS id_cliente
FROM customer AS c
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY cantidad_total DESC
LIMIT 5
;

/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo
FROM actor AS a
WHERE a.first_name = upper('Johnny')
;

/*36. Renombra la columna “first_name como Nombre y “last_name como Apellido.*/
/* Este script cambia el nombre como se pide, sin embargo he desecho el cambio
 * para que el resto de scripts sean funcionales ya que estan configurados con
 * los parametros "fist_name" y "last_name"*/
ALTER TABLE actor
RENAME COLUMN "first_name" TO Nombre
;

ALTER TABLE actor
RENAME COLUMN "last_name" TO Apellido
;

/*37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/
(SELECT 
	concat(a1.first_name, ' ', a1.last_name) AS nombre_completo, 
	a1.actor_id
	FROM actor AS a1
	ORDER BY a1.actor_id ASC
	LIMIT 1
	)
UNION ALL
(SELECT 
	concat(a2.first_name, ' ', a2.last_name) AS nombre_completo, 
	a2.actor_id
	FROM actor AS a2
	ORDER BY a2.actor_id DESC
	LIMIT 1
	)
;

/*38. Cuenta cuántos actores hay en la tabla “actor.*/
SELECT 
	count(a.actor_id) AS cantidad_actores
FROM actor AS a
;

/*39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.*/
SELECT 
	concat(a.first_name , ' ', a.last_name) AS nombre_completo
FROM actor AS a
ORDER BY a.last_name ASC
;

/*40. Selecciona las primeras 5 películas de la tabla “film.*/
SELECT 
	f.title AS titulo, 
	f.film_id AS id_pelicula
FROM film AS f
ORDER BY f.film_id ASC
LIMIT 5
;

/*41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?*/
-- Los nombres mas repetido son KENNETH, PENELOPE y JULIA. Aparecen 4 veces cada uno.
SELECT 
	a.first_name AS nombre, 
	count(a.actor_id) AS cantidad
FROM actor AS a
GROUP BY a.first_name
ORDER BY cantidad DESC
;

/*42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.*/
SELECT 
	concat(c.first_name, ' ', c.last_name) AS nombre_completo, 
	r.rental_id AS id_alquiler
FROM rental AS r
JOIN customer AS c
ON r.customer_id = r.customer_id 
;

/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/
SELECT 
	concat(c.first_name, ' ', c.last_name) AS nombre_completo, 
	r.rental_id AS id_alquiler
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id 

/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
SELECT 
	f.title AS titulo, 
	c."name" AS categoria
FROM film AS f
CROSS JOIN category AS c
;
-- No tiene sentido esta operacion ya que hay una tabla de union,
-- por tanto los resultados no aportan ningun tipo de valor ya que van a aparecer todas
-- las peliculas y todas las categorias. Era un resultado esperado ya que un CROSS JOIN
-- realiza un producto cartesiano de todo con todo.

/*45. Encuentra los actores que han participado en películas de la categoría
'Action'.*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo, 
	c."name" AS categoria
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film AS f
ON fa.film_id = f.film_id
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
WHERE c."name" = 'Action'
;

/*46. Encuentra todos los actores que no han participado en películas.*/
-- He cruzado mi vista de actores en peliculas con todos los actores 
-- y aparentemente todos los actores estan en al menos una pelicula
SELECT 
	aep.nombre_completo
FROM actores_en_peliculas AS aep
WHERE aep.actor_id NOT IN (
	SELECT a.actor_id
FROM actor AS a)
;

/*47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.*/
-- Se pide lo mismo que en el apartado 30
SELECT 
	acp.nombre_completo, acp.cantidad
FROM actor_cantidad_peliculas AS acp
;

/*48. Crea una vista llamada “actor_num_peliculas que muestre los nombres
de los actores y el número de películas en las que han participado.*/
-- Ya la tenía hecha, pero creo otra con el nombre que se pide
CREATE VIEW actor_num_peliculas AS (
	SELECT 
		concat(actor.first_name, ' ', actor.last_name) AS nombre_completo, 
		actor.actor_id AS id_actor, 
		count(film.film_id) AS cantidad
	FROM actor
	JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
	JOIN film
	ON film_actor.film_id = film.film_id
	GROUP BY actor.actor_id 
	)

/*49. Calcula el número total de alquileres realizados por cada cliente.*/
SELECT 
	concat(c.first_name, ' ', c.last_name) AS nombre_completo, 
	count(p.customer_id) AS cantidad
FROM customer AS c
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY p.customer_id , c.first_name, c.last_name 
;

/*50. Calcula el número total de alquileres realizados por cada cliente.*/
SELECT 
	sum(f.length) AS duracion_total
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON c.category_id = fc.category_id
WHERE c."name" = 'Action'

/*51. Crea una tabla temporal llamada “cliente_rentas_temporal para
almacenar el total de alquileres por cliente.*/
-- Es un codigo similar al del apartado 49 pero le he añadido el custormer_id por
-- que puede ser de utilidad si se tiene que usar
CREATE TEMPORARY TABLE cliente_rentas_temporal AS (
	SELECT 
		concat(c.first_name, ' ', c.last_name) AS nombre_completo, 
		count(p.customer_id) AS cantidad, p.customer_id
	FROM customer AS c
	JOIN payment AS p
	ON c.customer_id = p.customer_id
	GROUP BY p.customer_id , c.first_name, c.last_name 
	)

/*52. Crea una tabla temporal llamada “peliculas_alquiladas que almacene las
películas que han sido alquiladas al menos 10 veces.*/
CREATE TEMPORARY TABLE peliculas_alquiladas AS (
	SELECT 
		f.title AS titulo, 
		count(i.inventory_id) AS cantidad
	FROM rental AS r
	JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
	JOIN film AS f
	ON i.film_id = f.film_id
	GROUP BY f.title
	HAVING count(i.inventory_id) > 10 
	)

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/	
SELECT 
	f.title
FROM customer AS c
JOIN rental AS r
ON c.customer_id = r.customer_id
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film AS f
ON i.film_id = f.film_id
WHERE c.first_name = upper('Tammy')
AND c.last_name = upper('Sanders')
AND r.return_date IS NULL
ORDER BY f.title ASC
;

/*54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi. Ordena los resultados
alfabéticamente por apellido.*/
-- He reutilizado la vista de actores en peliculas peo he tenido que hacer
-- un split de nombre_completo
SELECT 
	aep.nombre_completo,
FROM actores_en_peliculas AS aep
JOIN film_category AS fc
ON aep.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
WHERE c."name" = 'Sci-Fi'
ORDER BY split_part(aep.nombre_completo, ' ', 2) 
;

/*55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/
CREATE TEMPORARY TABLE primera_spartacus_cheaper AS (
	SELECT f.title, r.rental_date AS fecha
	FROM film AS f
	JOIN inventory AS i
	ON f.film_id = i.film_id
	JOIN rental AS r
	ON i.inventory_id = r.inventory_id
	WHERE f.title = upper('Spartacus Cheaper')
	ORDER BY r.rental_date
	LIMIT 1
	);

SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo
FROM film AS f
JOIN film_actor AS fa
ON f.film_id = fa.film_id
JOIN actor AS a
ON fa.actor_id = a.actor_id
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN primera_spartacus_cheaper AS psc
ON r.rental_date > psc.rental_date
ORDER BY a.last_name ASC
;

/*56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music.*/
SELECT 
	concat(a.first_name, ' ', a.last_name) AS nombre_completo, 
	a.actor_id
FROM actor AS a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT a.actor_id
	FROM actor AS a
	JOIN film_actor AS fa 
	ON a.actor_id = fa.actor_id
	JOIN film AS f 
	ON fa.film_id = f.film_id
	JOIN film_category AS fc 
	ON f.film_id = fc.film_id
	JOIN category AS c 
	ON fc.category_id = c.category_id
	WHERE c.name = 'Music'
	)
;

/*57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.*/
SELECT 
	f.title AS titulo, 
	r.rental_date AS fecha_alquiler, 
	COALESCE(r.return_date, CURRENT_DATE) AS fecha_retrono,
	EXTRACT(DAY FROM COALESCE(r.return_date, CURRENT_DATE) - r.rental_date) AS rental_duration
FROM rental AS r
JOIN inventory AS i 
ON r.inventory_id = i.inventory_id
JOIN film AS f 
ON i.film_id = f.film_id
WHERE EXTRACT(DAY FROM COALESCE(r.return_date, CURRENT_DATE) - r.rental_date) > 8
ORDER BY rental_duration DESC
;

/*58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation.*/
SELECT 
	f.title AS titulo
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c."name" = 'Animation'
;

/*59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever. Ordena los resultados
alfabéticamente por título de película.*/
SELECT 
	f1.title AS titulo, 
	f1.length AS duracion
FROM film AS f1
WHERE f1.length = ( 
	SELECT f2.length
	FROM film AS f2
	WHERE f2.title = upper('Dancing Fever')
	)
;

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/
SELECT 
	c.customer_id AS id, 
	concat(c.first_name, ' ', c.last_name) AS nombre_completo, 
	count(DISTINCT i.film_id) AS cantidad	
FROM customer AS c
JOIN rental AS r
ON c.customer_id = r.customer_id
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING (count(DISTINCT i.film_id) >= 7)
ORDER BY c.last_name ASC
;

/*61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/
SELECT 
	c."name" AS categoria, 
	count(r.rental_id)
FROM rental AS r
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film AS f
ON i.film_id = f.film_id
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c."name" 
;

/*62. Encuentra el número de películas por categoría estrenadas en 2006.*/
-- Aparentemente todas son de 2006, he mirado la BBDD y asi es
SELECT 
	f.title,
	f.release_year
FROM film AS f
WHERE YEAR(f.release_year) = 2006
;

/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/
-- Solo hay dos tiendas y dos empleados, asi que sólo hay 4 combinaciones posibles
SELECT 
	concat(s.first_name, ' ', s.last_name) AS nombre_completo, 
	a.address AS direccion, 
	c.city AS ciudad, 
	c2.country AS pais
FROM store AS s2
JOIN address AS a
ON s2.address_id = a.address_id
JOIN city AS c
ON a.city_id = c.city_id
JOIN country AS c2
ON c.country_id = c2.country_id
CROSS JOIN staff AS s 
;

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/
SELECT 
	c.customer_id AS id, 
	concat(c.first_name, ' ', c.last_name) AS nombre_completo,
	count(DISTINCT i.film_id) AS cantidad
FROM customer AS c
JOIN rental AS r
ON c.customer_id = r.customer_id
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.last_name ASC