/*DataProject: Lógica Consultas SQL
 * 
 *  2. Muestra los nombres de todas las películas con una clasificación por
edades de 'R'. */
select 
	f.title as titulo 
from film as f
where f.rating = 'R'
;

/*3. Encuentra los nombres de los actores que tengan un “actor_id entre 30
y 40.*/
select 
	concat(a.first_name, ' ', a.last_name) as nombre_completo,
	a.actor_id as id_actor
from actor as a
where a.actor_id between 30 and 40
;

/*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
select 
	f.title as titulo
from film as f 
where f.language_id = f.original_language_id
;

/*5. Ordena las películas por duración de forma ascendente.*/
select
	f.title as titulo,
	f.length as duracion 
from film as f
order by f.length asc

/*6. Encuentra el nombre y apellido de los actores que tengan ‘Allen en su apellido*/
-- Ya que la BBDD tiene los nombres en mayusculas he usado 'Allen' pero lo he adaptado la BBDD
select 
	concat(a.first_name, ' ', a.last_name) as nombre_completo 
from actor as a
where a.last_name = Upper('Allen')
;

/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla "film" y muestra la clasificación junto con el recuento.*/
select
	f.rating as clasificacion,
	count(f.title) as cantidad
from film as f
group by f.rating 
;

/*8. Encuentra el título de todas las películas que son ‘PG13 o tienen una duración mayor a 3 horas en la tabla film.*/
select 
	f.title as titulo,
	f.length as duracion
from film as f
where f.rating = 'PG-13' and f.length > 180
;

/*9. cuentra la variabilidad de lo que costaría reemplazar las películas.*/
select
	variance(f.replacement_cost) as varianza
from film as f
;

/*10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/
-- He pensado que hacer dos querys limitadas y unirlas era mas entendible
(select 	
	f1.title as titulo,
	f1.length as duracion
from film as f1
order by f1.length asc 
limit 1)
union all
(select
	f2.title as titulo,
	f2.length as duracion
from film as f2
order by f2.length desc
limit 1)
;

/*11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/
select
	p.amount as coste,
	p.payment_date as fecha
from payment as p
order by p.payment_date desc
limit 1
offset 2
;

/*12. Encuentra el título de las películas en la tabla “film que no sean ni ‘NC17 ni ‘G en cuanto a su clasificación.*/
select 
	f.title as titulo,
	f.rating as clasificacion
from film as f
where f.rating not in ('NC-17', 'G')
;

/*13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.*/
select
	f.rating as clasificación, 
	concat(round(avg(f.length),2), ' minutos') as duración_promedio
from film as f
group by f.rating
;

/*14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos*/
select
	f.title as titulo_pelicula,
	f.length as duración
from film as f 
where f.length > 180
;

/*15. Cuánto dinero ha generado en total la empresa?*/
select 
	round(sum(p.amount), 2) as total_generado
from payment as p
;

/*16. Muestra los 10 clientes con mayor valor de id.*/
select 
	concat(c.first_name, ' ', c.last_name) as nombre_completo,
	c.customer_id as id_cliente 
from customer as c
order by c.customer_id desc 
limit 10
;

/*17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby*/
select
	concat(a.first_name, ' ', a.last_name) as nombre_completo 
from film as f
join film_actor as fa
on f.film_id = fa.film_id 
join actor as a
on fa.actor_id = a.actor_id 
where f.title = upper('Egg Igby')
;

/*18. Selecciona todos los nombres de las películas únicos.*/
select
	distinct f.title as titulo
from film as f
;

/*19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film.*/
select
	f.title as titulo,
	c."name" as categoria,
	f.length as duracion
from film as f
join film_category as fc
on f.film_id = fc.film_id 
join category as c
on fc.category_id = c.category_id
where c."name" = 'Comedy' and f.length > 180
;

/*20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/
-- He creado una CTE que solo calcula el promedio de duracion por categoría, de otra forma era muy liado
with duracion_categoria as(
	select
		c."name" as nombre_categoria,
		round(avg(f.length),2) as duracion
	from film as f 
	join film_category as fc
	on fc.film_id = f.film_id 
	join category as c
	on fc.category_id = c.category_id
	group by c."name"
	)
select
	dc.nombre_categoria,
	duracion as duracion
from duracion_categoria as dc
where dc.duracion > 110
;

/*21 ¿Cuál es la media de duración del alquiler de las películas?*/
select
	round(avg(f.rental_duration), 2) as promedio_alquiler
