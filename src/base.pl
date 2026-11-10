
problema_info(
	bateria_descargada,
	'Bateria descargada o bornes desconectados',
	'Recarga la bateria con un cargador externo o utiliza cables de puente desde otro vehiculo (conectando primero el polo positivo + y luego negativo -).',
	'Comprueba que los bornes esten apretados y limpios de sulfato, y reemplaza la bateria si ha superado los 3 anos de vida util.',
	cat_electrico,
	'assets/bateria_descargada.png'
).

problema_info(
	motor_arranque_defectuoso,
	'Motor o solenoide de arranque averiado',
	'Golpea suavemente el cuerpo del motor de arranque con una herramienta ligera para destrabar el solenoide y acude de inmediato a un taller electrico.',
	'Realiza mantenimiento preventivo al motor de arranque cada 80.000 km, cambiando carbones, bujes y revisando el rele de encendido.',
	cat_electrico,
	'assets/motor_arranque_defectuoso.png'
).

problema_info(
	alternador_defectuoso,
	'Alternador defectuoso o correa de accesorios rota',
	'Deten el uso de accesorios electricos (radio, aire acondicionado) y dirijete a un taller para reparar el alternador o sustituir la correa.',
	'Verifica periodicamente la tension de la correa del alternador y mide el voltaje con multimetro (debe marcar entre 13.8V y 14.4V en marcha).',
	cat_electrico,
	'assets/alternador_defectuoso.png'
).

problema_info(
	tanque_combustible_vacio,
	'Tanque de combustible vacio',
	'Reposta combustible de inmediato. Si el vehiculo se apago en la via, adquiere combustible en una estacion de servicio usando un bidon homologado.',
	'Evita circular con el indicador en nivel de reserva para impedir que la bomba de combustible succione impurezas o se sobrecaliente.',
	cat_combustible,
	'assets/tanque_combustible_vacio.png'
).

problema_info(tanque_comustible_vacio, Nombre, Solucion, Recomendacion, Categoria, Asset) :-
	problema_info(tanque_combustible_vacio, Nombre, Solucion, Recomendacion, Categoria, Asset).

problema_info(
	motor_sobrecalentado,
	'Motor sobrecalentado (temperatura critica)',
	'Deten el vehiculo de inmediato en lugar seguro y apaga el motor. Espera al menos 30 minutos a que enfrie y revisa el nivel de liquido refrigerante.',
	'Monitorea el termostato, el electroventilador y el estado del radiador para evitar sobrecalentamientos que puedan danar la junta de culata.',
	cat_refrigeracion,
	'assets/motor_sobrecalentado.png'
).

problema_info(
	radiador_con_fuga,
	'Fuga en el radiador o rotura de manguera de refrigerante',
	'No abras el tapon del radiador caliente. Espera a que el motor enfrie, localiza la fuga en mangueras o radiador y rellena con refrigerante.',
	'Inspecciona las abrazaderas y mangueras de refrigeracion en busca de fisuras o hinchazon cada 20.000 kilometros.',
	cat_refrigeracion,
	'assets/radiador_con_fuga.png'
).

problema_info(
	nivel_aceite_bajo,
	'Nivel critico o falta de presion de aceite del motor',
	'Apaga el motor de inmediato para evitar dano mecanico severo. Extrae la varilla de medicion, comprueba el nivel y anade aceite con la viscosidad recomendada.',
	'Revisa el nivel de aceite cada 1.000 km con el vehiculo en plano y en frio, y efectua el cambio de aceite y filtro segun el manual.',
	cat_lubricacion,
	'assets/nivel_aceite_bajo.png'
).

problema_info(
	desgaste_arbol_levas,
	'Falta de lubricacion en balancines o taques hidraulicos',
	'Revisa con urgencia el nivel y presion de aceite en un taller mecanico para limpiar conductos de lubricacion y evaluar desgaste de los taques.',
	'Utiliza siempre aceite homologado con la viscosidad exacta que indica el fabricante para asegurar correcta presion en la culata.',
	cat_lubricacion,
	'assets/desgaste_arbol_levas.png'
).

problema_info(
	fuga_liquido_frenos,
	'Fuga o perdida de presion hidraulica en frenos',
	'No circules con el vehiculo si el pedal se va al fondo. Revisa el deposito de frenos, anade liquido DOT 3 o DOT 4 y traslada el vehiculo en grua al taller.',
	'Inspecciona mangueras de freno y bombines en cada cambio de pastillas y cambia todo el fluido cada 2 anos.',
	cat_frenos,
	'assets/fuga_liquido_frenos.png'
).

problema_info(
	frenos_desgastados,
	'Pastillas de freno desgastadas al limite',
	'Acude al taller para sustituir inmediatamente las pastillas de freno y verificar si los discos sufrieron danos por rozamiento de metal con metal.',
	'Revisa el grosor de las pastillas de freno cada 10.000 km y sustituyelas antes de que el grosor del material de friccion sea inferior a 3 mm.',
	cat_frenos,
	'assets/frenos_desgastados.png'
).

