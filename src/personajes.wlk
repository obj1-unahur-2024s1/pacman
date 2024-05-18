import wollok.game.*
import juego.*
import elementos.*

/*
 * este objeto agrega una animación a pacman
 * este objeto no es agregado directamente al juego, sino que es una propiedad de pacman
 */
object animacionPacman {
	var fotograma = 0
	var orientacion = este
	var animando = false
	const velocidad = 120
	
	method orientacion() = orientacion
	
	method orientacion(nuevaDireccion) {
		orientacion = nuevaDireccion
	}
	
	method siguienteFotograma() {
		fotograma = (fotograma +1) % 3
	}
	
	method image() {
		const img = "pacman/" + orientacion.toString() + "-" + fotograma.toString() + ".png"
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
	var celdaAnterior = position
	var modoSuperPacman = false
	var vidas = 3
	var detenido = true
	var animacion = animacionPacman
	const tiksMinimos = 100
	const tiksBase = 150
	
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
	

/*
	// mover un paso a la derecha
	method moverDerecha() {
		const nuevoX = tablero.limiteIzquierdo()
						.max((position.x() + 1) % (tablero.limiteDerecho() + 1))
		celdaAnterior = position
		position = game.at(
			nuevoX ,
			position.y())
	}

	// mover un paso a la izquierda
	method moverIzquierda() {
		celdaAnterior = position
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
		celdaAnterior = position
		position = game.at(
			position.x() ,
			tablero.limiteInferior()
						.max((position.y() + 1) % (tablero.limiteSuperior() + 1))
			)
	}

	// mover un paso abajo
	method moverAbajo() {
		celdaAnterior = position

		position = game.at(
			position.x(),
			if(position.y() - 1 >= tablero.limiteInferior()) 
				position.y() - 1 
			else tablero.limiteSuperior()
			)
	}
*/

	method moverUnCasillero() {
		var nuevoX = (tablero.ancho() + position.x() - tablero.limiteIzquierdo() + animacion.orientacion().siguienteX())
						% tablero.ancho()
						+ tablero.limiteIzquierdo()

		var nuevoY = (tablero.alto() + position.y() - tablero.limiteInferior() + animacion.orientacion().siguienteY())
						% tablero.alto()
						+ tablero.limiteInferior()
		celdaAnterior = position
		position = game.at(nuevoX, nuevoY)
	}

	method mover() {
		animacion.animar()
		game.onTick(tiksMinimos.max(tiksBase - juego.nivel()*10), "movimiento-pacman", {
			self.moverUnCasillero()
		} )
		detenido = false
	}

	// inicia movimiento continuo hacia la derecha 
	method iniciarMovimientoContinuoDerecha() {
		self.detener()
		animacion.orientacion(este)
		self.mover()
	}

	// inicia movimiento continuo hacia la izquierda 
	method iniciarMovimientoContinuoIzquierda() {
		self.detener()
		animacion.orientacion(oeste)
		self.mover()
	}

	// inicia movimiento continuo hacia arriba
	method iniciarMovimientoContinuoArriba() {
		self.detener()
		animacion.orientacion(norte)
		self.mover()
	}

	// inicia movimiento continuo hacia abajo
	method iniciarMovimientoContinuoAbajo() {
		self.detener()
		animacion.orientacion(sur)
		self.mover()
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
	method recibirAtaqueDe(atacante) {
		if(!modoSuperPacman) {
			game.say(self, "ouch!")
			vidas = 0.max(vidas - 1)			
		} else {
			game.say(self, "chau")
			game.removeVisual(atacante)
		}
		if (self.juegoTerminado()) {
			game.stop()
		}
	}


	// inicia modo superpacman
	// el tiempo en que el pacman está en este estado disminuye en cada nivel
	// el tiempo mínimo en el que pacman está en este estado es de 2 segundos
	method convertirSuperPacman() {
		modoSuperPacman = true
			game.say(self, "jejeje!")

		game.schedule(2000.max(15000 - juego.nivel()*1000), {
			game.say(self, "me siento debil :(")
			modoSuperPacman = false
		})
	}
	
	method volver() {
		self.detener()
		// var opuesto = animacion.orientacion().opuesto()
		// var nuevoX = position.x() + opuesto.siguienteX()
		// var nuevoY = position.y() + opuesto.siguienteY()
		// position = game.at(nuevoX, nuevoY)
		position = celdaAnterior
	}

	method esSuperpacman() = modoSuperPacman

}

/*
object fantasmaRosa {
	var position = game.center()

	method image() = "fantasma/rival1-este.png"
	method position() = position

	method respawn() {
		position = tablero.puntoInicoFantasmas()
	}
	
	method recibirMordiscoDe(objeto) {
	}
	
}


object fantasmaRojo {
		var position = game.center()

	method image() = "fantasma/rival1-este.png"
	method position() = position

	method respawn() {
		position = tablero.puntoInicoFantasmas()
	}
	
	method recibirMordiscoDe(objeto) {
	}
}

object fantasmaVerde {
	var position = game.center()

	method image() = "fantasma/rival1-este.png"
	method position() = position

	method respawn() {
		position = tablero.puntoInicoFantasmas()
	}
	
	method recibirMordiscoDe(objeto) {
	}}


object fantasmaCeleste {
	var position = game.center()

	method image() = "fantasma/rival1-este.png"
	method position() = position

	method respawn() {
		position = tablero.puntoInicoFantasmas()
	}
	
	method recibirMordiscoDe(objeto) {
	}}
*/

class Fantasma {
	const posicionInicial
	var position = posicionInicial
	var orientacion = este

	method image() = "fantasma/" + orientacion.toString() + "-1.png"
	method position() = position

	method respawn() {
		position = posicionInicial
	}

	method recibirMordiscoDe(objeto) {
	}

}
