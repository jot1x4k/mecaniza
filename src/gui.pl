:- use_module(library(pce)).

% ---------------------------------------------------------------------------
% Estado dinamico de la interfaz para redimensionamiento adaptativo
% ---------------------------------------------------------------------------
:- dynamic vista_actual/1.
:- dynamic redimensionando/0.
:- dynamic ultimo_tamano_renderizado/2.

% ---------------------------------------------------------------------------
% Componentes y utilidades graficas
% ---------------------------------------------------------------------------

% Boton personalizado con dimensiones minimas configurables para mejorar
% la ergonomia tactil/clic en XPCE.
:- pce_begin_class(mecaniza_button, button, "Boton con dimensiones personalizadas y estilos").
variable(min_width, int := 200, both, "Ancho minimo").
variable(min_height, int := 50, both, "Alto minimo").

initialise(B, Name:[name], Message:[code]*, MinW:[int], MinH:[int]) :->
	default(MinW, 200, MW),
	default(MinH, 50, MH),
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

% Obtiene de manera segura las dimensiones de un elemento grafico
item_dimensiones(Item, W, H) :-
	(   catch(get(Item, width, W), _, fail),
	    catch(get(Item, height, H), _, fail),
	    W > 0, H > 0
	->  true
	;   W = 100, H = 30
	).