from film as f
;

/*22. ¿Cuál es la media de duración del alquiler de las películas?*/
select 
	concat(a.first_name, ' ', a.last_name) as nombre_completo 
from actor as a 
;

/*23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente*/
select
	date(r.rental_date) as fecha,
	count(r.rental_id) as cantidad
from rental as r
group by date(r.rental_date) 
order by date(r.rental_date) desc
;

/*24. Encuentra las películas con una duración superior al promedio.*/
select
	f.title as titulo,
	f.length as duracion
from film as f
where f.length > (select
	avg(f2.length)
	from film as f2)
;

/*25. Averigua el número de alquileres registrados por mes.*/
select
	extract('Month' from r.rental_date) as mes,
	count(r.rental_id) as cantidad
from rental as r
group by extract('Month' from r.rental_date)
order by extract('Month' from r.rental_date)
;

/*26. Encuentra el promedio, la desviación estándar y varianza del total pagado*/
select 
	round(avg(p.amount), 2) as promedio,
	round(variance(p.amount), 2) as varianza,
	round(stddev(p.amount), 2) as desviacion_estandar 
from payment as p 

/*27. ¿Qué películas se alquilan por encima del precio medio?*/
-- Creo una CTE para encontrar el valor promedio
with promedio_precio as (
	select
		p_tempo.amount as precio
	from payment as p_tempo
	)
select
	f.title as titulo,
	p.amount as precio 
from film as f
join inventory as i 
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id 
join payment as p
on r.rental_id = p.rental_id
where p.amount > (select
		avg(pp.precio)
	from promedio_precio as pp)
;

/*28. Muestra el id de los actores que hayan participado en más de 40 películas.*/
-- He creado una vista que me de la cantidad de peliculas, nombre e id de cada actor
select
	acp.nombre_completo,
	acp.cantidad 
from actor_cantidad_peliculas as acp
where acp.cantidad > 40
;
	
/*29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.*/
select
	f.title as titulo, 
	count(f.film_id) as cantidad_en_inventario
from film as f
inner join inventory as i
on f.film_id = i.film_id
group by f.film_id 
;

/*30. Obtener los actores y el número de películas en las que ha actuado.*/
-- Ya tenia la vista hecha y la he reutilizado
select 
	acp.nombre_completo,
	acp.cantidad 
from actor_cantidad_peliculas as acp
;

/*31  Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.*/
select 
	f.title as titulo,
	concat(a.first_name, ' ', a.last_name) as nombre_completo
from film as f
left join film_actor as fa
on f.film_id = fa.film_id 
left join actor as a
on fa.actor_id = a.actor_id
order by f.title 
;

/*32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.*/
select 
	concat(a.first_name, ' ', a.last_name) as nombre_completo,
	f.title as titulo
from actor as a
left join film_actor as fa
on a.actor_id = fa.actor_id 
left join film as f
on fa.film_id = f.film_id 
order by a.last_name 

/*33. Obtener todas las películas que tenemos y todos los registros de alquiler.*/	
select 
	f.title as titulo,
	r.rental_id as registro_alquiler
from film as f
join inventory as i
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id 
where r.inventory_id = i.inventory_id 
;

/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
select
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	sum(p.amount) as cantidad_total,
	c.customer_id as id_cliente
from customer as c
join payment as p
on c.customer_id = p.customer_id 
group by c.customer_id 
order by cantidad_total desc
limit 5
;

/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
select 
	concat(a.first_name, ' ', a.last_name) as nombre_completo 
from actor as a
where a.first_name = upper('Johnny')
;

/*36. Renombra la columna “first_name como Nombre y “last_name como Apellido.*/
/* Este script cambia el nombre como se pide, sin embargo he desecho el cambio
 * para que el resto de scripts sean funcionales ya que estan configurados con
 * los parametros "fist_name" y "last_name"*/
alter table actor
rename column "first_name" to Nombre
;
alter table actor
rename column "last_name" to Apellido
;

