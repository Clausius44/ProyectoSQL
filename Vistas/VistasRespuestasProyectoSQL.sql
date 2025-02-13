CREATE VIEW actor_cantidad_peliculas AS (
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

CREATE VIEW actores_en_peliculas AS (
	SELECT 
		f.title AS titulo, 
		concat(a.first_name, ' ', a.last_name) AS nombre_completo, 
		f.film_id, 
		a.actor_id
	FROM film AS f
	JOIN film_actor AS fa
	ON f.film_id = fa.film_id
	JOIN actor AS a
	ON fa.actor_id = a.actor_id
	GROUP BY f.film_id , a.actor_id
	ORDER BY f.title ASC
	)

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