% Centra un elemento grafico horizontalmente dentro del dialogo en la coordenada Y dada.
centrar_horizontal(D, Item, Y) :-
	get(D, width, DW),
	item_dimensiones(Item, IW, _),
	X is max(20, (DW - IW) // 2),
	send(D, display, Item, point(X, Y)).

% Divide un texto largo en lineas respetando parrafos y palabras.
wrap_texto(Texto, MaxLen, Wrapped) :-
	atomic_list_concat(Paragraphs, '\n', Texto),
	maplist(wrap_parrafo(MaxLen), Paragraphs, WrappedParas),
	atomic_list_concat(WrappedParas, '\n', Wrapped).

wrap_parrafo(MaxLen, Para, Wrapped) :-
	atomic_list_concat(RawWords, ' ', Para),
	delete(RawWords, '', Words),
	(   Words == []
	->  Wrapped = ''
	;   wrap_words(Words, MaxLen, 0, [], Lines),
	    atomic_list_concat(Lines, '\n', Wrapped)
	).

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

% Configuracion de escala y tipografia responsiva segun resolucion
ui_config(DW, DH,
          config(CardW, WrapLen,
                 FontTitle, FontSub, FontHdr, FontDiag,
                 FontQuestion, FontSection, FontBody,
                 FontBtnLg, FontBtnMd,
                 BtnStartW, BtnStartH,
                 BtnExitW, BtnExitH,
                 BtnChoiceW, BtnChoiceH,
                 BtnMenuW, BtnMenuH,
                 ChoiceGap)) :-
	MaxCardW is DW - 80,
	CardW is max(460, min(940, MaxCardW)),
	WrapLen is max(45, min(90, (CardW - 60) // 10)),
	(   (DW < 900 ; DH < 650)
	->  FontTitle    = font(helvetica, bold, 32),
	    FontSub      = font(helvetica, roman, 15),
	    FontHdr      = font(helvetica, bold, 20),
	    FontDiag     = font(helvetica, bold, 18),
	    FontQuestion = font(helvetica, bold, 19),
	    FontSection  = font(helvetica, bold, 14),
	    FontBody     = font(helvetica, roman, 13),
	    FontBtnLg    = font(helvetica, bold, 16),
	    FontBtnMd    = font(helvetica, bold, 14),
	    BtnStartW    = 260, BtnStartH  = 52,
	    BtnExitW     = 180, BtnExitH   = 44,
	    BtnChoiceW   = 170, BtnChoiceH = 52,
	    BtnMenuW     = 240, BtnMenuH   = 48,
	    ChoiceGap    = 30
	;   FontTitle    = font(helvetica, bold, 42),
	    FontSub      = font(helvetica, roman, 18),
	    FontHdr      = font(helvetica, bold, 24),
	    FontDiag     = font(helvetica, bold, 22),
	    FontQuestion = font(helvetica, bold, 23),
	    FontSection  = font(helvetica, bold, 16),
	    FontBody     = font(helvetica, roman, 14),
	    FontBtnLg    = font(helvetica, bold, 17),
	    FontBtnMd    = font(helvetica, bold, 15),
	    BtnStartW    = 300, BtnStartH  = 60,
	    BtnExitW     = 200, BtnExitH   = 48,
	    BtnChoiceW   = 200, BtnChoiceH = 60,
	    BtnMenuW     = 270, BtnMenuH   = 54,
	    ChoiceGap    = 40
	).

% ---------------------------------------------------------------------------
% Inicializacion y gestion del redimensionamiento dinamico
% ---------------------------------------------------------------------------

% Abre o enfoca la ventana principal de la aplicacion
iniciar_gui :-
	(   object(@mecaniza_dialog)
	->  send(@mecaniza_dialog, destroy)
	;   true
	),
	crear_interfaz_diagnostico.

% Crea la ventana principal adaptativa con soporte de resize dinamico
crear_interfaz_diagnostico :-
	new(@mecaniza_dialog, dialog('MECANIZA')),
	send(@mecaniza_dialog, size, size(1100, 700)),
	send(@mecaniza_dialog, resize_message, message(@prolog, al_redimensionar, @mecaniza_dialog, @arg2)),
	mostrar_home_view(@mecaniza_dialog),
	send(@mecaniza_dialog, open_centered).

% Callback ejecutado por XPCE al redimensionar la ventana
al_redimensionar(D, Size) :-
	(   redimensionando
	->  true
	;   (   object(Size), send(Size, instance_of, size)
	    ->  get(Size, width, W),
	        get(Size, height, H)
	    ;   get(D, width, W),
	        get(D, height, H)
	    ),
	    (   ultimo_tamano_renderizado(W, H)
	    ->  true
	    ;   setup_call_cleanup(
	            assertz(redimensionando),
	            (   vista_actual(Vista)
	            ->  retractall(ultimo_tamano_renderizado(_, _)),
	                assertz(ultimo_tamano_renderizado(W, H)),
	                renderizar_vista(D, Vista)
	            ;   true
	            ),
	            retractall(redimensionando)
	        )
	    )
	).

% Renderizador centralizado segun el tipo de vista
renderizar_vista(D, home) :-
	renderizar_home_view(D).
renderizar_vista(D, form) :-
	renderizar_form_view(D).
renderizar_vista(D, diagnostic(Tipo)) :-
	renderizar_diagnostic_view(D, Tipo).

% ---------------------------------------------------------------------------
% Vista 1: home_view
% ---------------------------------------------------------------------------

mostrar_home_view(D) :-
	retractall(vista_actual(_)),
	assertz(vista_actual(home)),
	retractall(ultimo_tamano_renderizado(_, _)),
	get(D, width, W),
	get(D, height, H),
	assertz(ultimo_tamano_renderizado(W, H)),
	renderizar_home_view(D).

renderizar_home_view(D) :-
	send(D, clear),
	get(D, width, DW),
	get(D, height, DH),
	ui_config(DW, DH, config(_CardW, _WrapLen,
	                         FontTitle, FontSub, _FontHdr, _FontDiag,
	                         _FontQuestion, _FontSection, _FontBody,
	                         FontBtnLg, FontBtnMd,
	                         BtnStartW, BtnStartH,
	                         BtnExitW, BtnExitH,
	                         _BtnChoiceW, _BtnChoiceH,
	                         _BtnMenuW, _BtnMenuH,
	                         _ChoiceGap)),

	% Badge / Contexto superior
	new(Badge, text('SISTEMA EXPERTO DE DIAGNOSTICO AUTOMOTRIZ')),
	send(Badge, font, font(helvetica, bold, 12)),
	send(Badge, colour, colour('#1c7ed6')),

	% Titulo principal
	new(Title, text('MECANIZA')),
	send(Title, font, FontTitle),
	send(Title, colour, colour('#1e1e1e')),

	% Subtitulo
	new(Sub, text('Diagnostica problemas comunes en segundos!')),
	send(Sub, font, FontSub),
	send(Sub, colour, colour('#495057')),

	% Boton Iniciar Diagnostico
	new(BtnStart, mecaniza_button('iniciar diagnostico',
	                             message(@prolog, iniciar_flujo_diagnostico, D),
	                             BtnStartW, BtnStartH)),
	send(BtnStart, font, FontBtnLg),
	estilizar_boton(BtnStart, '#1e1e1e', '#f1f3f5'),

	% Boton Salir (rojo segun la especificacion #e03131)
	new(BtnExit, mecaniza_button('salir',
	                            message(D, destroy),
	                            BtnExitW, BtnExitH)),
	send(BtnExit, font, FontBtnMd),
	estilizar_boton(BtnExit, '#e03131', '#fff5f5'),

	% Pie informativo
	new(Footer, text('Mecaniza - Inferencia logica y diagnostico interactivo')),
	send(Footer, font, font(helvetica, roman, 11)),
	send(Footer, colour, colour('#adb5bd')),

	% Calculo dinamico para centrado vertical armonioso
	TotalH is 20 + 55 + 30 + 40 + BtnStartH + 20 + BtnExitH,
	StartY is max(35, (DH - TotalH) // 2 - 15),

	YBadge is StartY,
	YTitle is YBadge + 26,
	YSub   is YTitle + 56,
	YStart is YSub + 48,
	YExit  is YStart + BtnStartH + 18,
	YFoot  is max(YExit + BtnExitH + 20, DH - 35),

	centrar_horizontal(D, Badge, YBadge),
	centrar_horizontal(D, Title, YTitle),
	centrar_horizontal(D, Sub, YSub),
	centrar_horizontal(D, BtnStart, YStart),
	centrar_horizontal(D, BtnExit, YExit),
	centrar_horizontal(D, Footer, YFoot).

% Inicia el diagnostico en el motor y pasa a form_view
iniciar_flujo_diagnostico(D) :-
	iniciar_diagnostico,
	mostrar_form_view(D).

% ---------------------------------------------------------------------------
% Vista 2: form_view
% ---------------------------------------------------------------------------

mostrar_form_view(D) :-
	retractall(vista_actual(_)),
	assertz(vista_actual(form)),
	retractall(ultimo_tamano_renderizado(_, _)),
	get(D, width, W),
	get(D, height, H),
	assertz(ultimo_tamano_renderizado(W, H)),
	renderizar_form_view(D).

renderizar_form_view(D) :-
	send(D, clear),
	get(D, width, DW),
	get(D, height, DH),
	ui_config(DW, DH, config(_CardW, WrapLen,
	                         _FontTitle, _FontSub, _FontHdr, _FontDiag,
	                         FontQuestion, _FontSection, _FontBody,
	                         FontBtnLg, _FontBtnMd,
	                         _BtnStartW, _BtnStartH,
	                         _BtnExitW, _BtnExitH,
	                         BtnChoiceW, BtnChoiceH,
	                         _BtnMenuW, _BtnMenuH,
	                         ChoiceGap)),

	(   pregunta_actual(Pregunta, Texto)
	->  % Indicador de estado superior
	    new(TopLbl, text('ASISTENTE DE DIAGNOSTICO - RESPONDA LA PREGUNTA')),
	    send(TopLbl, font, font(helvetica, bold, 12)),
	    send(TopLbl, colour, colour('#868e96')),

	    % Pregunta envuelta segun la escala actual
	    wrap_texto(Texto, WrapLen, TextoEnvuelto),
	    new(PregLbl, text(TextoEnvuelto)),
	    send(PregLbl, font, FontQuestion),
	    send(PregLbl, colour, colour('#212529')),
	    send(PregLbl, format, center),

	    % Boton Si (verde #2f9e44)
	    new(BtnSi, mecaniza_button('Si',
	                               message(@prolog, responder_y_avanzar, D, Pregunta, si),
	                               BtnChoiceW, BtnChoiceH)),
	    send(BtnSi, font, FontBtnLg),
	    estilizar_boton(BtnSi, '#2f9e44', '#ebfbee'),

	    % Boton No (rojo #e03131)
	    new(BtnNo, mecaniza_button('No',
	                               message(@prolog, responder_y_avanzar, D, Pregunta, no),
	                               BtnChoiceW, BtnChoiceH)),
	    send(BtnNo, font, FontBtnLg),
	    estilizar_boton(BtnNo, '#e03131', '#fff5f5'),

	    % Boton para abortar y volver al menu en cualquier momento
	    new(BtnReset, mecaniza_button('Cancelar y volver al menu',
	                                  message(@prolog, volver_al_menu, D),
	                                  230, 40)),
	    send(BtnReset, font, font(helvetica, roman, 13)),
	    estilizar_boton(BtnReset, '#495057', '#f8f9fa'),

	    % Medidas dinamicas para centrado vertical y espaciado perfecto
	    item_dimensiones(PregLbl, _PregW, PregH),
	    TotalH is 20 + PregH + 35 + BtnChoiceH + 30 + 40,
	    StartY is max(35, (DH - TotalH) // 2 - 10),

	    YTop is StartY,
	    YPreg is YTop + 28,
	    YBtns is YPreg + PregH + 36,
	    YReset is YBtns + BtnChoiceH + 28,

	    centrar_horizontal(D, TopLbl, YTop),
	    centrar_horizontal(D, PregLbl, YPreg),

	    % Posicionamiento horizontal simetrico de los botones
	    TotalBtnsW is (BtnChoiceW * 2) + ChoiceGap,
	    XSi is max(20, (DW - TotalBtnsW) // 2),
	    XNo is XSi + BtnChoiceW + ChoiceGap,
	    send(D, display, BtnSi, point(XSi, YBtns)),
	    send(D, display, BtnNo, point(XNo, YBtns)),

	    centrar_horizontal(D, BtnReset, YReset)
	;   volver_al_menu(D)
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

mostrar_diagnostic_view(D, Tipo) :-
	retractall(vista_actual(_)),
	assertz(vista_actual(diagnostic(Tipo))),
	retractall(ultimo_tamano_renderizado(_, _)),
	get(D, width, W),
	get(D, height, H),
	assertz(ultimo_tamano_renderizado(W, H)),
	renderizar_diagnostic_view(D, Tipo).

renderizar_diagnostic_view(D, exito(Nombre, Solucion, Recomendacion)) :-
	send(D, clear),
	get(D, width, DW),
	get(D, height, DH),
	ui_config(DW, DH, config(CardW, WrapLen,
	                         _FontTitle, _FontSub, FontHdr, FontDiag,
	                         _FontQuestion, FontSection, FontBody,
	                         FontBtnLg, _FontBtnMd,
	                         _BtnStartW, _BtnStartH,
	                         _BtnExitW, _BtnExitH,
	                         _BtnChoiceW, _BtnChoiceH,
	                         BtnMenuW, BtnMenuH,
	                         _ChoiceGap)),

	% Encabezado
	new(Hdr, text('Diagnostico sugerido por el sistema:')),
	send(Hdr, font, FontHdr),
	send(Hdr, colour, colour('#1e1e1e')),

	% Titulo del diagnostico destacado
	new(Diag, text(Nombre)),
	send(Diag, font, FontDiag),
	send(Diag, colour, colour('#2b8a3e')),

	% Seccion de solucion
	new(LblSol, text('Solucion recomendada:')),
	send(LblSol, font, FontSection),
	send(LblSol, colour, colour('#212529')),

	wrap_texto(Solucion, WrapLen, SolEnvuelto),
	new(Sol, text(SolEnvuelto)),
	send(Sol, font, FontBody),
	send(Sol, colour, colour('#343a40')),

	% Seccion preventiva
	new(LblRec, text('Accion preventiva:')),
	send(LblRec, font, FontSection),
	send(LblRec, colour, colour('#212529')),

	wrap_texto(Recomendacion, WrapLen, RecEnvuelto),
	new(Rec, text(RecEnvuelto)),
	send(Rec, font, FontBody),
	send(Rec, colour, colour('#343a40')),

	% Boton Volver al menu principal
	new(BtnMenu, mecaniza_button('Volver al menu',
	                             message(@prolog, volver_al_menu, D),
	                             BtnMenuW, BtnMenuH)),
	send(BtnMenu, font, FontBtnLg),
	estilizar_boton(BtnMenu, '#1e1e1e', '#f1f3f5'),

	% Medidas de cada elemento para flujo vertical reactivo (evita solapamientos)
	item_dimensiones(Hdr, _, HdrH),
	item_dimensiones(Diag, _, DiagH),
	item_dimensiones(LblSol, _, LSH),
	item_dimensiones(Sol, _, SolH),
	item_dimensiones(LblRec, _, LRH),
	item_dimensiones(Rec, _, RecH),

	TotalH is HdrH + 12 + DiagH + 22 + LSH + 6 + SolH + 18 + LRH + 6 + RecH + 26 + BtnMenuH,
	StartY is max(30, (DH - TotalH) // 2 - 10),

	% Coordenada horizontal de los bloques de contenido
	ContentX is max(30, (DW - CardW) // 2),

	YHdr is StartY,
	YDiag is YHdr + HdrH + 12,
	YLblSol is YDiag + DiagH + 22,
	YSol is YLblSol + LSH + 6,
	YLblRec is YSol + SolH + 18,
	YRec is YLblRec + LRH + 6,
	YBtn is YRec + RecH + 26,

	centrar_horizontal(D, Hdr, YHdr),
	centrar_horizontal(D, Diag, YDiag),
	send(D, display, LblSol, point(ContentX, YLblSol)),
	send(D, display, Sol, point(ContentX, YSol)),
	send(D, display, LblRec, point(ContentX, YLblRec)),
	send(D, display, Rec, point(ContentX, YRec)),
	centrar_horizontal(D, BtnMenu, YBtn).

renderizar_diagnostic_view(D, sin_diagnostico) :-
	send(D, clear),
	get(D, width, DW),
	get(D, height, DH),
	ui_config(DW, DH, config(_CardW, WrapLen,
	                         _FontTitle, _FontSub, FontHdr, FontDiag,
	                         _FontQuestion, FontSection, FontBody,
	                         FontBtnLg, _FontBtnMd,
	                         _BtnStartW, _BtnStartH,
	                         _BtnExitW, _BtnExitH,
	                         _BtnChoiceW, _BtnChoiceH,
	                         BtnMenuW, BtnMenuH,
	                         _ChoiceGap)),

	new(Hdr, text('Diagnostico sugerido por el sistema:')),
	send(Hdr, font, FontHdr),
	send(Hdr, colour, colour('#1e1e1e')),

	new(Diag, text('Diagnostico no preciso')),
	send(Diag, font, FontDiag),
	send(Diag, colour, colour('#e03131')),

	wrap_texto('No se pudo determinar un diagnostico preciso con las respuestas ingresadas.',
	           WrapLen, Msg1Envuelto),
	new(Msg1, text(Msg1Envuelto)),
	send(Msg1, font, FontSection),
	send(Msg1, colour, colour('#495057')),
	send(Msg1, format, center),

	new(Msg2, text('Por favor, intente nuevamente desde el menu principal.')),
	send(Msg2, font, FontBody),
	send(Msg2, colour, colour('#6c757d')),
	send(Msg2, format, center),

	new(BtnMenu, mecaniza_button('Volver al menu',
	                             message(@prolog, volver_al_menu, D),
	                             BtnMenuW, BtnMenuH)),
	send(BtnMenu, font, FontBtnLg),
	estilizar_boton(BtnMenu, '#1e1e1e', '#f1f3f5'),

	item_dimensiones(Hdr, _, HdrH),
	item_dimensiones(Diag, _, DiagH),
	item_dimensiones(Msg1, _, Msg1H),
	item_dimensiones(Msg2, _, Msg2H),

	TotalH is HdrH + 14 + DiagH + 26 + Msg1H + 12 + Msg2H + 30 + BtnMenuH,
	StartY is max(35, (DH - TotalH) // 2 - 10),

	YHdr is StartY,
	YDiag is YHdr + HdrH + 14,
	YMsg1 is YDiag + DiagH + 26,
	YMsg2 is YMsg1 + Msg1H + 12,
	YBtn is YMsg2 + Msg2H + 30,

	centrar_horizontal(D, Hdr, YHdr),
	centrar_horizontal(D, Diag, YDiag),
	centrar_horizontal(D, Msg1, YMsg1),
	centrar_horizontal(D, Msg2, YMsg2),
	centrar_horizontal(D, BtnMenu, YBtn).

% Reinicia el motor y retorna a home_view
volver_al_menu(D) :-
	iniciar_diagnostico,
	mostrar_home_view(D).
