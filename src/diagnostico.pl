
:- dynamic respuesta/2.

diagnostico(bateria_descargada) :-
	respuesta(bateria_descargada, true).

diagnostico(tanque_comustible_vacio) :-
	respuesta(tanque_comustible_vacio, true).

diagnostico(tanque_combustible_vacio) :-
	diagnostico(tanque_comustible_vacio).

diagnostico(sensor_mal_calibrado) :-
	respuesta(sensor_mal_calibrado, true).
