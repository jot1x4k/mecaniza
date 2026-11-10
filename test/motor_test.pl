% ===========================================================================
% MECANIZA - Pruebas Unitarias del Motor de Inferencia
% ===========================================================================

:- use_module(library(plunit)).

:- prolog_load_context(directory, Dir),
	absolute_file_name('../src/base.pl', Base, [relative_to(Dir)]),
	absolute_file_name('../src/preguntas.pl', Preguntas, [relative_to(Dir)]),
	absolute_file_name('../src/diagnostico.pl', Diagnostico, [relative_to(Dir)]),
	absolute_file_name('../src/motor.pl', Motor, [relative_to(Dir)]),
	consult(Base),
	consult(Preguntas),
	consult(Diagnostico),
	consult(Motor).

:- begin_tests(motor_inferencia).

test(inicializacion_limpia) :-
	iniciar_diagnostico,
	\+ respuesta(_, _),
	estado(en_curso),
	!.

test(normalizacion_respuestas) :-
	normalizar_respuesta(si, true),
	normalizar_respuesta('Si', true),
	normalizar_respuesta('SI', true),
	normalizar_respuesta(no, false),
	normalizar_respuesta('No', false),
	normalizar_respuesta('NO', false),
	!.

test(diagnostico_bateria_descargada) :-
	iniciar_diagnostico,
	responder(bateria_descargada, si),
	estado(diagnosticado(bateria_descargada)),
	resultado(problema(bateria_descargada, Nombre, Solucion, Recomendacion, _, _)),
	Nombre \== '',
	Solucion \== '',
	Recomendacion \== '',
	!.

test(diagnostico_tanque_combustible_vacio) :-
	iniciar_diagnostico,
	responder(tanque_combustible_vacio, si),
	estado(diagnosticado(tanque_combustible_vacio)),
	!.

test(diagnostico_motor_sobrecalentado) :-
	iniciar_diagnostico,
	responder(motor_sobrecalentado, si),
	estado(diagnosticado(motor_sobrecalentado)),
	!.

test(diagnostico_frenos_desgastados) :-
	iniciar_diagnostico,
	responder(frenos_desgastados, si),
	estado(diagnosticado(frenos_desgastados)),
	!.

test(diagnostico_alternador_defectuoso) :-
	iniciar_diagnostico,
	responder(alternador_defectuoso, si),
	estado(diagnosticado(alternador_defectuoso)),
	!.

test(diagnostico_radiador_con_fuga) :-
	iniciar_diagnostico,
	responder(radiador_con_fuga, si),
	estado(diagnosticado(radiador_con_fuga)),
	!.

test(diagnostico_inyectores_sucios) :-
	iniciar_diagnostico,
	responder(inyectores_sucios, si),
	estado(diagnosticado(inyectores_sucios)),
	!.

test(flujo_alternativo_sin_diagnostico) :-
	iniciar_diagnostico,
	forall(pregunta(P, _), responder(P, no)),
	estado(sin_diagnostico),
	!.

test(base_conocimiento_ampliada) :-
	findall(Id, problema_info(Id, _, _, _, _, _), Ids),
	length(Ids, Cantidad),
	Cantidad >= 20,
	!.

test(cada_pregunta_es_atomica_y_coherente) :-
	forall(pregunta(_, Texto), (
		atom_length(Texto, Len),
		Len > 25,
		sub_atom(Texto, 0, 1, _, '¿'),
		% Verifica que termine con interrogacion
		sub_atom(Texto, _, 1, 0, '?')
	)),
	!.

:- end_tests(motor_inferencia).
