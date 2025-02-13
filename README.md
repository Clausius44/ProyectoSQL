# ProyectoSQL
Ejercicios de SQL del programa de Data Science de ThePower

Presentación:

Este repositorio de github contiene mi trabajo realizado en el temario de SQL del programa de Data Dciende the ThePower MBA.
Hay tres archivos con format .sql:
 - El archivo que se llama "RespuestasProyectoSQL.sql" dentro de la carpeta Respuestas contiene las querys utilizadas para responder a todos los ejercicios propuestos. Todos ellos tienen su enunciado al principio con el formato de comentario " /**/ ". En aquellos ejercicios que he considerado añadir algo lo he añadido con comentarios en formato " -- " para diferenciarlos. Tambien se han utilizado vistas y tablas temporales de SQL que, en cada caso, se especifica y justifica su uso. Tambien se han usado CTE's cuando se ha creido necesario.
 - El archivo que se llama "TemporalRespuestasProyectoSQL.sql" dentro de la carpeta TablasTemporales contiene las querys para generar las tablas temporales que se han usado para resolver los ejercicios. Dichas tablas se mencionan en el archivo de respuestas principal con comentarios en formato " -- ".
 - El archivo "VistasRespuestasProyectoSQL.sql" dentro de la carpeta Vistas contiene las querys para generar las vistas que se han usado para resolvers los ejercicios.

Tambien se incluye el archivo .pdf con los ejercicios originales (EnunciadoDataProject_SQL.Lógica.pdf) y un esquema de la base de datos (BBDD) (EsquemaProyectosSQL.jpg) tal y como se pide para poder seguir mejor la resolución de los ejercicios.

Informe:

La base de datos recoje información de tres ambitos distintos. Por un lado tenemos toda la información de las películas incluyendo duración, categoria, actores, año de estrana etc. Esta parte de la base de datos se enlaza con las peliculas alquiladas mediante el inventario de la cadena de alquiler de películas. Cada película tiene asociado un identificador único que se relaciona con su identificador en el inventario y, des de allí, hasta lo alquileres. En la segunda parte de la BBDD tenemos el registro de alquileres de películas. En esta parte relacionamos películas, clientes, tiempos de alquiler (salida y entrada) y el importe que ha gastado cada cliente. Por último, tenemos la parte de gestión de las tiendas, donde tenemos tablas con información de trabajadores y direcciones de clientes, trabajadores y tiendas.
La BBDD esta organizada con algunas tablas intermedias que optimizan la gestión de la memoria. Por ejemplo, en vez de reservar una cantidad de caracteres para cada genero o para cada categoria de película, guardamos un identificador y, mediante una tabla intermedia, accedemos al significado de ese identificador. Lo mismo ocurre con la direcciones físicas de empleados, clientes y establecimientos.
Algo que se ha usado mucho para resolver los ejercicios son las expresiones comunes de tabla (CTE). En algunos apartados se pedian busquedas dentro de busquedas y usar busquedas intermedias generadas in situ resulta muy efectivo.
Tambien se han creado varias vistas para agilizar algunas busquedas recurrentes como por ejemplo relacionas actores con la cantidad de películas en las que han actuado.
