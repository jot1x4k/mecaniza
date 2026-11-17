
problema_info(
	bateria_descargada,
	'Bateria descargada o cables sueltos',
	'Carga la bateria con un cargador o usa cables para arrancar con otro auto (conecta primero el cable positivo + y luego el negativo -).',
	'Revisa que los cables de la bateria esten bien apretados y limpios, y cambiala si tiene mas de 3 anos.',
	cat_electrico,
	'assets/bateria_descargada.png'
).

problema_info(
	motor_arranque_defectuoso,
	'Falla del motor de arranque (marcha)',
	'Da unos golpes suaves con una herramienta liviana en el motor de arranque para intentar liberarlo y lleva el auto a un taller electrico.',
	'Hazle mantenimiento al motor de arranque cada 80.000 km y revisa el rele de encendido.',
	cat_electrico,
	'assets/motor_arranque_defectuoso.png'
).

problema_info(
	alternador_defectuoso,
	'Alternador en mal estado o correa rota',
	'Apaga la radio y el aire acondicionado para no gastar mas bateria y ve a un taller a revisar el alternador o cambiar la correa.',
	'Revisa seguido la correa del alternador y su voltaje con un medidor; debe marcar entre 13.8V y 14.4V con el motor encendido.',
	cat_electrico,
	'assets/alternador_defectuoso.png'
).

problema_info(
	tanque_combustible_vacio,
	'Tanque de combustible vacio',
	'Carga combustible de inmediato. Si el auto se quedo en la via, consigue combustible en una estacion usando un bidon adecuado.',
	'No manejes siempre en reserva, para que la bomba de combustible no aspire suciedad ni se caliente.',
	cat_combustible,
	'assets/tanque_combustible_vacio.png'
).

problema_info(tanque_comustible_vacio, Nombre, Solucion, Recomendacion, Categoria, Asset) :-
	problema_info(tanque_combustible_vacio, Nombre, Solucion, Recomendacion, Categoria, Asset).

problema_info(
	motor_sobrecalentado,
	'Motor demasiado caliente',
	'Deten el auto en un lugar seguro y apaga el motor de inmediato. Espera al menos 30 minutos a que enfrie y revisa el nivel del liquido refrigerante.',
	'Revisa seguido el termostato, el ventilador del radiador y el radiador, para evitar que el motor se caliente demasiado y se danen sus piezas internas.',
	cat_refrigeracion,
	'assets/motor_sobrecalentado.png'
).

problema_info(
	radiador_con_fuga,
	'Fuga en el radiador o en una manguera',
	'No abras el tapon del radiador si esta caliente. Espera a que enfrie, busca por donde sale el liquido y rellena con refrigerante.',
	'Revisa las mangueras y abrazaderas cada 20.000 km para encontrar rajaduras o partes hinchadas.',
	cat_refrigeracion,
	'assets/radiador_con_fuga.png'
).

problema_info(
	nivel_aceite_bajo,
	'Falta de aceite o baja presion de aceite',
	'Apaga el motor de inmediato para no danarlo. Saca la varilla, revisa el nivel y agrega aceite del tipo recomendado.',
	'Revisa el nivel de aceite cada 1.000 km con el auto en un lugar plano y el motor frio, y cambia el aceite y el filtro segun el manual.',
	cat_lubricacion,
	'assets/nivel_aceite_bajo.png'
).

problema_info(
	desgaste_arbol_levas,
	'Falta de lubricacion en las piezas internas del motor',
	'Lleva el auto cuanto antes a un taller para revisar el nivel y la presion del aceite, limpiar los conductos y ver si hay piezas desgastadas.',
	'Usa siempre el aceite que recomienda el fabricante, con el tipo exacto, para que el motor se lubrique bien.',
	cat_lubricacion,
	'assets/desgaste_arbol_levas.png'
).

problema_info(
	fuga_liquido_frenos,
	'Fuga de liquido de frenos',
	'No manejes si el pedal del freno se va al fondo. Revisa el deposito de liquido de frenos, agrega DOT 3 o DOT 4 y lleva el auto en grua al taller.',
	'Revisa las mangueras y piezas de los frenos cada vez que cambies las pastillas, y cambia el liquido de frenos cada 2 anos.',
	cat_frenos,
	'assets/fuga_liquido_frenos.png'
).

problema_info(
	frenos_desgastados,
	'Pastillas de freno gastadas',
	'Ve al taller para cambiar las pastillas de freno cuanto antes y revisar si los discos se danaron.',
	'Revisa el grosor de las pastillas cada 10.000 km y cambialas antes de que queden con menos de 3 mm.',
	cat_frenos,
	'assets/frenos_desgastados.png'
).

