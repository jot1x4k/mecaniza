% problema_info(Id, Nombre, Solucion, Recomendacion, Categoria, Asset)

problema_info(
	bateria_descargada, 
	'Bateria descargada',
	'Recarga la bateria de tu carro. Conecta el cable rojo al positivo de tu bateria, y despues al negativo.',
	'Reemplaza tu bateria si ya cumplio su ciclo de vida util.',
	cat_electrico,
	'assets/bateria_descargada.png'
).

problema_info(
	tanque_comustible_vacio, 
	'Tanque de combustible vacio',
	'Asegurate de repostar tu vehiculo, puedes ir a una estacion de servicio y comprar una bolsa para combustible.',
	'Revisa el tanque de combustible en busca de fugas o aberturas.',
	cat_liquidos,
	'assets/tanque_comustible_vacio.png'
).

problema_info(
	sensor_mal_calibrado, 
	'Sensores mal calibrados',
	'Dirigete a un centro de diagnostico para que escaneen tu vehiculo por el puerto OBD.',
	'Desconecta el sensor y revisa que no tenga residuos que lo puedan estar tapando.',
	cat_electrico,
	'assets/sensor_mal_calibrados.png'
).
