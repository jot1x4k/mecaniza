% ===========================================================================
% MECANIZA - Interfaz Grafica de Usuario (XPCE)
%
% Implementa las vistas segun la documentacion y prototipos:
%   - home_view: Pantalla principal de bienvenida y acceso al diagnostico.
%   - form_view: Presentacion iterativa de preguntas con opciones Si / No.
%   - diagnostic_view: Presentacion del diagnostico final o flujo alternativo.
% ===========================================================================

:- use_module(library(pce)).

% Abre o enfoca la ventana principal de la aplicacion
iniciar_gui :-
	(   object(@mecaniza_dialog)
	->  send(@mecaniza_dialog, open_centered)
	;   crear_interfaz_diagnostico
	).

% Crea la ventana principal y presenta home_view
crear_interfaz_diagnostico :-
	new(D, dialog('MECANIZA')),
	send(D, name, mecaniza_dialog),
	send(D, size, size(640, 420)),
	mostrar_home_view(D),
	send(D, open_centered).

% ---------------------------------------------------------------------------
% Vista 1: home_view
% ---------------------------------------------------------------------------
mostrar_home_view(D) :-
	send(D, clear),
	send(D, gap, size(20, 16)),
	
	% Espacio superior
	send(D, append, label(gap1, '')),
	
	% Titulo
	new(Title, label(title, 'MECANIZA')),
	send(Title, font, font(helvetica, bold, 30)),
	send(D, append, Title),
	
	% Subtitulo
	new(Sub, label(sub, 'Diagnostica problemas comunes en segundos!')),
	send(Sub, font, font(helvetica, roman, 14)),
	send(D, append, Sub),
	
	send(D, append, label(gap2, '')),
	
	% Boton Iniciar Diagnostico
	new(BtnStart, button('iniciar diagnostico', message(@prolog, iniciar_flujo_diagnostico, D))),
	send(BtnStart, font, font(helvetica, bold, 13)),
	send(D, append, BtnStart),
	
	% Boton Salir
	new(BtnExit, button('salir', message(D, destroy))),
	send(BtnExit, font, font(helvetica, roman, 12)),
	send(D, append, BtnExit).

% Inicia el diagnostico en el motor y pasa a form_view
iniciar_flujo_diagnostico(D) :-
	iniciar_diagnostico,
	mostrar_form_view(D).

% ---------------------------------------------------------------------------
% Vista 2: form_view
% ---------------------------------------------------------------------------
mostrar_form_view(D) :-
	send(D, clear),
	send(D, gap, size(20, 16)),
	
	(   pregunta_actual(Pregunta, Texto)
	->  send(D, append, label(gap1, '')),
	    new(PregLbl, label(pregunta, Texto)),
	    send(PregLbl, font, font(helvetica, bold, 15)),
	    send(D, append, PregLbl),
	    send(D, append, label(gap2, '')),
	    
	    % Botones Si y No
	    new(BtnSi, button('Si', message(@prolog, responder_y_avanzar, D, Pregunta, si))),
	    send(BtnSi, font, font(helvetica, bold, 14)),
	    send(D, append, BtnSi),
	    
	    new(BtnNo, button('No', message(@prolog, responder_y_avanzar, D, Pregunta, no))),
	    send(BtnNo, font, font(helvetica, bold, 14)),
	    send(D, append, BtnNo, right),
	    
	    send(D, append, label(gap3, '')),
	    new(Footer, label(footer, 'MECANIZA\njot1x4k @ 2026')),
	    send(Footer, font, font(helvetica, oblique, 10)),
	    send(D, append, Footer)
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
	send(D, gap, size(20, 14)),
	
	send(D, append, label(gap1, '')),
	new(Hdr, label(hdr, 'Diagnostico sugerido por el sistema:')),
	send(Hdr, font, font(helvetica, bold, 18)),
	send(D, append, Hdr),
	
	send(D, append, label(gap2, '')),
	new(Diag, label(diag, Nombre)),
	send(Diag, font, font(helvetica, bold, 16)),
	send(D, append, Diag),
	
	send(D, append, label(gap3, '')),
	new(LblSol, label(sol_title, 'Solucion recomendada:')),
	send(LblSol, font, font(helvetica, bold, 12)),
	send(D, append, LblSol),
	new(Sol, label(sol, Solucion)),
	send(Sol, font, font(helvetica, roman, 12)),
	send(D, append, Sol),
	
	new(LblRec, label(rec_title, 'Accion preventiva:')),
	send(LblRec, font, font(helvetica, bold, 12)),
	send(D, append, LblRec),
	new(Rec, label(rec, Recomendacion)),
	send(Rec, font, font(helvetica, roman, 12)),
	send(D, append, Rec),
	
	send(D, append, label(gap4, '')),
	new(BtnMenu, button('Volver al menu', message(@prolog, volver_al_menu, D))),
	send(BtnMenu, font, font(helvetica, bold, 13)),
	send(D, append, BtnMenu),
	
	new(Footer, label(footer, 'MECANIZA\njot1x4k @ 2026')),
	send(Footer, font, font(helvetica, oblique, 10)),
	send(D, append, Footer).

mostrar_diagnostic_view(D, sin_diagnostico) :-
	send(D, clear),
	send(D, gap, size(20, 14)),
	
	send(D, append, label(gap1, '')),
	new(Hdr, label(hdr, 'Diagnostico sugerido por el sistema:')),
	send(Hdr, font, font(helvetica, bold, 18)),
	send(D, append, Hdr),
	
	send(D, append, label(gap2, '')),
	new(Diag, label(diag, 'Diagnostico no preciso')),
	send(Diag, font, font(helvetica, bold, 16)),
	send(D, append, Diag),
	
	send(D, append, label(gap3, '')),
	new(Msg1, label(msg1, 'No se pudo determinar un diagnostico preciso con las respuestas ingresadas.')),
	send(Msg1, font, font(helvetica, roman, 12)),
	send(D, append, Msg1),
	new(Msg2, label(msg2, 'Por favor, intente nuevamente.')),
	send(Msg2, font, font(helvetica, roman, 12)),
	send(D, append, Msg2),
	
	send(D, append, label(gap4, '')),
	new(BtnMenu, button('Volver al menu', message(@prolog, volver_al_menu, D))),
	send(BtnMenu, font, font(helvetica, bold, 13)),
	send(D, append, BtnMenu),
	
	new(Footer, label(footer, 'MECANIZA\njot1x4k @ 2026')),
	send(Footer, font, font(helvetica, oblique, 10)),
	send(D, append, Footer).

% Reinicia el motor y retorna a home_view
volver_al_menu(D) :-
	iniciar_diagnostico,
	mostrar_home_view(D).
