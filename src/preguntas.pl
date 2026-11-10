% ===========================================================================
% MECANIZA - Preguntas y Captura de Respuestas
% ===========================================================================

:- dynamic respuesta/2.

pregunta(
	bateria_descargada,
	'¿Al girar la llave de su vehiculo, el tablero se ilumina?'
).

pregunta(
	tanque_comustible_vacio,
	'¿Al girar la llave de su vehiculo, el motor arranca?'
).

pregunta(
	sensor_mal_calibrado,
	'¿Al acelerar su vehiculo, siente que le falta potencia o va a tirones?'
).

% Guarda una sola respuesta por pregunta. Normaliza verdadero/falso y si/no.
guardar_respuesta(Pregunta, Respuesta) :-
	normalizar_respuesta(Respuesta, Valor),
	retractall(respuesta(Pregunta, _)),
	assertz(respuesta(Pregunta, Valor)).

normalizar_respuesta(si, true).
normalizar_respuesta(no, false).
normalizar_respuesta(true, true).
normalizar_respuesta(false, false).
normalizar_respuesta('si', true).
normalizar_respuesta('no', false).
normalizar_respuesta('Si', true).
normalizar_respuesta('No', false).
normalizar_respuesta('SI', true).
normalizar_respuesta('NO', false).
