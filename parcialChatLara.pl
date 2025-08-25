%------- PUNTO 2 ------
especie_popular(Especie):-
    descubrimiento(_, Especie, _, _, _, _),
    forall((descubrimiento(_, Especie, _, _, Hora, _), vistas(Hora, Vistas)), Vistas >= 10000).

% se podria llamar especie_popular(pulpo) y daria falso

%------- PUNTO 3 ------
zonas_de_especie(Especie, Zonas):-
    descubrimiento(_, Especie, _, _, _, _),
    findall(Zona, (descubrimiento(_, Especie, _, Profundidad, _, _), zona(Profundidad, Zona), Zonas)).

% zonas_de_especie(anemona).

%------- PUNTO 4 ------
ranking_novedad(Ranking):-
    findall(novedadesPorDesc(Novedad, Descubrsimiento), (descubrimiento(Descubrimiento, _, _, _, _, _), nivelDeNovedad(Descubrimiento, Novedad)), Novedades),
    sort(Novedades, RankingAux),
    reverse(RankingAux, Ranking).

%ranking_novedad(Ranking), nth0(0, Ranking, PrimerElemento). lo que nos interesa es PrimerElemento 

%------- PUNTO 5 ------
especie_amenazante(Especie):-
    descubrimiento(_, Especie, _, _, _, observada),
    forall(descubrimiento(_, Especie, Caracteristicas, _, _, observada), masDe5DeConocimiento(Caracteristicas)).

masDe5DeConocimiento(Caracteristicas):-
    member(Caracteristica, Caracteristicas),
    unidades_de_conocimiento(Caracteristica, UnidadesDeConocimiento),
    UnidadesDeConocimiento >= 5.

%especie_amenazante(pez_linterna).

%------- PUNTO 6 ------
ascendente():-
    findall(Hora, vistas(Hora, _), Horas),
    sort(Horas, HorasOrdenadas),
    vistasAscendentes(HorasOrdenadas).

vistasAscendentes([]).
vistasAscendentes([_]).
vistasAscendentes([Primero, Segundo | Resto]):-
    vistas(Primero, VistasPrimero),
    vistas(Segundo, VistasSegundo),
    VistasSegundo >= VistasPrimero,
    vistasAscendentes([Segundo|Resto]).


