% ===========================================================================
% MECANIZA - Preguntas y Captura de Respuestas
% ===========================================================================

:- dynamic respuesta/2.

% Cada pregunta indaga por un sintoma o condicion mecanica coherente con el vehiculo:

pregunta(
	bateria_descargada,
	'¿Al intentar encender el vehiculo, el tablero no enciende (o parpadea debilmente) y el motor no hace ningun sonido o solo un chasquido?'
).

pregunta(
	tanque_combustible_vacio,
	'¿El motor de arranque gira con fuerza al intentar arrancar pero el motor no enciende y el indicador de combustible marca vacio o reserva?'
).

pregunta(
	alternador_defectuoso,
	'¿El vehiculo se apago repentinamente en marcha, las luces perdieron intensidad y se encendio el testigo con simbolo de bateria?'
).

pregunta(
	motor_sobrecalentado,
	'¿El indicador de temperatura esta en la zona roja o se observa vapor o humo con olor dulce saliendo del capo?'
).

pregunta(
	nivel_aceite_bajo,
	'¿Se encendio el testigo rojo de presion de aceite en el tablero o escucha un golpeteo metalico continuo proveniente del motor?'
).

pregunta(
	fuga_liquido_frenos,
	'¿Al pisar el freno nota el pedal excesivamente esponjoso o este se va hasta el fondo del piso perdiendo capacidad de frenado?'
).

pregunta(
	frenos_desgastados,
	'¿Al frenar escucha un chirrido metalico agudo persistente o percibe vibraciones intensas en el pedal y volante?'
).

pregunta(
	sensor_mal_calibrado,
	'¿El testigo "Check Engine" esta encendido permanentemente y siente que el motor tironea o pierde aceleracion de manera irregular?'
).

pregunta(
	bujias_defectuosas,
	'¿El motor vibra excesivamente detenido en ralenti, cuesta encenderlo en frio y nota un aumento anormal en el consumo de combustible?'
).

pregunta(
	falla_embrague,
	'¿Al acelerar el motor sube de revoluciones pero el vehiculo no incrementa la velocidad con normalidad ("patina") o cuesta meter los cambios?'
).

pregunta(
	presion_neumaticos_baja,
	'¿Siente la direccion pesada, el automovil tira con fuerza hacia un lado en linea recta o percibe inestabilidad en el rodaje?'
).

pregunta(
	filtro_aire_obstruido,
	'¿El vehiculo se siente ahogado al exigirle aceleracion a fondo, expulsa humo negro por el escape y ha perdido potencia?'
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
