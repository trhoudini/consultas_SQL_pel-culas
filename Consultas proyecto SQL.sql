Consulta 1
/*
Crea el esquema de la BBDD.
 */
Esquema creado.

Consulta 2
/*
Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.
 */
select "title"
from "film"
where "rating" = 'R';

Consulta 3
/*
Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.
 */
select "first_name" , "last_name"
from "actor"
where "actor_id" between 30 and 40;

Consulta 4
/*
Obtén las películas cuyo idioma coincide con el idioma original.
 */
select "title"
from "film"
where "language_id" = "original_language_id";

Consulta 5
/*
Ordena las películas por duración de forma ascendente.
 */
select "title", "length" from "film"
order by "length" asc;

Consulta 6
/*
Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.
 */
select "first_name", "last_name" from "actor"
where "last_name" = 'ALLEN';

Consulta 7
/*
Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.
 */
select "rating", count(*) as "total_peliculas"
from "film"
group by "rating";

Consulta 8
/*
Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.
 */
select "title" from "film"
where "rating" = 'PG-13' or "length" > 180;

Consulta 9
/*
Encuentra la variabilidad de lo que costaría reemplazar las películas.
 */
select variance("replacement_cost") as "variabilidad_reemplazo"
from "film";

Consulta 10
/*
Encuentra la mayor y menor duración de una película de nuestra BBDD.
 */
select max("length") as "max_duracion", min("length") as "min_duracion"
from "film";

Consulta 11
/*
Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
 */
select "rental_id" as "numero_alquiler", "amount" as "alquiler"
from "payment"
order by "payment_date" desc
limit 1 offset 2;

Consulta 12
/*
Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación.
 */
select "title"
from "film"
where "rating" not in ('NC-17', 'G');

Consulta 13
/*
Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.
 */
select "rating", avg("length") as "promedio_duracion"
from "film"
group by "rating";

Consulta 14
/*
Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.
 */
select "title"
from "film"
where "length" > 180;

Consulta 15
/*
¿Cuánto dinero ha generado en total la empresa?
 */
select sum("amount") as "total_ingresos"
from "payment";

Consulta 16
/*
Muestra los 10 clientes con mayor valor de id.
 */
select "customer_id", "first_name", "last_name"
from "customer"
order by "customer_id" desc
limit 10;

Consulta 17
/*
Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.
 */
select "actor"."first_name" as "nombre", "actor"."last_name" as "apellido"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
join "film" on "film_actor"."film_id" = "film"."film_id"
where "film"."title" = 'EGG IGBY';

Consulta 18
/*
Selecciona todos los nombres de las películas únicos.
 */
select distinct "title"
from "film";

Consulta 19
/*
Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.
 */
select "film"."title"
from "film"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
where "category"."name" = 'Comedy' and "film"."length" > 180;

Datos tabla film
select *
from "film";

Consulta 20
/*
Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.
 */
select "category"."name" as "categorias_peliculas", avg("film"."length") as "promedio_duracion"
from "film"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
group by "category"."name"
having avg("film"."length") > 110;

Consulta 21
/*
¿Cuál es la media de duración del alquiler de las películas?
 */
select avg("rental_duration") as "media_duracion"
from "film";

Consulta 22
/*
Crea una columna con el nombre y apellidos de todos los actores y
actrices.
 */
select "first_name" || ' ' || "last_name" as "nombre_completo"
from "actor";

Datos tabla actor
select *
from "actor";

Consulta 23
/*
Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.
 */
select date("rental_date") as "fecha", count(*) as "cantidad_alquileres"
from "rental"
group by date("rental_date")
order by "cantidad_alquileres" desc;

Consulta 24
/*
Encuentra las películas con una duración superior al promedio.
 */
select "title", "length"
from "film"
where "length" > (select avg("length") from "film")
order by "length" desc;

Consulta 25
/*
Averigua el número de alquileres registrados por mes.
 */
select extract(month from "rental_date") as "mes", count(*) as "cantidad_alquileres"
from "rental"
group by extract(month from "rental_date")
order by "mes";

Consulta 26
/*
Encuentra el promedio, la desviación estándar y varianza del total
pagado.
 */
select 
    avg("amount") as "promedio",
    stddev("amount") as "desviacion_estandar",
    variance("amount") as "varianza"
from "payment";

Consulta 27
/*
¿Qué películas se alquilan por encima del precio medio?
 */
select "film"."title", "film"."rental_rate"
from "film"
where "film"."rental_rate" > (select avg("rental_rate") from "film")
order by "film"."rental_rate" desc;

Consulta 28
/*
Muestra el id de los actores que hayan participado en más de 40
películas.
 */
select "actor_id", count("film_id") as "num_peliculas"
from "film_actor"
group by "actor_id"
having count("film_id") > 40;

Consulta 29
/*
Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.
 */
select "film"."title", count("inventory"."inventory_id") as "disponible"
from "film"
left join "inventory" on "film"."film_id" = "inventory"."film_id"
group by "film"."title";

