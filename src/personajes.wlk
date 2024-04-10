/*
 * - tiene que poder moverse horizontalmente y verticalmente por el tablero
 * - si llega al final del tablero, tiene que aparecer por el lado contrario 
 * 		(por ej, si llega al extremo derecho, tiene que aparecer por la izquierda)
 *  - tiene que implementar un metodo "comer(algo)" donde algo puede ser una comida, una fruta, un fantasma o un superPacmanInador
 *  	- todo lo que coma le da una cantidad de puntos, que depende de lo que está comiendo
 * 			- una comidita le da 1 punto
 * 			- la cereza le da 10 puntos
 * 			- la banana le da 15 puntos
 * 			- el superPacmanInador le da 5 puntos. ademas se coloca en modo "super pacman" durante 20 pasos
 * 			- los fantasmas le dan 20 puntos si está en modo superpacman y 0 puntos si no lo está
 *  - cuando el pacman recibe un ataque pierde una vida, salvo que esté en modo superpacman
 */
object pacman {

}

/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en esta caso no lo es)
 * al igual que el pacman, puede moverse horizontal y vertical por el tablero
 * su velocidad base es de 100, y se incrementa en 5 por cada nivel
 */
object fantasmaLila {
}


/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en esta caso no lo es)
 * al igual que el pacman, puede moverse horizontal y vertical por el tablero
 * su velocidad base es de 100, y se incrementa en 3 por cada nivel
 */
object fantasmaRojo {
	
}

/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en esta caso no lo es)
 * al igual que el pacman, puede moverse horizontal y vertical por el tablero
 * su velocidad base es de 100, y se incrementa en 6 por cada nivel
 */
object fantasmaVerde {
}

/*
 * debe tener un metodo "puntosQueOtorga()" que indica la cantidad de puntos que da cuando es comido
 * debe indicar si es o no un superPacmanInador (en esta caso no lo es)
 * al igual que el pacman, puede moverse horizontal y vertical por el tablero
 * su velocidad base es de 100, y se incrementa en 8 por cada nivel hasta el nivel 10, luego se incrementa en 6 por cada nivel
 */
object fantasmaCeleste {
}


