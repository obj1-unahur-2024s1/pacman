/*
 * la comidita otorga 1 punto al ser comida
 */
object comidita {
}


/*
 * la cereza otorga 10 puntos al ser comida
 */
object cereza {
	method puntosQueOtorga(){
		return 10
	}
}

/*
 * la cereza otorga 15 puntos al ser comida
 */
object banana {
	method puntosQueOtorga(){
		return 15
	}
}

/*
 * el superPacmanInador 5 puntos al ser comido
 * además, el superPacmanInador tiene la característica de ofrecerle superpoderes al pacman por un tiempo determinado
 */
object superPacmanInador {
	method puntosQueOtorga(){
		return 5
	}
}

