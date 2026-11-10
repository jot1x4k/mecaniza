% ===========================================================================
% MECANIZA - Reglas Logicas de Inferencia y Diagnostico
% ===========================================================================

:- dynamic respuesta/2.

% Reglas de inferencia basadas en los sintomas registrados:

diagnostico(bateria_descargada) :-
	respuesta(bateria_descargada, true),
	!.

diagnostico(tanque_combustible_vacio) :-
	(   respuesta(tanque_combustible_vacio, true)
	;   respuesta(tanque_comustible_vacio, true)
	),
	!.

% Alias de compatibilidad ortografica
diagnostico(tanque_comustible_vacio) :-
	diagnostico(tanque_combustible_vacio),
	!.

diagnostico(alternador_defectuoso) :-
	respuesta(alternador_defectuoso, true),
	!.

diagnostico(motor_sobrecalentado) :-
	respuesta(motor_sobrecalentado, true),
	!.

diagnostico(nivel_aceite_bajo) :-
	respuesta(nivel_aceite_bajo, true),
	!.

diagnostico(fuga_liquido_frenos) :-
	respuesta(fuga_liquido_frenos, true),
	!.

diagnostico(frenos_desgastados) :-
	respuesta(frenos_desgastados, true),
	!.

diagnostico(sensor_mal_calibrado) :-
	respuesta(sensor_mal_calibrado, true),
	!.

diagnostico(bujias_defectuosas) :-
	respuesta(bujias_defectuosas, true),
	!.

diagnostico(falla_embrague) :-
	respuesta(falla_embrague, true),
	!.

diagnostico(presion_neumaticos_baja) :-
	respuesta(presion_neumaticos_baja, true),
	!.

diagnostico(filtro_aire_obstruido) :-
	respuesta(filtro_aire_obstruido, true),
	!.
