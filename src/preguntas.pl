
:- dynamic respuesta/2.

pregunta(
	bateria_descargada,
	'¿Al intentar arrancar el auto, el tablero queda completamente apagado (sin ninguna luz encendida)?'
).

pregunta(
	motor_arranque_defectuoso,
	'¿Al intentar arrancar, solo escuchas un clic o chasquido y el motor no gira?'
).

pregunta(
	alternador_defectuoso,
	'¿Con el motor ya encendido, sigue prendida la luz de la bateria en el tablero?'
).


pregunta(
	tanque_combustible_vacio,
	'¿La aguja de la gasolina marca que el tanque esta vacio (en la E o en reserva)?'
).


pregunta(
	motor_sobrecalentado,
	'¿La aguja de temperatura del motor esta en la zona roja?'
).

pregunta(
	radiador_con_fuga,
	'¿Sale vapor o humo blanco de la parte delantera del auto (debajo del capo)?'
).


pregunta(
	nivel_aceite_bajo,
	'¿Esta encendida en el tablero la luz roja con forma de aceitera?'
).

pregunta(
	desgaste_arbol_levas,
	'¿Escuchas un golpeteo metalico seguido (como un tictac) que viene del motor?'
).

pregunta(
	fuga_liquido_frenos,
	'¿Al pisar el freno, el pedal se va hasta el fondo y se siente flojo, sin resistencia?'
).

pregunta(
	frenos_desgastados,
	'¿Al frenar, escuchas un chirrido agudo y constante?'
).

pregunta(
	discos_freno_alabeados,
	'¿El volante vibra con fuerza solo cuando frenas?'
).

pregunta(
	sensor_mal_calibrado,
	'¿Sigue encendida en el tablero la luz de advertencia del motor (Check Engine)?'
).

pregunta(
	inyectores_sucios,
	'¿Al acelerar, el auto da tirones o jaloneos de vez en cuando?'
).

pregunta(
	bujias_defectuosas,
	'¿Con el auto detenido y el motor encendido, vibra mucho o se sacude?'
).

pregunta(
	bobina_encendido_defectuosa,
	'¿En las mananas frias te cuesta mas que de costumbre encender el motor?'
).

pregunta(
	falla_embrague,
	'¿Al acelerar, el motor sube de revoluciones pero el auto casi no avanza?'
).

pregunta(
	sincronizadores_transmision,
	'¿La palanca de cambios se siente dura o las marchas raspan al meterlas?'
).

pregunta(
	presion_neumaticos_baja,
	'¿El volante se va solo hacia un lado cuando manejas en linea recta?'
).

pregunta(
	direccion_asistida_defectuosa,
	'¿El volante se siente muy duro o pesado al girarlo?'
).

pregunta(
	filtro_aire_obstruido,
	'¿Sale humo negro por el escape cuando aceleras a fondo?'
).

pregunta(
	desgaste_anillos_motor,
	'¿Sale humo azulado por el escape de forma constante, con olor a aceite quemado?'
).

guardar_respuesta(Pregunta, Entrada) :-
	normalizar_respuesta(Entrada, Valor),
	retractall(respuesta(Pregunta, _)),
	assertz(respuesta(Pregunta, Valor)),
	(   Pregunta == tanque_combustible_vacio
	->  retractall(respuesta(tanque_comustible_vacio, _)),
	    assertz(respuesta(tanque_comustible_vacio, Valor))
	;   Pregunta == tanque_comustible_vacio
	->  retractall(respuesta(tanque_comustible_vacio, _)),
	    assertz(respuesta(tanque_comustible_vacio, Valor))
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