problema_info(
	discos_freno_alabeados,
	'Discos de freno alabeados o deformados',
	'Lleva el automovil a un taller de frenos para medir el alabeo de los discos con reloj comparador y proceder a su rectificacion o sustitucion.',
	'Evita lavar el vehiculo o mojar los frenos con agua fria inmediatamente despues de frenadas intensas y continuas en descensos.',
	cat_frenos,
	'assets/discos_freno_alabeados.png'
).

problema_info(
	sensor_mal_calibrado,
	'Falla registrada en sensores de gestion de motor (Check Engine)',
	'Conecta un escaner al puerto OBD-II del automovil para obtener el codigo de falla especifico (sensor MAF, MAP, oxigeno o posicion del ciguenal).',
	'Realiza afinamiento electronico preventivo y limpieza de sensores y conectores para prevenir lecturas erroneas en la computadora (ECU).',
	cat_electronico,
	'assets/sensor_mal_calibrados.png'
).

problema_info(
	inyectores_sucios,
	'Inyectores obstruidos o cuerpo de aceleracion sucio',
	'Aplica un limpiador de inyectores en el combustible o lleva el riel de inyeccion a un laboratorio para limpieza por ultrasonido y calibracion.',
	'Sustituye el filtro de gasolina en los periodos recomendados y realiza limpieza al cuerpo de aceleracion cada 30.000 km.',
	cat_combustible,
	'assets/inyectores_sucios.png'
).

problema_info(
	bujias_defectuosas,
	'Bujias de encendido desgastadas o defectuosas',
	'Extrae las bujias, verifica la holgura del electrodo y sustituye el juego completo por bujias nuevas con el grado termico correspondiente.',
	'Reemplaza las bujias segun el kilometraje especificado (cada 30.000 km para bujias de cobre o hasta 80.000 km para bujias de iridio).',
	cat_encendido,
	'assets/bujias_defectuosas.png'
).

problema_info(
	bobina_encendido_defectuosa,
	'Bobina de encendido deteriorada o cables con fuga',
	'Prueba la continuidad y resistencia de las bobinas de encendido con un multimetro y reemplaza la bobina del cilindro que presenta fallos.',
	'Revisa el estado del aislamiento de las bobinas y cables de bujia para evitar perdidas de chispa producidas por humedad o calor.',
	cat_encendido,
	'assets/bobina_encendido_defectuosa.png'
).

problema_info(
	falla_embrague,
	'Desgaste del disco o plato de presion del embrague',
	'Lleva el vehiculo a un taller mecanico para sustituir el kit completo de embrague (disco, plato de presion y balinera de empuje).',
	'Evita apoyar el pie sobre el pedal de embrague mientras manejas y no mantengas el embrague pisado durante paradas en semaforos.',
	cat_transmision,
	'assets/falla_embrague.png'
).

problema_info(
	sincronizadores_transmision,
	'Desgaste en sincronizadores de la caja de cambios',
	'Revisa el nivel y estado de la valvulina de la transmision manual y acude al taller para graduar el varillaje o revisar sincronizadores.',
	'Cambia el aceite de la transmision segun el intervalo del fabricante y realiza los cambios de marcha de forma suave y acompasada.',
	cat_transmision,
	'assets/sincronizadores_transmision.png'
).

problema_info(
	presion_neumaticos_baja,
	'Presion baja de aire o pinchadura en un neumatico',
	'Inspecciona las ruedas en busca de clavos o deformaciones y calibra la presion de aire en una estacion de servicio segun la etiqueta del vehiculo.',
	'Verifica la presion de inflado de las cuatro llantas y la de repuesto cada dos semanas, preferentemente cuando las ruedas esten frias.',
	cat_neumaticos,
	'assets/presion_neumaticos_baja.png'
).

problema_info(
	direccion_asistida_defectuosa,
	'Falla en la bomba o falta de fluido en la direccion asistida',
	'Revisa el deposito de fluido de la direccion hidraulica, anade liquido ATF/direccion asistida y revisa fugas en la bomba o cremallera.',
	'Verifica el estado del fluido de direccion asistida y comprueba que la correa de la bomba mantenga la tension correcta.',
	cat_mecanico,
	'assets/direccion_asistida_defectuosa.png'
).

problema_info(
	filtro_aire_obstruido,
	'Filtro de aire del motor saturado de suciedad',
	'Destapa la caja portafiltros y sustituye el filtro de aire por uno nuevo para recuperar el caudal optimo de oxigeno hacia la combustion.',
	'Inspecciona el filtro de aire cada 10.000 km y renuevalo con mayor frecuencia si conduces frecuentemente por vias destapadas o polvorientas.',
	cat_admision,
	'assets/filtro_aire_obstruido.png'
).

problema_info(
	desgaste_anillos_motor,
	'Desgaste en anillos de piston o retenes de valvula',
	'Mide la compresion de los cilindros en un taller mecanico para determinar el estado de sellado de los anillos y guias de valvula.',
	'No extiendas los intervalos de cambio de aceite y filtro para evitar que la carbonilla desgaste prematuramente las paredes del cilindro.',
	cat_mecanico,
	'assets/desgaste_anillos_motor.png'
).
