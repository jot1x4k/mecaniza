% ===========================================================================
% MECANIZA - Base de Conocimiento Automotriz
%
% Estructura:
%   problema_info(Id, Nombre, Solucion, Recomendacion, Categoria, Asset)
% ===========================================================================

problema_info(
	bateria_descargada,
	'Bateria descargada o bornes sulfatados',
	'Recarga la bateria con un cargador externo o conecta cables de puente desde otro vehiculo. Recuerda conectar primero el borne positivo (+) y luego el negativo o tierra (-).',
	'Revisa la bateria si supera los 3 anos de uso, verifica que los bornes esten limpios y libres de sulfato y comprueba que el alternador este cargando.',
	cat_electrico,
	'assets/bateria_descargada.png'
).

problema_info(
	tanque_combustible_vacio,
	'Tanque de combustible vacio',
	'Reposta combustible de inmediato. Si te has quedado detenido en la via, adquiere combustible en una estacion de servicio cercana usando un bidon homologado.',
	'Evita circular con el indicador en nivel de reserva para impedir que la bomba de combustible succione impurezas o se sobrecaliente.',
	cat_combustible,
	'assets/tanque_combustible_vacio.png'
).

% Compatibilidad con la ortografia anterior
problema_info(tanque_comustible_vacio, Nombre, Solucion, Recomendacion, Categoria, Asset) :-
	problema_info(tanque_combustible_vacio, Nombre, Solucion, Recomendacion, Categoria, Asset).

problema_info(
	alternador_defectuoso,
	'Alternador defectuoso o correa rota',
	'Lleva el vehiculo a un taller electromecanico para verificar el estado del alternador, su regulador de voltaje y la tension de la correa de accesorios.',
	'Verifica la tension de la correa de accesorios periodicamente y mide la tension de carga con multimetro (debe marcar entre 13.8V y 14.4V en marcha).',
	cat_electrico,
	'assets/alternador_defectuoso.png'
).

problema_info(
	motor_sobrecalentado,
	'Motor sobrecalentado (falla en el sistema de refrigeracion)',
	'Deten el vehiculo de forma segura y apaga el motor de inmediato. Espera al menos 30 minutos a que enfrie y revisa el nivel de refrigerante en el deposito de expansion.',
	'Inspecciona habitualmente el nivel de liquido refrigerante y el estado de mangueras, radiador, termostato y electroventilador para prevenir fugas.',
	cat_refrigeracion,
	'assets/motor_sobrecalentado.png'
).

problema_info(
	nivel_aceite_bajo,
	'Nivel critico o falta de presion de aceite',
	'Apaga el motor de inmediato para evitar daños mecanicos irreversibles. Mide el nivel con la varilla y añade aceite con la viscosidad recomendada por el fabricante.',
	'Revisa el nivel de aceite cada 1.000 kilometros con el motor en frio y realiza el cambio de aceite y filtro rigurosamente segun la pauta de mantenimiento.',
	cat_lubricacion,
	'assets/nivel_aceite_bajo.png'
).

problema_info(
	fuga_liquido_frenos,
	'Fuga o nivel bajo en el liquido de frenos',
	'No conduzcas el vehiculo si el pedal se hunde. Rellena el deposito con el liquido de frenos recomendado (DOT 3 o DOT 4) y revisa fugas en mordazas o mangueras.',
	'Comprueba el deposito de liquido de frenos mensualmente y sustituye todo el fluido cada dos anos para evitar perdida de punto de ebullicion por humedad.',
	cat_frenos,
	'assets/fuga_liquido_frenos.png'
).

problema_info(
	frenos_desgastados,
	'Pastillas o discos de freno desgastados',
	'Acude al taller mecanico para sustituir las pastillas de freno y verificar si los discos de freno requieren rectificacion o cambio por grosor minimo.',
	'Inspecciona las pastillas y discos cada 10.000 a 15.000 km y ante cualquier sonido metalico o vibracion al frenar acude a una revision preventiva.',
	cat_frenos,
	'assets/frenos_desgastados.png'
).

problema_info(
	sensor_mal_calibrado,
	'Sensores de inyeccion o motor defectuosos (Check Engine)',
	'Conecta un escaner automotriz al puerto OBD-II para diagnosticar el codigo de falla especifico (sensor MAF, MAP, sensor de oxigeno o posicion de cigueñal).',
	'Limpia los sensores y el cuerpo de aceleracion durante la afinacion periodica y evita circular con el testigo Check Engine encendido de forma prolongada.',
	cat_electronico,
	'assets/sensor_mal_calibrados.png'
).

problema_info(
	bujias_defectuosas,
	'Bujias o bobinas de encendido deterioradas',
	'Inspecciona los electrodos de las bujias y reemplaza el juego completo de bujias de encendido, revisando ademas el cableado y las bobinas de encendido.',
	'Cambia las bujias segun el kilometraje estipulado por el fabricante (cada 30.000 km para convencionales de cobre o hasta 100.000 km para bujias de iridio).',
	cat_encendido,
	'assets/bujias_defectuosas.png'
).

problema_info(
	falla_embrague,
	'Desgaste del disco o sistema de embrague',
	'Lleva el vehiculo al taller para ajustar el juego libre del pedal o reemplazar el kit completo de embrague (disco, prensa y balinera de empuje).',
	'Evita conducir descansando el pie sobre el pedal de embrague y no retengas el automovil en pendientes empinadas utilizando unicamente el embrague.',
	cat_transmision,
	'assets/falla_embrague.png'
).

problema_info(
	presion_neumaticos_baja,
	'Presion baja o pinchadura en neumaticos',
	'Inspecciona visualmente las ruedas en busca de objetos incrustados y calibra la presion de aire en una estacion de servicio segun la etiqueta de la puerta.',
	'Calibra la presion de las cuatro ruedas y la rueda de repuesto cada dos semanas, preferiblemente con los neumaticos en frio.',
	cat_neumaticos,
	'assets/presion_neumaticos_baja.png'
).

problema_info(
	filtro_aire_obstruido,
	'Filtro de aire del motor saturado de suciedad',
	'Abre la caja del filtro de aire y sustituye el filtro por uno nuevo con las dimensiones exactas para restablecer el flujo correcto de aire al motor.',
	'Revisa el filtro de aire cada 10.000 kilometros y sustituyelo con mayor frecuencia si conduces frecuentemente por caminos con polvo o vias sin pavimentar.',
	cat_admision,
	'assets/filtro_aire_obstruido.png'
).
