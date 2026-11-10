% ===========================================================================
% MECANIZA - Preguntas Atomicas y Captura de Respuestas
%
% Cada pregunta formula una sola interrogante puntual y contextualizada
% sobre un sintoma mecanico o indicador especifico del vehiculo.
% ===========================================================================

:- dynamic respuesta/2.

% 1. Sistema electrico y arranque
pregunta(
	bateria_descargada,
	'¿Al girar la llave de encendido, el tablero de instrumentos permanece totalmente apagado?'
).

pregunta(
	motor_arranque_defectuoso,
	'¿Al accionar la llave de encendido, escucha unicamente un chasquido o clic en el motor?'
).

pregunta(
	alternador_defectuoso,
	'¿El testigo con simbolo de bateria permanece encendido en el tablero con el motor en marcha?'
).

% 2. Combustible y alimentacion
pregunta(
	tanque_combustible_vacio,
	'¿El indicador de combustible del tablero marca que el tanque se encuentra vacio?'
).

% 3. Temperatura y refrigeracion
pregunta(
	motor_sobrecalentado,
	'¿La aguja de temperatura del motor se ubica en la zona roja de advertencia?'
).

pregunta(
	radiador_con_fuga,
	'¿Observa salir vapor de agua o humo blanco por debajo del capo del vehiculo?'
).

% 4. Lubricacion
pregunta(
	nivel_aceite_bajo,
	'¿Se encuentra encendido el testigo rojo de la aceitera en el cuadro de instrumentos?'
).

pregunta(
	desgaste_arbol_levas,
	'¿Escucha un golpeteo metalico continuo tipo tictac proveniente del motor?'
).

% 5. Sistema de frenos
pregunta(
	fuga_liquido_frenos,
	'¿Al pisar el pedal de freno, este se hunde hasta el fondo del piso sin ofrecer resistencia?'
).

pregunta(
	frenos_desgastados,
	'¿Al presionar el pedal del freno, escucha un chirrido metalico agudo constante?'
).

pregunta(
	discos_freno_alabeados,
	'¿El volante de la direccion vibra fuertemente de forma exclusiva al frenar?'
).

% 6. Gestion electronica e inyeccion
pregunta(
	sensor_mal_calibrado,
	'¿El testigo Check Engine de fallo de motor permanece encendido en el tablero?'
).

pregunta(
	inyectores_sucios,
	'¿Al acelerar el vehiculo siente tirones bruscos de manera intermitente?'
).

% 7. Encendido
pregunta(
	bujias_defectuosas,
	'¿El motor vibra excesivamente cuando el vehiculo se encuentra detenido en ralenti?'
).

pregunta(
	bobina_encendido_defectuosa,
	'¿Le cuesta al motor arrancar de forma prolongada en las mananas frias?'
).

% 8. Transmision y embrague
pregunta(
	falla_embrague,
	'¿Al acelerar el motor sube de revoluciones pero el vehiculo apenas gana velocidad?'
).

pregunta(
	sincronizadores_transmision,
	'¿La palanca de cambios se siente trabada o raspan las marchas al meterlas?'
).

% 9. Direccion y neumaticos
pregunta(
	presion_neumaticos_baja,
	'¿El volante de la direccion se desvia con fuerza hacia un lado al circular en linea recta?'
).

pregunta(
	direccion_asistida_defectuosa,
	'¿Siente el volante de la direccion anormalmente duro o pesado al maniobrar?'
).

% 10. Admision y escape
pregunta(
	filtro_aire_obstruido,
	'¿El tubo de escape expulsa humo negro visible cuando acelera a fondo?'
).

pregunta(
	desgaste_anillos_motor,
	'¿El tubo de escape expulsa humo azulado constante con olor a aceite quemado?'
).

% Guarda una sola respuesta por pregunta. Normaliza verdadero/falso y si/no.
guardar_respuesta(Pregunta, Entrada) :-
	normalizar_respuesta(Entrada, Valor),
	retractall(respuesta(Pregunta, _)),
	assertz(respuesta(Pregunta, Valor)),
	% Sincronizacion de alias por compatibilidad
	(   Pregunta == tanque_combustible_vacio
	->  retractall(respuesta(tanque_comustible_vacio, _)),
	    assertz(respuesta(tanque_comustible_vacio, Valor))
	;   Pregunta == tanque_comustible_vacio
	->  retractall(respuesta(tanque_combustible_vacio, _)),
	    assertz(respuesta(tanque_combustible_vacio, Valor))
	;   true
	),
	!.

normalizar_respuesta(si, true) :- !.
normalizar_respuesta(no, false) :- !.
normalizar_respuesta(true, true) :- !.
normalizar_respuesta(false, false) :- !.
normalizar_respuesta('si', true) :- !.
normalizar_respuesta('no', false) :- !.
normalizar_respuesta('Si', true) :- !.
normalizar_respuesta('No', false) :- !.
normalizar_respuesta('SI', true) :- !.
normalizar_respuesta('NO', false) :- !.
normalizar_respuesta("si", true) :- !.
normalizar_respuesta("no", false) :- !.
normalizar_respuesta("Si", true) :- !.
normalizar_respuesta("No", false) :- !.
normalizar_respuesta("SI", true) :- !.
normalizar_respuesta("NO", false) :- !.
