:- prolog_load_context(directory, Dir),
	absolute_file_name('src/base.pl', Base, [relative_to(Dir)]),
	absolute_file_name('src/preguntas.pl', Preguntas, [relative_to(Dir)]),
	absolute_file_name('src/diagnostico.pl', Diagnostico, [relative_to(Dir)]),
	absolute_file_name('src/motor.pl', Motor, [relative_to(Dir)]),
	absolute_file_name('src/gui.pl', Gui, [relative_to(Dir)]),
	consult(Base),
	consult(Preguntas),
	consult(Diagnostico),
	consult(Motor),
	consult(Gui).

iniciar :-
	iniciar_gui.

iniciar_consola :-
	iniciar_diagnostico,
	nl,
	writeln('============================================================'),
	writeln('                         MECANIZA                           '),
	writeln('       Diagnostica problemas comunes en segundos!           '),
	writeln('============================================================'),
	nl,
	bucle_consola.

bucle_consola :-
	estado(diagnosticado(Id)),
	!,
	resultado(problema(Id, Nombre, Solucion, Recomendacion, _, _)),
	nl,
	writeln('============================================================'),
	writeln('Diagnostico sugerido por el sistema:'),
	format('  * Problema:              ~w~n', [Nombre]),
	format('  * Solucion recomendada:  ~w~n', [Solucion]),
	format('  * Accion preventiva:     ~w~n', [Recomendacion]),
	writeln('============================================================'),
	nl.

bucle_consola :-
	estado(sin_diagnostico),
	!,
	nl,
	writeln('============================================================'),
	writeln('Diagnostico sugerido por el sistema:'),
	writeln('  Diagnostico no preciso.'),
	writeln('  No se pudo determinar un diagnostico con las respuestas dadas.'),
	writeln('  Por favor, intente nuevamente.'),
	writeln('============================================================'),
	nl.

bucle_consola :-
	pregunta_actual(Pregunta, Texto),
	format('~w [Si/No]: ', [Texto]),
	flush_output,
	read_line_to_string(user_input, EntradaRaw),
	(   EntradaRaw == end_of_file
	->  nl, writeln('Diagnostico finalizado.')
	;   normalize_space(atom(Entrada), EntradaRaw),
	    (   normalizar_respuesta(Entrada, _)
	    ->  responder(Pregunta, Entrada),
	        bucle_consola
	    ;   writeln('Respuesta no valida. Ingrese "Si" o "No".'),
	        bucle_consola
	    )
	).

:- initialization(iniciar).