Consulta 30
/*
Obtener los actores y el número de películas en las que ha actuado.
 */
select "actor"."first_name", "actor"."last_name", count("film_actor"."film_id") as "num_peliculas"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
group by "actor"."first_name", "actor"."last_name"
order by "num_peliculas" desc;

Consulta 31
/*
Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.
 */
select "film"."title", "actor"."first_name", "actor"."last_name"
from "film"
left join "film_actor" on "film"."film_id" = "film_actor"."film_id"
left join "actor" on "film_actor"."actor_id" = "actor"."actor_id"
order by "film"."title";

Consulta 32
/*
Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.
 */
select "actor"."first_name", "actor"."last_name", "film"."title"
from "actor"
left join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
left join "film" on "film_actor"."film_id" = "film"."film_id"
order by "actor"."last_name", "actor"."first_name";

Consulta 33
/*
Obtener todas las películas que tenemos y todos los registros de
alquiler.
 */
select "film"."title", "rental"."rental_id"
from "film"
cross join "rental";

Consulta 34
/*
Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
 */
select "customer"."first_name", "customer"."last_name", sum("payment"."amount") as "total_gastado"
from "customer"
join "payment" on "customer"."customer_id" = "payment"."customer_id"
group by "customer"."first_name", "customer"."last_name"
order by "total_gastado" desc
limit 5;

Consulta 35
/*
Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 */
select "actor"."first_name", "actor"."last_name"
from "actor"
where "actor"."first_name" = 'JOHNNY';

Consulta 36
/*
Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.
 */
select "first_name" as "nombre", "last_name" as "apellido"
from "actor";

Consulta 37
/*
Encuentra el ID del actor más bajo y más alto en la tabla actor.
 */
select min("actor_id") as "id_actor_más_bajo", max("actor_id") as "id_actor_más_alto"
from "actor";

Consulta 38
/*
Cuenta cuántos actores hay en la tabla “actor”.
 */
select count(*) as "total_actores"
from "actor";

Consulta 39
/*
Selecciona todos los actores y ordénalos por apellido en orden
ascendente.
 */
select "first_name", "last_name"
from "actor"
order by "last_name" asc;

Consulta 40
/*
Selecciona las primeras 5 películas de la tabla “film”.
 */
select "film_id", "title"
from "film"
order by "film_id"
limit 5;

Consulta 41
/*
Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?
 */
select "first_name", count(*) as "cantidad_actores"
from "actor"
group by "first_name"
order by "cantidad_actores" desc;

Consulta 42
/*
Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.
 */
select "rental"."rental_id", "customer"."first_name", "customer"."last_name"
from "rental"
join "customer" on "rental"."customer_id" = "customer"."customer_id";

Consulta 43
/*
Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.
 */
select 
    "customer"."customer_id", 
    "customer"."first_name", 
    "customer"."last_name", 
    count("rental"."rental_id") as "total_alquileres"
from "customer"
left join "rental" on "customer"."customer_id" = "rental"."customer_id"
group by "customer"."customer_id", "customer"."first_name", "customer"."last_name"
order by "total_alquileres" desc;

Consulta 44
/*
Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.
 */
select "film"."title", "category"."name"
from "film"
cross join "category";

Consulta 45
/*
Encuentra los actores que han participado en películas de la categoría
'Action'.
 */
select distinct "actor"."first_name", "actor"."last_name"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
join "film" on "film_actor"."film_id" = "film"."film_id"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
where "category"."name" = 'Action';

Consulta 46
/*
Encuentra todos los actores que no han participado en películas.
 */
select "actor"."first_name", "actor"."last_name"
from "actor"
right join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
where "film_actor"."film_id" is null;

Para verificar la consulta 46
select count(*)
from "actor"
left join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
where "film_actor"."film_id" is null;

Consulta 47
/*
Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.
 */
select "actor"."first_name", "actor"."last_name", count("film_actor"."film_id") as "cantidad_peliculas"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
group by "actor"."actor_id", "actor"."first_name", "actor"."last_name"
order by "cantidad_peliculas" desc;

Consulta 48
/*
Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.
 */
create view "actor_num_peliculas" as
select "actor"."first_name", "actor"."last_name", count("film_actor"."film_id") as "cantidad_peliculas"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
group by "actor"."actor_id", "actor"."first_name", "actor"."last_name";

Consulta 49
/*
Calcula el número total de alquileres realizados por cada cliente.
 */
select "customer"."customer_id", "customer"."first_name", "customer"."last_name", count("rental"."rental_id") as "total_alquileres"
from "customer"
join "rental" on "customer"."customer_id" = "rental"."customer_id"
group by "customer"."customer_id", "customer"."first_name", "customer"."last_name"
order by "total_alquileres" desc;

Consulta 50
/*
Calcula la duración total de las películas en la categoría 'Action'.
 */
select sum("film"."length") as "duracion_total"
from "film"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
where "category"."name" = 'Action';

Consulta 51
/*
Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.
 */
