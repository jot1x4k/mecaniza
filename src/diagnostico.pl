
:- dynamic respuesta/2.

% 1. Sistema electrico y arranque
diagnostico(bateria_descargada) :-
	respuesta(bateria_descargada, true),
	!.

diagnostico(motor_arranque_defectuoso) :-
	respuesta(motor_arranque_defectuoso, true),
	!.

diagnostico(alternador_defectuoso) :-
	respuesta(alternador_defectuoso, true),
	!.

% 2. Combustible
diagnostico(tanque_combustible_vacio) :-
	(   respuesta(tanque_combustible_vacio, true)
	;   respuesta(tanque_comustible_vacio, true)
	),
	!.

% Alias de compatibilidad ortografica
diagnostico(tanque_comustible_vacio) :-
	diagnostico(tanque_combustible_vacio),
	!.

% 3. Temperatura y refrigeracion
diagnostico(motor_sobrecalentado) :-
	respuesta(motor_sobrecalentado, true),
	!.

diagnostico(radiador_con_fuga) :-
	respuesta(radiador_con_fuga, true),
	!.

% 4. Lubricacion
diagnostico(nivel_aceite_bajo) :-
	respuesta(nivel_aceite_bajo, true),
	!.

diagnostico(desgaste_arbol_levas) :-
	respuesta(desgaste_arbol_levas, true),
	!.

% 5. Frenos
diagnostico(fuga_liquido_frenos) :-
	respuesta(fuga_liquido_frenos, true),
	!.

diagnostico(frenos_desgastados) :-
	respuesta(frenos_desgastados, true),
	!.

diagnostico(discos_freno_alabeados) :-
	respuesta(discos_freno_alabeados, true),
	!.

% 6. Gestion electronica e inyeccion
diagnostico(sensor_mal_calibrado) :-
	respuesta(sensor_mal_calibrado, true),
	!.

diagnostico(inyectores_sucios) :-
	respuesta(inyectores_sucios, true),
	!.

% 7. Encendido
diagnostico(bujias_defectuosas) :-
	respuesta(bujias_defectuosas, true),
	!.

diagnostico(bobina_encendido_defectuosa) :-
	respuesta(bobina_encendido_defectuosa, true),
	!.

% 8. Transmision y embrague
diagnostico(falla_embrague) :-
	respuesta(falla_embrague, true),
	!.

diagnostico(sincronizadores_transmision) :-
	respuesta(sincronizadores_transmision, true),
	!.

% 9. Direccion y neumaticos
diagnostico(presion_neumaticos_baja) :-
	respuesta(presion_neumaticos_baja, true),
	!.

diagnostico(direccion_asistida_defectuosa) :-
	respuesta(direccion_asistida_defectuosa, true),
	!.

% 10. Admision y escape
diagnostico(filtro_aire_obstruido) :-
	respuesta(filtro_aire_obstruido, true),
	!.

diagnostico(desgaste_anillos_motor) :-
	respuesta(desgaste_anillos_motor, true),
	!.
