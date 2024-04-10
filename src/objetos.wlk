/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en este caso no lo es)
 */
object comidita {
}

/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en este caso SI lo es)
 */
object superPacmanInador {
	method puntosQueOtorga(){
		return 5
	}
	method esSuperPacmanInador() {
		return true
	}
}

/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en este caso no lo es)
 */
object cereza {
	method puntosQueOtorga(){
		return 10
	}
	method esSuperPacmanInador() {
		return false
	}
	
}

/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en este caso no lo es)
 */
object banana {
	method puntosQueOtorga(){
		return 15
	}
	method esSuperPacmanInador() {
		return false
	}
}