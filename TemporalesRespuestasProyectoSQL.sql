create temporary table cliente_rentas_temporal as (
	select
		concat(c.first_name, ' ', c.last_name) as nombre_completo,
		count(p.customer_id) as cantidad,
		p.customer_id
	from customer as c
	join payment as p
	on c.customer_id = p.customer_id 
	group by p.customer_id , c.first_name, c.last_name 
	)
	
create temporary table peliculas_alquiladas as (
	select 
		f.title as titulo,
		count(i.inventory_id) as cantidad
	from rental as r
	join inventory as i
	on r.inventory_id = i.inventory_id 
	join film as f
	on i.film_id = f.film_id
	group by f.title 
	having count(i.inventory_id) > 10 
	)
	
create temporary table peliculas_alquilada_tiempo as (
	select
		f.title,
		r.rental_date 
	from rental as r
	join inventory i 
	on r.rental_id = i.inventory_id 
	join film as f 
	on i.film_id = f.film_id
	order by r.rental_date asc
	)
