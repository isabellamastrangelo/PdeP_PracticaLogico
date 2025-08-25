1) Contestar de qué tipo son las siguientes consultas (relación entre variables):

a. zona(2500, Zona) 
    individual, mixta

b.  favorita_del_publico(Especie)
    existencial, generadora

c. nivel_de_novedad(a1, Nivel)
    individual, mixta

d. descenso_mas_rapido(Hora1, Hora2, Velocidad)
    existencial, generadora
    
Indicar si son generadoras, verificadoras o mixtas, y justificar.

2) Se quiere agregar una nueva medida para evaluar los descubrimientos: nivel de rareza.

Este se calcula de la siguiente manera:

Se suman 2 puntos por cada característica distinta del descubrimiento.

Si la especie fue descubierta en la zona hadal, el valor se multiplica por 2.

Si además fue recolectado, se le suman 5 puntos adicionales.

a) Implementar el predicado nivel_de_rareza/2 que relacione un descubrimiento con su nivel de rareza.
b) Explicar en qué se diferencia el criterio de rareza del de novedad en términos de expresividad y declaratividad.

3) Un nuevo jurado quiere premiar la popularidad relativa de cada especie.

El criterio de aprobación es que el número de vistas en la hora en que fue descubierta la especie sea mayor al promedio general de vistas del stream.
La puntuación se calcula como la diferencia entre las vistas en esa hora y el promedio.

a) Implementar el predicado popularidad_relativa/2 que relacione una especie con su puntuación de popularidad relativa.
b) Indicar si el predicado promedio_de_vistas/1 se utiliza aquí de forma generadora o verificadora. Justificar.

4) Queremos saber si una especie es imponente.

Diremos que lo es si cada descubrimiento de esa especie fue realizado a mayor profundidad que el anterior (ordenados por hora).

Por ejemplo:

Si los descubrimientos de pulpo están en profundidades 3150, 3400, 3800, 3900 → es imponente.

En cambio, si se hubiera descubierto primero a 3900 y después a 3150 → no lo sería.

a) Implementar el predicado es_imponente/1 que relacione una especie con esta propiedad.
b) Para la resolución puede emplearse recursividad.