/*37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/
(select
	concat(a1.first_name, ' ', a1.last_name) as nombre_completo,
	a1.actor_id 
from actor as a1
order by a1.actor_id asc
limit 1)
union all
(select
	concat(a2.first_name, ' ', a2.last_name) as nombre_completo,
	a2.actor_id
from actor as a2
order by a2.actor_id desc
limit 1)
;

/*38. Cuenta cuántos actores hay en la tabla “actor.*/
select
	count(a.actor_id) as cantidad_actores 
from actor as a
;

/*39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.*/
select 
	concat(a.first_name , ' ', a.last_name) as nombre_completo 
from actor as a
order by a.last_name asc
;

/*40. Selecciona las primeras 5 películas de la tabla “film.*/
select 
	f.title as titulo,
	f.film_id as id_pelicula
from film as f 
order by f.film_id asc
limit 5
;

/*41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?*/
select
	a.first_name as nombre,
	count(a.actor_id) as cantidad
from actor as a
group by a.first_name
order by cantidad desc
;

/*42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.*/
select 
	concat(c.first_name, ' ', c.last_name) as nombre_completo,
	r.rental_id as id_alquiler
from rental as r
join customer as c
on r.customer_id = r.customer_id 
;

/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/
select 
	concat(c.first_name, ' ', c.last_name) as nombre_completo,
	r.rental_id as id_alquiler
from customer as c
cross join rental as r

/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
select
	f.title as titulo,
	c."name" as categoria
from film as f
cross join category as c
;
-- No tiene sentido esta operacion ya que hay una tabla de union,
-- por tanto los resultados no aportan ningun tipo de valor ya que van a aparecer todas
-- las peliculas y todas las categorias. Era un resultado esperado ya que un CROSS JOIN
-- realiza un producto cartesiano de todo con todo.

/*45. Encuentra los actores que han participado en películas de la categoría
'Action'.*/
select 
	concat(a.first_name, ' ', a.last_name) as nombre_completo,
	c."name" as categoria
from actor as a
join film_actor as fa
on a.actor_id = fa.actor_id 
join film as f
on fa.film_id = f.film_id 
join film_category as fc
on f.film_id = fc.film_id 
join category as c
on fc.category_id = c.category_id
where c."name" = 'Action'
;

/*46. Encuentra todos los actores que no han participado en películas.*/
-- He cruzado mi vista de actores en peliculas con todos los actores 
-- y aparentemente todos los actores estan en almenos una pelicula
select
	aep.nombre_completo 
from actores_en_peliculas as aep
where aep.actor_id not in (
	select
		a.actor_id
	from actor as a)
;

/*47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.*/
-- Se pide lo mismo que en el apartado 30
select 
	acp.nombre_completo,
	acp.cantidad 
from actor_cantidad_peliculas as acp
;

/*48. Crea una vista llamada “actor_num_peliculas que muestre los nombres
de los actores y el número de películas en las que han participado.*/
-- Ya la tenía hecha, pero creo otra con el nombre que se pide
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

/*49. Calcula el número total de alquileres realizados por cada cliente.*/
select
	concat(c.first_name, ' ', c.last_name) as nombre_completo,
	count(p.customer_id) as cantidad
from customer as c
join payment as p
on c.customer_id = p.customer_id 
group by p.customer_id , c.first_name, c.last_name 
;
	
/*50. Calcula el número total de alquileres realizados por cada cliente.*/
select 
	sum(f.length) as duracion_total
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on c.category_id = fc.category_id
where c."name" = 'Action'

/*51. Crea una tabla temporal llamada “cliente_rentas_temporal para
almacenar el total de alquileres por cliente.*/
-- Es un codigo similar al del apartado 49 pero le he añadido el custormer_id por
-- que puede ser de utilidad si se tiene que usar
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

/*52. Crea una tabla temporal llamada “peliculas_alquiladas que almacene las
películas que han sido alquiladas al menos 10 veces.*/
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

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/	
select 
	f.title
from customer as c
join rental as r
on c.customer_id = r.customer_id
join inventory as i
on r.inventory_id = i.inventory_id 
join film as f
on i.film_id = f.film_id 
where c.first_name = upper('Tammy') and c.last_name = upper('Sanders') and r.return_date is null
order by f.title asc
;

/*54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi. Ordena los resultados
alfabéticamente por apellido.*/
-- He reutilizado la vista de actores en peliculas peo he tenido que hacer
-- un split de nombre_completo
select
	aep.nombre_completo,
