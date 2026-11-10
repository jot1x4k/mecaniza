% ===========================================================================
% MECANIZA - Interfaz Grafica de Usuario (XPCE)
%
% Implementa las vistas segun la documentacion y prototipos:
%   - home_view: Pantalla principal de bienvenida y acceso al diagnostico.
%   - form_view: Presentacion iterativa de preguntas con opciones Si / No.
%   - diagnostic_view: Presentacion del diagnostico final o flujo alternativo.
% ===========================================================================

:- use_module(library(pce)).

% ---------------------------------------------------------------------------
% Componentes y utilidades graficas
% ---------------------------------------------------------------------------

% Boton personalizado con dimensiones minimas configurables para mejorar
% la ergonomia tactil/clic en XPCE.
:- pce_begin_class(mecaniza_button, button, "Boton con dimensiones personalizadas y estilos").
variable(min_width, int := 140, both, "Ancho minimo").
variable(min_height, int := 45, both, "Alto minimo").

initialise(B, Name:[name], Message:[code]*, MinW:[int], MinH:[int]) :->
	default(MinW, 140, MW),
	default(MinH, 45, MH),
	send_super(B, initialise, Name, Message),
	send(B, slot, min_width, MW),
	send(B, slot, min_height, MH).

compute(B) :->
	send_super(B, compute),
	get(B, min_width, MW),
	get(B, min_height, MH),
	get(B, width, W),
	get(B, height, H),
	NW is max(W, MW),
	NH is max(H, MH),
	(   (W \== NW ; H \== NH)
	->  send_super(B, size, size(NW, NH))
	;   true
	).

:- pce_end_class.

% Aplica colores de texto/borde y fondo a un boton segun la especificacion.
estilizar_boton(Btn, TextColorHex, BgColorHex) :-
	(   TextColorHex \== @default
	->  send(Btn, colour, colour(TextColorHex))
	;   true
	),
	(   BgColorHex \== @default
	->  send(Btn, background, colour(BgColorHex))
	;   true
	).

