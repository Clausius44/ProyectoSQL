CREATE TEMPORARY TABLE cliente_rentas_temporal AS (
	SELECT 
		concat(c.first_name, ' ', c.last_name) AS nombre_completo, 
		count(p.customer_id) AS cantidad, 
		p.customer_id
	FROM customer AS c
	JOIN payment AS p
	ON c.customer_id = p.customer_id
	GROUP BY p.customer_id , c.first_name, c.last_name 
	)
	
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
	
CREATE TEMPORARY TABLE peliculas_alquilada_tiempo AS (
	SELECT 
		f.title, r.rental_date
	FROM rental AS r
	JOIN inventory i 
	ON r.rental_id = i.inventory_id
	JOIN film AS f 
	ON i.film_id = f.film_id
	ORDER BY r.rental_date ASC
	)
