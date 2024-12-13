create view actor_cantidad_peliculas as (
	select
		concat(actor.first_name, ' ', actor.last_name) as nombre_completo,
		actor.actor_id as id_actor,
		count(film.film_id) as cantidad 
	from actor
	join film_actor
	on actor.actor_id = film_actor.actor_id
	join film
	on film_actor.film_id = film.film_id
	group by actor.actor_id 
	)

create view actores_en_peliculas as (
	select 
		f.title as titulo,
		concat(a.first_name, ' ', a.last_name) as nombre_completo,
		f.film_id,
		a.actor_id 
	from film as f
	join film_actor as fa
	on f.film_id = fa.film_id 
	join actor as a
	on fa.actor_id = a.actor_id
	group by f.film_id , a.actor_id
	order by f.title asc
	)

create view actor_num_peliculas as (
	select
		concat(actor.first_name, ' ', actor.last_name) as nombre_completo,
		actor.actor_id as id_actor,
		count(film.film_id) as cantidad 
	from actor
	join film_actor
	on actor.actor_id = film_actor.actor_id
	join film
	on film_actor.film_id = film.film_id
	group by actor.actor_id 
	)
	
