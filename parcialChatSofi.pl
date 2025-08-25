
%----- PUNTO 2 -----%
nivelDeRareza(Descubrimiento, Nivel):-
    descubrimiento(Descubrimiento, _, Caracteristicas, Profundidad, _, recolectado),
    length(Caracteristicas, CantCaracteristicas),
    zona(Profundidad,hadal),
    Nivel is CantCaracteristicas*2*2+5.

nivelDeRareza(Descubrimiento, Nivel):-
    descubrimiento(Descubrimiento, _, Caracteristicas, Profundidad, _, recolectado),
    length(Caracteristicas, CantCaracteristicas),
    not(zona(Profundidad,hadal)),
    Nivel is CantCaracteristicas*2+5.

nivelDeRareza(Descubrimiento, Nivel):-
    descubrimiento(Descubrimiento, _, Caracteristicas, Profundidad, _, observado),
    length(Caraceristicas, CantCaracteristicas),
    zona(Profundidad,hadal),
    Nivel is CantCaracteristicas*2*2.

nivel_de_rareza(Descubrimiento, Nivel):-
    descubrimiento(Descubrimiento, _, Caracteristicas, Profundidad, _, observado),
    length(Caraceristicas, CantCaracteristicas),
    not(zona(Profundidad,hadal)),
    Nivel is CantCaracteristicas*2.

%----- PUNTO 3 -----%
popularidad_relativa(Descubrimiento, Puntaje):-
    promedio_de_vistas(Promedio),
    descubrimiento(Descubrimiento, _, _, _, Hora, _),
    vistas(Hora, Vistas),
    calculoPuntaje(Vistas, Promedio, Puntaje).

calculoPuntaje(Vistas, Promedio, 0):-
    Vistas <= Promedio.
calculoPuntaje(Vistas, Promedio, Puntos):-
    Vistas > Promedio,
    Puntos is Vistas - Promedio.

% promedio de vistas se usa de forma generadora ya que buscamos que  nos devuelva un valor que vamos luego a utilizar

%----- PUNTO 4 -----%
/*modo con recursividad*/
es_imponente(Especie):-
    descubrimiento(_, Especie, _, _ , _, _),
    findall(profPorHora(Hora, Profundidad), descubrimiento(_, Especie, _, Profundidad , Hora, _), ListaProfs),
    sort(ListaProfs, ListaProfsOrdenada),
    prof_mayor_a_anterior(ListaProfsOrdenada).

prof_mayor_a_anterior([_, []]). %ESTO ES SOLO ([_]) PARA UN SOLO ELEMENTO
prof_mayor_a_anterior([profPorHora(Hora1, Prof1), profPorHora(Hora2, Prof2) | Resto]):-
    Prof1 > Prof2
    prof_mayor_a_anterior(profPorHora(Hora2, Prof2) | Resto).

/*modo sin recursividad que me da dudas*/
es_imponente2(Especie):-
    escubrimiento(_, Especie, _, _, _, _) %ligar especie para inversibilidad
    forall(descubrimiento(_, Especie, _, Profundidad, Hora, _),
            (forall((descubrimiento(_, Especie, _, OtraProfundidad, OtraHora, _), OtraHora > Hora), Profundidad > OtraProfundidad))).









