% ===========================================================================
% MECANIZA - Pruebas Unitarias de la Interfaz Grafica (XPCE)
% ===========================================================================

:- use_module(library(plunit)).
:- use_module(library(pce)).

:- prolog_load_context(directory, Dir),
	absolute_file_name('../main.pl', Main, [relative_to(Dir)]),
	consult(Main).

:- begin_tests(gui_interfaz).

test(envoltura_de_texto) :-
	Texto = 'Este es un texto largo disenado para probar la division de lineas respetando las palabras',
	wrap_texto(Texto, 30, Envuelto),
	sub_atom(Envuelto, _, _, _, '\n'),
	!.

test(creacion_boton_personalizado) :-
	new(B, mecaniza_button('Test', message(@(prolog), true), 200, 60)),
	send(B, compute),
	get(B, width, W),
	get(B, height, H),
	W >= 200,
	H >= 60,
	send(B, destroy),
	!.

test(estilo_y_color_boton_especificacion) :-
	new(BtnSi, mecaniza_button('Si', message(@(prolog), true), 180, 58)),
	estilizar_boton(BtnSi, '#2f9e44', '#ebfbee'),
	get(BtnSi, colour, CSi),
	CSi \== @default,
	new(BtnNo, mecaniza_button('No', message(@(prolog), true), 180, 58)),
	estilizar_boton(BtnNo, '#e03131', '#fff5f5'),
	get(BtnNo, colour, CNo),
	CNo \== @default,
	send(BtnSi, destroy),
	send(BtnNo, destroy),
	!.

test(dimensiones_dialogo_ampliado) :-
	new(D, dialog('Test Dialog')),
	send(D, size, size(960, 620)),
	send(D, open),
	get(D, width, DW),
	get(D, height, DH),
	DW =:= 960,
	DH =:= 620,
	send(D, destroy),
	!.

test(ciclo_de_vistas_gui) :-
	new(D, dialog('Test Ciclo Vistas')),
	send(D, size, size(960, 620)),
	% 1. Home View
	mostrar_home_view(D),
	% 2. Iniciar Diagnostico -> Form View
	iniciar_flujo_diagnostico(D),
	pregunta_actual(Pregunta, _),
	Pregunta \== '',
	% 3. Responder Si -> Diagnostic View Exito
	responder_y_avanzar(D, Pregunta, si),
	% 4. Volver al menu -> Home View
	volver_al_menu(D),
	% 5. Form View -> Responder No a todas -> Sin Diagnostico
	iniciar_flujo_diagnostico(D),
	forall(pregunta(P, _), responder(P, no)),
	evaluar_siguiente_paso(D),
	% 6. Volver al menu y destruir
	volver_al_menu(D),
	send(D, destroy),
	!.

:- end_tests(gui_interfaz).