create temp table "cliente_rentas_temporal" as
select "customer"."customer_id", "customer"."first_name", "customer"."last_name", count("rental"."rental_id") as "total_alquileres"
from "customer"
join "rental" on "customer"."customer_id" = "rental"."customer_id"
group by "customer"."customer_id", "customer"."first_name", "customer"."last_name";

Consulta 52
/*
Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.
 */
create temp table "peliculas_alquiladas" as
select "film"."film_id", "film"."title", count("rental"."rental_id") as "total_alquileres"
from "film"
join "inventory" on "film"."film_id" = "inventory"."film_id"
join "rental" on "inventory"."inventory_id" = "rental"."inventory_id"
group by "film"."film_id", "film"."title"
having count("rental"."rental_id") >= 10;

Consulta 53
/*
Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.
 */
select distinct "film"."title"
from "film"
join "inventory" on "film"."film_id" = "inventory"."film_id"
join "rental" on "inventory"."inventory_id" = "rental"."inventory_id"
join "customer" on "rental"."customer_id" = "customer"."customer_id"
where "customer"."first_name" = 'TAMMY' and "customer"."last_name" = 'SANDERS'
and "rental"."return_date" is null
order by "film"."title" asc;

Consulta 54
/*
Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.
 */
select distinct "actor"."first_name", "actor"."last_name"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
join "film" on "film_actor"."film_id" = "film"."film_id"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
where "category"."name" = 'Sci-Fi'
order by "actor"."last_name" asc;

Consulta 55
/*
Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.
 */
select distinct "actor"."first_name", "actor"."last_name"
from "actor"
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
join "film" on "film_actor"."film_id" = "film"."film_id"
join "inventory" on "film"."film_id" = "inventory"."film_id"
join "rental" on "inventory"."inventory_id" = "rental"."inventory_id"
where "rental"."rental_date" > (
    select min("rental"."rental_date")
    from "rental"
    join "inventory" on "rental"."inventory_id" = "inventory"."inventory_id"
    join "film" on "inventory"."film_id" = "film"."film_id"
    where "film"."title" = 'SPARTACUS CHEAPER'
)
order by "actor"."last_name" asc;

Consulta 56
/*
Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.
 */
select distinct "actor"."first_name", "actor"."last_name"
from "actor"
where "actor_id" not in (
    select distinct "actor"."actor_id"
    from "actor"
    join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
    join "film_category" on "film_actor"."film_id" = "film_category"."film_id"
    join "category" on "film_category"."category_id" = "category"."category_id"
    where "category"."name" = 'Music'
)
order by "actor"."last_name";

Consulta 57
/*
Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.
 */
select distinct "film"."title"
from "rental"
join "inventory" on "rental"."inventory_id" = "inventory"."inventory_id"
join "film" on "inventory"."film_id" = "film"."film_id"
where "rental"."return_date" - "rental"."rental_date" > interval '8 days';

Consulta 58
/*
Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.
 */
select distinct "film"."title"
from "film"
join "film_category" on "film"."film_id" = "film_category"."film_id"
where "film_category"."category_id" = (
    select "category_id" from "category" where "name" = 'Animation'
);

Consulta 59
/*
Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.
 */
select "title"
from "film"
where "length" = (
    select "length" from "film" where "title" = 'DANCING FEVER'
)
order by "title";

Consulta 60
/*
Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.
 */
select "customer"."first_name", "customer"."last_name"
from "customer"
join "rental" on "customer"."customer_id" = "rental"."customer_id"
join "inventory" on "rental"."inventory_id" = "inventory"."inventory_id"
join "film" on "inventory"."film_id" = "film"."film_id"
group by "customer"."customer_id", "customer"."first_name", "customer"."last_name"
having count(distinct "film"."film_id") >= 7
order by "customer"."last_name";

Consulta 61
/*
Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.
 */
select "category"."name", count("rental"."rental_id") as recuento_alquileres
from "rental"
join "inventory" on "rental"."inventory_id" = "inventory"."inventory_id"
join "film" on "inventory"."film_id" = "film"."film_id"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
group by "category"."name"
order by recuento_alquileres desc;

Consulta 62
/*
Encuentra el número de películas por categoría estrenadas en 2006.
 */
select "category"."name" as categorias, count("film"."film_id") as total_peliculas
from "film"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
where "film"."release_year" = 2006
group by "category"."name"
order by total_peliculas desc;

Consulta 63
/*
Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.
 */
select "staff"."first_name" as nombre_trabajador, "staff"."last_name" as apellido_trabajador, "store"."store_id" as tiendas
from "staff"
cross join "store";

Consulta 64
/*
Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.
 */
select "customer"."customer_id" as id_cliente, "customer"."first_name" as nombre_cliente, "customer"."last_name" as apellido_cliente, count("rental"."rental_id") as peliculas_alquiladas
from "customer"
left join "rental" on "customer"."customer_id" = "rental"."customer_id"
group by "customer"."customer_id", "customer"."first_name", "customer"."last_name"
order by peliculas_alquiladas desc;


















