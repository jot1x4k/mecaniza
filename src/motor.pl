
:- dynamic respuesta/2.

iniciar_diagnostico :-
	retractall(respuesta(_, _)).

reiniciar :-
	iniciar_diagnostico.

pregunta_pendiente(Pregunta, Texto) :-
	pregunta(Pregunta, Texto),
	\+ respuesta(Pregunta, _).

pregunta_actual(Pregunta, Texto) :-
	\+ diagnostico_actual(_),
	findall(P-T, pregunta_pendiente(P, T), [Pregunta-Texto|_]).

diagnostico_actual(Problema) :-
	diagnostico(Problema),
	!.

diagnosticos(Problemas) :-
	findall(Problema, diagnostico(Problema), Problemas).

responder(Pregunta, Respuesta) :-
	guardar_respuesta(Pregunta, Respuesta).

responder_si :-
	pregunta_actual(Pregunta, _),
	responder(Pregunta, si).

responder_no :-
	pregunta_actual(Pregunta, _),
	responder(Pregunta, no).

estado(diagnosticado(Problema)) :-
	diagnostico_actual(Problema),
	!.
estado(sin_diagnostico) :-
	\+ pregunta_pendiente(_, _),
	!.
estado(en_curso).

finalizado :-
	estado(Estado),
	Estado \= en_curso.

resultado(problema(Id, Nombre, Solucion, Recomendacion, Categoria, Asset)) :-
	diagnostico_actual(Id),
	problema_info(Id, Nombre, Solucion, Recomendacion, Categoria, Asset),
	!.

preguntas_pendientes(Preguntas) :-
	findall(Pregunta-Texto, pregunta_pendiente(Pregunta, Texto), Preguntas).

respuestas(Respuestas) :-
	findall(Pregunta-Valor, respuesta(Pregunta, Valor), Respuestas).
