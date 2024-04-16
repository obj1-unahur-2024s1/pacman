import wollok.game.*
import juego.*

/*
 * este objeto agrega una animación a pacman
 * este objeto no es agregado directamente al juego, sino que es una propiedad de pacman
 */
object animacionPacman {
	var fotograma = 0
	var direccion = "derecha"
	var animando = false
	const velocidad = 120
	
	method direccion() = direccion
	
	/*
	 * precondiciones: las direcciones posibles son derecha, izquierda, arriba, abajo
	 */
	method direccion(nuevaDireccion) {
		direccion = nuevaDireccion
	}
	
	
	method siguienteFotograma() {
		fotograma = (fotograma +1) % 3
	}
	
	method image() {
		const img = "pacman/super/" + direccion + "-" + fotograma.toString() + ".png"
		return img
	}
	
	method animar() {
		self.detener()
		animando = true
		game.onTick(velocidad, "pacman-animacion", {
			self.siguienteFotograma()
		})
	}
	
	method detener() {
		if(animando) {
			animando = false
			game.removeTickEvent("pacman-animacion")		
		}
	}
}

object pacman {
	var position = game.center()
	var modoSuperPacman = true
	var vidas = 3
	var detenido = true
	var animacion = animacionPacman
	
	method position() {
		return position
	}

	method position(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method image() {
		return animacion.image()
	}

	method juegoTerminado() = vidas == 0

	method irAInicio() {
		position = tablero.puntoInicioPacman()
	}

	method animar() {
		animacion.animar()
	}

	// mover un paso a la derecha
	method moverDerecha() {
		/*
		// método con if
		var nuevoX = position.x() + 1
		if(nuevoX >= tablero.limiteDerecho()) {
			nuevoX = tablero.limiteIzquierdo()
		}
		*/

		// metodo sin if
		const nuevoX = tablero.limiteIzquierdo()
						.max((position.x() + 1) % (tablero.limiteDerecho() + 1))

		position = game.at(
			nuevoX ,
			position.y())
	}

	// mover un paso a la izquierda
	method moverIzquierda() {
		var nuevoX = position.x() - 1
		if(nuevoX < tablero.limiteIzquierdo()) {
			nuevoX = tablero.limiteDerecho()
		}

		position = game.at(
			nuevoX ,
			position.y())
	}

	// mover un paso arriba
	method moverArriba() {
		position = game.at(
			position.x() ,
			tablero.limiteInferior()
						.max((position.y() + 1) % (tablero.limiteSuperior() + 1))
			)
	}

	// mover un paso abajo
	method moverAbajo() {
		position = game.at(
			position.x(),
			if(position.y() - 1 >= tablero.limiteInferior()) 
				position.y() - 1 
			else tablero.limiteSuperior()
			)
	}

	// inicia movimiento continuo hacia la derecha 
	method movimientoContinuoDerecha() {
		self.detener()
		animacion.direccion("derecha")
		animacion.animar()
		game.onTick(100.max(150 - juego.nivel()*10), "movimiento-pacman", {
			self.moverDerecha()
		} )
		detenido = false
	}

	// inicia movimiento continuo hacia la izquierda 
	method movimientoContinuoIzquierda() {
		self.detener()
		animacion.direccion("izquierda")
		animacion.animar()
		game.onTick(100.max(150 - juego.nivel()*10), "movimiento-pacman", {
			self.moverIzquierda()
		} )
		detenido = false
	}

	// inicia movimiento continuo hacia arriba
	method movimientoContinuoArriba() {
		self.detener()
		animacion.direccion("arriba")
		animacion.animar()
		game.onTick(100.max(150 - juego.nivel()*10), "movimiento-pacman", {
			self.moverArriba()
		} )
		detenido = false
	}

	// inicia movimiento continuo hacia abajo
	method movimientoContinuoAbajo() {
		self.detener()
		animacion.direccion("abajo")
		animacion.animar()
		game.onTick(100.max(150 - juego.nivel()*10), "movimiento-pacman", {
			self.moverAbajo()
		} )
		detenido = false
	}

	// detiene el movimiento de pacman
	method detener() {
		if(!detenido) {
			detenido = true
			game.removeTickEvent("movimiento-pacman")
		}
		animacion.detener()
	}

	// recibe ataque de un fantasma
	// si está en modo "super pacman" no pierde vidas
	method recibirAtaque(atacante) {
		if(!modoSuperPacman) {
			vidas = 0.max(vidas - 1)			
		}
		if (self.juegoTerminado()) {
			game.stop()
		}
	}


	// inicia modo superpacman
	// el tiempo en que el pacman está en este estado disminuye en cada nivel
	// el tiempo mínimo en el que pacman está en este estado es de 2 segundos
	method inciarModoSuperpacman() {
		modoSuperPacman = true

		game.schedule(2000.max(10000 - juego.nivel()*1000), {
			modoSuperPacman = false
		})
	}

	method esSuperpacman() = modoSuperPacman

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
object fantasmaRosa {
	var position = game.center()

	method image() = "fantasma/rival1-derecha.png"
	method position() = position

	method respawn() {
		position = tablero.puntoInicoFantasmas()
	}
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