% Centra un elemento grafico horizontalmente dentro del dialogo en la coordenada Y dada.
centrar_horizontal(D, Item, Y) :-
	get(D, width, DW),
	get(Item, width, IW),
	X is max(20, (DW - IW) // 2),
	send(D, display, Item, point(X, Y)).

% Divide un texto largo en lineas respetando palabras.
wrap_texto(Texto, MaxLen, Wrapped) :-
	atomic_list_concat(Words, ' ', Texto),
	wrap_words(Words, MaxLen, 0, [], Lines),
	atomic_list_concat(Lines, '\n', Wrapped).

wrap_words([], _, _, Current, [Line]) :-
	Current \== [],
	!,
	atomic_list_concat(Current, ' ', Line).
wrap_words([], _, _, [], []).
wrap_words([W|Rest], MaxLen, CurrentLen, Current, Lines) :-
	atom_length(W, WL),
	(   Current == []
	->  wrap_words(Rest, MaxLen, WL, [W], Lines)
	;   NewLen is CurrentLen + 1 + WL,
	    (   NewLen > MaxLen
	    ->  atomic_list_concat(Current, ' ', Line),
	        Lines = [Line|RestLines],
	        wrap_words(Rest, MaxLen, WL, [W], RestLines)
	    ;   append(Current, [W], NextCurrent),
	        wrap_words(Rest, MaxLen, NewLen, NextCurrent, Lines)
	    )
	).

% ---------------------------------------------------------------------------
% Inicializacion de la ventana
% ---------------------------------------------------------------------------

% Abre o enfoca la ventana principal de la aplicacion
iniciar_gui :-
	(   object(@mecaniza_dialog)
	->  send(@mecaniza_dialog, destroy)
	;   true
	),
	crear_interfaz_diagnostico.

% Crea la ventana principal ampliada y presenta home_view
crear_interfaz_diagnostico :-
	new(@mecaniza_dialog, dialog('MECANIZA')),
	send(@mecaniza_dialog, size, size(960, 620)),
	mostrar_home_view(@mecaniza_dialog),
	send(@mecaniza_dialog, open_centered).

% ---------------------------------------------------------------------------
% Vista 1: home_view
% ---------------------------------------------------------------------------
mostrar_home_view(D) :-
	send(D, clear),
	
	% Titulo
	new(Title, text('MECANIZA')),
	send(Title, font, font(helvetica, bold, 42)),
	send(Title, colour, colour('#1e1e1e')),
	centrar_horizontal(D, Title, 70),
	
	% Subtitulo
	new(Sub, text('Diagnostica problemas comunes en segundos!')),
	send(Sub, font, font(helvetica, roman, 18)),
	send(Sub, colour, colour('#495057')),
	centrar_horizontal(D, Sub, 150),
	
	% Boton Iniciar Diagnostico
	new(BtnStart, mecaniza_button('iniciar diagnostico', message(@prolog, iniciar_flujo_diagnostico, D), 280, 58)),
	send(BtnStart, font, font(helvetica, bold, 16)),
	estilizar_boton(BtnStart, '#1e1e1e', '#f1f3f5'),
	centrar_horizontal(D, BtnStart, 260),
	
	% Boton Salir (color rojo segun la especificacion #e03131)
	new(BtnExit, mecaniza_button('salir', message(D, destroy), 180, 48)),
	send(BtnExit, font, font(helvetica, bold, 15)),
	estilizar_boton(BtnExit, '#e03131', '#fff5f5'),
	centrar_horizontal(D, BtnExit, 350),
	
	% Pie de pagina
	new(Footer, text('MECANIZA\njot1x4k @ 2026')),
	send(Footer, font, font(helvetica, oblique, 12)),
	send(Footer, colour, colour('#868e96')),
	send(Footer, format, center),
	centrar_horizontal(D, Footer, 530).

% Inicia el diagnostico en el motor y pasa a form_view
iniciar_flujo_diagnostico(D) :-
	iniciar_diagnostico,
	mostrar_form_view(D).

% ---------------------------------------------------------------------------
% Vista 2: form_view
% ---------------------------------------------------------------------------
mostrar_form_view(D) :-
	send(D, clear),
	
	(   pregunta_actual(Pregunta, Texto)
	->  wrap_texto(Texto, 65, TextoEnvuelto),
	    new(PregLbl, text(TextoEnvuelto)),
	    send(PregLbl, font, font(helvetica, bold, 22)),
	    send(PregLbl, colour, colour('#212529')),
	    send(PregLbl, format, center),
	    centrar_horizontal(D, PregLbl, 130),
	    
	    % Boton Si (verde segun especificacion #2f9e44)
	    new(BtnSi, mecaniza_button('Si', message(@prolog, responder_y_avanzar, D, Pregunta, si), 180, 58)),
	    send(BtnSi, font, font(helvetica, bold, 20)),
	    estilizar_boton(BtnSi, '#2f9e44', '#ebfbee'),
	    
	    % Boton No (rojo segun especificacion #e03131)
	    new(BtnNo, mecaniza_button('No', message(@prolog, responder_y_avanzar, D, Pregunta, no), 180, 58)),
	    send(BtnNo, font, font(helvetica, bold, 20)),
	    estilizar_boton(BtnNo, '#e03131', '#fff5f5'),
	    
	    % Posicionamiento centrado y equilibrado de ambos botones
	    get(D, width, DW),
	    AnchoBloque is 180 + 50 + 180,
	    XSi is max(20, (DW - AnchoBloque) // 2),
	    XNo is XSi + 180 + 50,
	    send(D, display, BtnSi, point(XSi, 320)),
	    send(D, display, BtnNo, point(XNo, 320)),
	    
	    % Pie de pagina
	    new(Footer, text('MECANIZA\njot1x4k @ 2026')),
	    send(Footer, font, font(helvetica, oblique, 12)),
	    send(Footer, colour, colour('#868e96')),
	    send(Footer, format, center),
	    centrar_horizontal(D, Footer, 530)
	;   evaluar_siguiente_paso(D)
	).

% Procesa la respuesta del usuario y evalua el estado del sistema
responder_y_avanzar(D, Pregunta, Respuesta) :-
	responder(Pregunta, Respuesta),
	evaluar_siguiente_paso(D).

% Determina que vista mostrar segun el estado del motor
evaluar_siguiente_paso(D) :-
	estado(diagnosticado(Id)),
	!,
	resultado(problema(Id, Nombre, Solucion, Recomendacion, _, _)),
	mostrar_diagnostic_view(D, exito(Nombre, Solucion, Recomendacion)).
evaluar_siguiente_paso(D) :-
	estado(sin_diagnostico),
	!,
	mostrar_diagnostic_view(D, sin_diagnostico).
evaluar_siguiente_paso(D) :-
	mostrar_form_view(D).

% ---------------------------------------------------------------------------
% Vista 3: diagnostic_view
% ---------------------------------------------------------------------------
mostrar_diagnostic_view(D, exito(Nombre, Solucion, Recomendacion)) :-
	send(D, clear),
	
	new(Hdr, text('Diagnostico sugerido por el sistema:')),
	send(Hdr, font, font(helvetica, bold, 24)),
	send(Hdr, colour, colour('#1e1e1e')),
	centrar_horizontal(D, Hdr, 40),
	
	new(Diag, text(Nombre)),
	send(Diag, font, font(helvetica, bold, 20)),
	send(Diag, colour, colour('#2b8a3e')),
	centrar_horizontal(D, Diag, 95),
	
	% Seccion de solucion
	new(LblSol, text('Solucion recomendada:')),
	send(LblSol, font, font(helvetica, bold, 16)),
	send(LblSol, colour, colour('#212529')),
	send(D, display, LblSol, point(90, 160)),
	
	wrap_texto(Solucion, 85, SolEnvuelto),
	new(Sol, text(SolEnvuelto)),
	send(Sol, font, font(helvetica, roman, 14)),
	send(Sol, colour, colour('#343a40')),
	send(D, display, Sol, point(90, 190)),
	
	% Seccion preventiva
	new(LblRec, text('Accion preventiva:')),
	send(LblRec, font, font(helvetica, bold, 16)),
	send(LblRec, colour, colour('#212529')),
	send(D, display, LblRec, point(90, 275)),
	
	wrap_texto(Recomendacion, 85, RecEnvuelto),
	new(Rec, text(RecEnvuelto)),
	send(Rec, font, font(helvetica, roman, 14)),
	send(Rec, colour, colour('#343a40')),
	send(D, display, Rec, point(90, 305)),
	
	% Boton Volver (color oscuro segun especificacion #1e1e1e)
	new(BtnMenu, mecaniza_button('Volver al menu', message(@prolog, volver_al_menu, D), 260, 54)),
	send(BtnMenu, font, font(helvetica, bold, 16)),
	estilizar_boton(BtnMenu, '#1e1e1e', '#f1f3f5'),
	centrar_horizontal(D, BtnMenu, 415),
	
	% Pie de pagina
	new(Footer, text('MECANIZA\njot1x4k @ 2026')),
	send(Footer, font, font(helvetica, oblique, 12)),
	send(Footer, colour, colour('#868e96')),
	send(Footer, format, center),
	centrar_horizontal(D, Footer, 530).

mostrar_diagnostic_view(D, sin_diagnostico) :-
	send(D, clear),
	
	new(Hdr, text('Diagnostico sugerido por el sistema:')),
	send(Hdr, font, font(helvetica, bold, 24)),
	send(Hdr, colour, colour('#1e1e1e')),
	centrar_horizontal(D, Hdr, 50),
	
	new(Diag, text('Diagnostico no preciso')),
	send(Diag, font, font(helvetica, bold, 20)),
	send(Diag, colour, colour('#e03131')),
	centrar_horizontal(D, Diag, 110),
	
	wrap_texto('No se pudo determinar un diagnostico preciso con las respuestas ingresadas.', 68, Msg1Envuelto),
	new(Msg1, text(Msg1Envuelto)),
	send(Msg1, font, font(helvetica, roman, 16)),
	send(Msg1, colour, colour('#495057')),
	send(Msg1, format, center),
	centrar_horizontal(D, Msg1, 195),
	
	new(Msg2, text('Por favor, intente nuevamente.')),
	send(Msg2, font, font(helvetica, roman, 16)),
	send(Msg2, colour, colour('#495057')),
	send(Msg2, format, center),
	centrar_horizontal(D, Msg2, 255),
	
	new(BtnMenu, mecaniza_button('Volver al menu', message(@prolog, volver_al_menu, D), 260, 54)),
	send(BtnMenu, font, font(helvetica, bold, 16)),
	estilizar_boton(BtnMenu, '#1e1e1e', '#f1f3f5'),
	centrar_horizontal(D, BtnMenu, 350),
	
	new(Footer, text('MECANIZA\njot1x4k @ 2026')),
	send(Footer, font, font(helvetica, oblique, 12)),
	send(Footer, colour, colour('#868e96')),
	send(Footer, format, center),
	centrar_horizontal(D, Footer, 530).

% Reinicia el motor y retorna a home_view
volver_al_menu(D) :-
	iniciar_diagnostico,
	mostrar_home_view(D).
