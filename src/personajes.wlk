/*
 * - tiene que poder moverse horizontalmente y verticalmente por el tablero
 * - si llega al final del tablero, tiene que aparecer por el lado contrario 
 * 		(por ej, si llega al extremo derecho, tiene que aparecer por la izquierda)
 * - cuando el pacman se encuentra algun elemento, lo come, y la cantidad de puntos que recibe depende de lo que come
 * - cuando el pacman se encuentra con un fantasma, si está en modo superpacman, lo come, sino, no hace nada
 * - cuando recibe un ataque, si no está en modo "super pacman" pierde una vida. si está en modo superpacman, no le pasa nada
 */
object pacman {

}

/*
 * el fantasma puede moverse horizontal y vertical por el tablero, siempre por el camino que le permiten los muros
 * - si llega al final del tablero, tiene que aparecer por el lado contrario 
 * 		(por ej, si llega al extremo derecho, tiene que aparecer por la izquierda)
 * al encontrarse con el pacman, lo ataca. Que el pacman pierda vida o no, depende de si el pacman está en modo superpacman
 * el encontrase con un muro, cambia el recorrido en forma eleatoria
 * al encontrase con otros objetos del camino, los ignora
 * su velocidad base es de 2 paso por segundo, más un paso adicional por cada nivel de juego
 * su velocidad maxima es de 10 pasos por segundos
 */
object fantasmaLila {
}


/*
 * el fantasma puede moverse horizontal y vertical por el tablero, siempre por el camino que le permiten los muros
 * - si llega al final del tablero, tiene que aparecer por el lado contrario 
 * 		(por ej, si llega al extremo derecho, tiene que aparecer por la izquierda)
 * al encontrarse con el pacman, lo ataca. Que el pacman pierda vida o no, depende de si el pacman está en modo superpacman
 * el encontrase con un muro, cambia el recorrido en forma eleatoria
 * al encontrase con otros objetos del camino, los ignora
 * su velocidad base es de 3 pasos por segundo, más un paso adicional por cada nivel de juego
 * su velocidad maxima es de 10 pasos por segundos
 */
object fantasmaRojo {
	
}

/*
 * el fantasma puede moverse horizontal y vertical por el tablero, siempre por el camino que le permiten los muros
 * - si llega al final del tablero, tiene que aparecer por el lado contrario 
 * 		(por ej, si llega al extremo derecho, tiene que aparecer por la izquierda)
 * al encontrarse con el pacman, lo ataca. Que el pacman pierda vida o no, depende de si el pacman está en modo superpacman
 * el encontrase con un muro, cambia el recorrido en forma eleatoria
 * al encontrase con otros objetos del camino, los ignora
 * su velocidad base es de 3 pasos por segundo, más dos pasos2 adicional por cada nivel de juego
 * su velocidad maxima es de 10 pasos por segundos
 */
object fantasmaVerde {
}

/*
 * el fantasma puede moverse horizontal y vertical por el tablero, siempre por el camino que le permiten los muros
 * - si llega al final del tablero, tiene que aparecer por el lado contrario 
 * 		(por ej, si llega al extremo derecho, tiene que aparecer por la izquierda)
 * al encontrarse con el pacman, lo ataca. Que el pacman pierda vida o no, depende de si el pacman está en modo superpacman
 * el encontrase con un muro, cambia el recorrido en forma eleatoria
 * al encontrase con otros objetos del camino, los ignora
 * su velocidad base es de 4 pasos por segundo, más tres pasos adicionales por cada nivel de juego, hasta el nivel 3, luego aumenta un paso por nivel
 * su velocidad maxima es de 10 pasos por segundos
 */
object fantasmaCeleste {
}