from actores_en_peliculas as aep
join film_category as fc
on aep.film_id = fc.film_id 
join category as c
on fc.category_id = c.category_id 
where c."name" = 'Sci-Fi'
order by split_part(aep.nombre_completo, ' ', 2) 
;

/*55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/
create temporary table primera_spartacus_cheaper as (
	select
		f.title,
		r.rental_date as fecha 
	from film as f
	join inventory as i
	on f.film_id = i.film_id 
	join rental as r
	on i.inventory_id = r.inventory_id 
	where f.title = upper('Spartacus Cheaper')
	order by r.rental_date
	limit 1
	);
select
	concat(a.first_name, ' ', a.last_name) as nombre_completo 
from film as f
join film_actor as fa
on f.film_id = fa.film_id 
join actor as a
on fa.actor_id = a.actor_id 
join inventory as i
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id
join primera_spartacus_cheaper as psc
on r.rental_date > psc.rental_date
order by a.last_name asc
;

/*56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music.*/
select  
	concat(a.first_name, ' ', a.last_name) as nombre_completo,
	a.actor_id
from actor as  a
where a.actor_id not in (
    select distinct a.actor_id
    from actor as a
    join film_actor as fa 
    on a.actor_id = fa.actor_id
    join film as f 
    on fa.film_id = f.film_id
    join film_category as fc 
    on f.film_id = fc.film_id
    join category as c 
    on fc.category_id = c.category_id
    where c.name = 'Music'
	)
;


/*57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.*/
select 
	f.title as titulo,
	r.rental_date as fecha1,
	r.return_date fecha_final,
	(r.return_date - r.rental_date) as tiempo,
	r.rental_id 
from rental as r
join inventory as i
on r.inventory_id = r.inventory_id 
join film as f
on i.film_id = f.film_id 
group by r.rental_id, f.title 
having r.return_date is not null
order by tiempo desc
;

/*58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation.*/
select 
	f.title as titulo
from film as f
join film_category as fc
on f.film_id = fc.film_id 
join category as c 
on fc.category_id = c.category_id 
where c."name" = 'Animation'
;

/*59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever. Ordena los resultados
alfabéticamente por título de película.*/
select 
	f1.title as titulo,
	f1.length as duracion
from film as f1
where f1.length = ( 
	select
		f2.length
	from film as f2
	where f2.title = upper('Dancing Fever')
	)
;

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/
select
	c.customer_id as id,
	concat(c.first_name, ' ', c.last_name) as nombre_completo,
	count(distinct i.film_id) as cantidad
from customer as c
join rental as r
on c.customer_id = r.customer_id 
join inventory as i
on r.inventory_id = i.inventory_id 
group by c.customer_id, c.first_name, c.last_name 
having (count(distinct i.film_id) >= 7)
order by c.last_name asc
;

/*61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/
select 
	c."name" as categoria,
	count(r.rental_id)
from rental as r
join inventory as i
on r.inventory_id = i.inventory_id 
join film as f
on i.film_id = f.film_id 
join film_category as fc
on f.film_id = fc.film_id 
join category as c
on fc.category_id = c.category_id 
group by c."name" 
;

/*62. Encuentra el número de películas por categoría estrenadas en 2006.*/
-- Aparentemente todas son de 2006, he mirado la BBDD y asi es
select
	f.title,
	f.release_year 
from film as f
where year(f.release_year) = 2006
;

/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/
-- Solo hay dos tiendas y dos empleados, asi que sólo hay 4 combinaciones posibles
select
	concat(s.first_name, ' ', s.last_name) as nombre_completo,
	a.address as direccion, 
	c.city as ciudad,
	c2.country as pais
from store as s2 
join address as a
on s2.address_id = a.address_id 
join city as c
on a.city_id = c.city_id
join country as c2
on c.country_id = c2.country_id 
cross join staff as s 
;

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/
select
	c.customer_id as id,
	concat(c.first_name, ' ', c.last_name) as nombre_completo,
	count(distinct i.film_id) as cantidad
from customer as c
join rental as r
on c.customer_id = r.customer_id 
join inventory as i
on r.inventory_id = i.inventory_id 
group by c.customer_id, c.first_name, c.last_name 
order by c.last_name asc