%-------- BASE DE CONOCIMIENTOS --------
%vistas(hora, cantidad)
vistas(0, 2500).
vistas(1, 1800).
vistas(2, 1200).
vistas(3, 900).
vistas(4, 750).
vistas(5, 600).
vistas(6, 800).
vistas(7, 1500).
vistas(8, 3200).
vistas(9, 5800).
vistas(10, 8500).
vistas(11, 11200).
vistas(12, 13800).
vistas(13, 15200).
vistas(14, 16800).
vistas(15, 18500).
vistas(16, 10000).
vistas(17, 12000).
vistas(18, 12000).
vistas(19, 12000).
vistas(20, 12000).
vistas(21, 12000).
vistas(22, 12000).
vistas(23, 12000).

%descubrimiento(identificador, especie, [caracteristicas], profundidad, hora, observado/recolectado)
descubrimiento(a1, pulpo, [extremidades(8), luminisciencia], 3400, 07, observado).
descubrimiento(a2, pulpo, [extremidades(8), color(azul)], 3150, 08, observado).
descubrimiento(b1, estrella, [extremidades(5), color(naranja), culona], 3400, 12, observado).
descubrimiento(c1, pepino_de_mar, [color(violeta)], 1900, 14, observado).
descubrimiento(d1, anemona, [extremidades(30)],	1900, 15, recolectado).
descubrimiento(d2, anemona, [extremidades(35)], 2200, 16, recolectado).
descubrimiento(c2, pepino_pelagico,	[transparente, luminisciencia], 2800, 17, recolectado).
descubrimiento(e1, pez_linterna, [luminisciencia, color(rojo)], 3200, 19, observado).
descubrimiento(a2, pulpo_de_cristal, [transparente, fragil], 3800, 21, recolectado).
descubrimiento(a3, pulpo_dumbo, [extremidades(10), color(gris)], 3900, 23, observado).


%--------- PREDICADOS -------
zonas(fotica).
zonas(batial).
zonas(abisal).
zonas(hadal).

zonaOceanica(Profundidad, fotica):-
    Profundidad =< 610. %se podria haber hecho con between
zonaOceanica(Profundidad, batial):-
    Profundidad >= 1000, 
    Profundidad =< 4000.
zonaOceanica(Profundidad, abisal):-
    Profundidad > 4000,
    Profundidad =< 6000.
zonaOceanica(Profundidad, hadal):-
    Profundidad > 6000.

favoritaDelPublico(EspeciesFavs):- %el la hizo distinta, con el forall
    findall(Cantidad, vistas(_, Cantidad), Vistas),
    max_list(Vistas, Max),
    vistas(Hora, Max),
    findall(Especie, descubrimiento(_, Especie, _, _, Hora, _), EspeciesFavs).

zonaDescubrimiento(Especie, Zona):-
    descubrimiento(_, Especie, _, Profundidad, _, _),
    zonaOceanica(Profundidad, Zona).

zonaConMaxDescubrimientos(Zona) :-
    descubrimientosPorZona(Zona, Cantidad),
    forall(
        (descubrimientosPorZona(OtraZona, OtraCantidad), Zona \= OtraZona),
        OtraCantidad < Cantidad
    ).
descubrimientosPorZona(Zona, Cantidad):-
    zonas(Zona),
    findall(Zona, zonaDescubrimiento(_, Zona), EspeciesEnEsaZona),
    length(EspeciesEnEsaZona, Cantidad).

promedioVistas(Promedio):-
    findall(Vistas, vistas(_, Vistas), TodasLasVistas),
    sum_list(TodasLasVistas, Total),
    length(TodasLasVistas, CantVistas),
    Promedio is Total / CantVistas.

variacionProfundidad(HoraInicio, HoraFin, Variacion):-
    descubrimiento(_, _, _, ProfundidadInicio, HoraInicio, _),
    descubrimiento(_, _, _, ProfundidadFin, HoraFin, _),
    HoraInicio < HoraFin, 
    Variacion is ProfundidadFin - ProfundidadInicio.

%descensoMasRapido(HoraInicio, HoraFin):-
 %   VariacionMaxima is 0,
  %  forall((variacionProfundidad(HoraInicioCaso, HoraFinCaso, Variacion), Variacion > VariacionMaxima), (Variacion is VariacionMaxima, HoraInicio is HoraInicioCaso, HoraFin is HoraFinCaso)).

mayorDescenso(Hora1, Hora2) :- %% ESTO ES CUAL ES EL MAYOR DESCENSO, NO EL MAS RAPIDO (funciona igual)
    findall((Variacion, HoraInicio, HoraFin),
            variacionProfundidad(HoraInicio, HoraFin, Variacion),
            ListaVariaciones),
    ListaVariaciones \= [],
    max_member((_, HoraInicio, HoraFin), ListaVariaciones),
    Hora1 is HoraInicio,
    Hora2 is HoraFin.

descensoMasRapido(Hora1, Hora2, MayorVelocidad):-
    findall((Velocidad, HoraInicio, HoraFin),
            (variacionProfundidad(HoraInicio, HoraFin, Variacion), Velocidad is Variacion / (HoraFin - HoraInicio)), %se podria abstraer en otra funcion y hacer con forall 
            ListaVariaciones),
    max_member((Velocidad, HoraInicio, HoraFin), ListaVariaciones),
    MayorVelocidad is Velocidad,
    Hora1 is HoraInicio,
    Hora2 is HoraFin.

nivelDeNovedad(Descubrimiento, Nivel):-
    descubrimiento(Descubrimiento, _, Caracteristicas, _, _, Metodo),
    findall(Puntaje, (member(Caracteristica, Caracteristicas), unidadDeConocimiento(Caracteristica, Puntaje)), Puntajes),
    sum_list(Puntajes, NivelAux),
    aumentoPorMetodo(NivelAux, Metodo, Nivel).

unidadDeConocimiento(luminisciencia, 5).
unidadDeConocimiento(extremidades(Cantidad), Cantidad).
unidadDeConocimiento(color(rojo), 5). %separar en algo de color peligroso
unidadDeConocimiento(color(amarillo), 5).
unidadDeConocimiento(color(Tono), Nivel):-
    Tono \= rojo,
    Tono \= amarillo,
    Nivel is 3.
unidadDeConocimiento(Caracteristica, 10):- %separar entre conocidos y no conocidos
    Caracteristica \= luminisciencia,
    Caracteristica \= extremidades(_),
    Caracteristica \= color(_).

aumentoPorMetodo(NivelAux, recolectado, Nivel):-
    Nivel is NivelAux * 1.5.
aumentoPorMetodo(NivelAux, observado, NivelAux).