problema_info(
	discos_freno_alabeados,
	'Discos de freno deformados',
	'Lleva el auto a un taller de frenos para medir si los discos estan deformados y decidir si se rectifican o se cambian.',
	'No laves el auto ni mojes los frenos con agua fria justo despues de frenar fuerte varias veces en una bajada.',
	cat_frenos,
	'assets/discos_freno_alabeados.png'
).

problema_info(
	sensor_mal_calibrado,
	'Aviso del motor encendido (Check Engine)',
	'Conecta un escaner en la entrada OBD-II del auto para leer el codigo de falla y saber que sensor esta fallando.',
	'Haz revisiones electronicas preventivas y limpia los sensores y conectores para evitar lecturas equivocadas de la computadora.',
	cat_electronico,
	'assets/sensor_mal_calibrados.png'
).

problema_info(
	inyectores_sucios,
	'Inyectores sucios o suciedad en la entrada de aire',
	'Agrega un limpiador de inyectores en el combustible o lleva los inyectores a un taller para limpiarlos y calibrarlos.',
	'Cambia el filtro de gasolina cuando corresponda y limpia la pieza por donde entra el aire (cuerpo de aceleracion) cada 30.000 km.',
	cat_combustible,
	'assets/inyectores_sucios.png'
).

problema_info(
	bujias_defectuosas,
	'Bujias gastadas o en mal estado',
	'Saca las bujias, revisa la separacion de la punta y cambia las cuatro por bujias nuevas del tipo que indica el manual.',
	'Cambia las bujias segun el kilometraje recomendado: cada 30.000 km las de cobre o hasta 80.000 km las de iridio.',
	cat_encendido,
	'assets/bujias_defectuosas.png'
).

problema_info(
	bobina_encendido_defectuosa,
	'Bobina de encendido o cables de bujia en mal estado',
	'Revisa con un medidor la bobina de encendido y cambia la del cilindro que esta fallando.',
	'Revisa que las bobinas y los cables de las bujias no esten rotos ni humedos, para evitar que se pierda la chispa.',
	cat_encendido,
	'assets/bobina_encendido_defectuosa.png'
).

problema_info(
	falla_embrague,
	'Embrague gastado',
	'Lleva el auto a un taller para cambiar el kit completo de embrague (disco, plato y rodamiento).',
	'No dejes el pie apoyado en el pedal del embrague mientras manejas ni lo mantengas pisado cuando estes detenido en un semaforo.',
	cat_transmision,
	'assets/falla_embrague.png'
).

problema_info(
	sincronizadores_transmision,
	'Piezas de la caja de cambios gastadas',
	'Revisa el nivel y el estado del aceite de la caja de cambios y ve al taller para ajustar la palanca o revisar las piezas internas.',
	'Cambia el aceite de la caja de cambios cuando lo indique el fabricante y cambia de marcha con suavidad.',
	cat_transmision,
	'assets/sincronizadores_transmision.png'
).

problema_info(
	presion_neumaticos_baja,
	'Llanta baja de aire o pinchada',
	'Revisa las ruedas por si tienen clavos o estan deformadas y calibralas con la presion que indica la etiqueta del auto.',
	'Revisa la presion de las cuatro llantas y la de repuesto cada dos semanas, preferiblemente con las ruedas frias.',
	cat_neumaticos,
	'assets/presion_neumaticos_baja.png'
).

problema_info(
	direccion_asistida_defectuosa,
	'Falla de la direccion asistida o falta de liquido',
	'Revisa el deposito del liquido de direccion, agregalo si esta bajo y busca fugas en la bomba o en la cremallera.',
	'Revisa seguido el estado del liquido de direccion y que la correa de la bomba este bien tensa.',
	cat_mecanico,
	'assets/direccion_asistida_defectuosa.png'
).

problema_info(
	filtro_aire_obstruido,
	'Filtro de aire muy sucio',
	'Abre la caja del filtro y cambia el filtro de aire por uno nuevo para que el motor reciba mas aire.',
	'Revisa el filtro de aire cada 10.000 km y cambialo mas seguido si manejas por caminos de tierra o con mucho polvo.',
	cat_admision,
	'assets/filtro_aire_obstruido.png'
).

problema_info(
	desgaste_anillos_motor,
	'Anillos del piston o sellos de valvula desgastados',
	'Lleva el auto a un taller para medir la compresion de los cilindros y saber si los anillos o los sellos estan sellando bien.',
	'No alargues los cambios de aceite y filtro, para que la suciedad no desgaste las paredes de los cilindros.',
	cat_mecanico,
	'assets/desgaste_anillos_motor.png'
).
