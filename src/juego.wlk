import personajes.*
import elementos.*
import wollok.game.*


/*
 * - debe llevar la cuenta de los puntos acumulados, permitir incrementar los puntos en cualquier cantidad
 * - debe llevar la cuenta de la cantidad de vidas que tiene pacman
 * - debe indicar si el juego terminó (ya no tiene vidas)
 * - la cantiad maxima de vidas es de 3
 * - debe indicar el nivel actual y permitir ir aumentando de nivel
 * - debe permitir reiniciar el juego,  restableciendo la cantidad de vidas y el nivel
 */
object juego {
	var preparado = false
	var nivel = 1
	
	// indica el nivel actual
	method nivel() {
		return nivel
	}

	// inicia el siguiente nivel
	method siguienteNivel() {
		nivel += 1
		pacman.irAInicio()

	}

	method preparar() {
		game.title("Pacman")
		game.height(35)
		game.width(32)
		game.cellSize(20)
	    game.boardGround("fondo.png")

		game.addVisual(tablero)

		pacman.irAInicio()
		fantasmaRosa.respawn()
		game.addVisual(fantasmaRosa)
		game.addVisual(pacman)

		self.configurarTeclas()

		preparado = true
	}
	
	method configurarTeclas() {
		keyboard.up().onPressDo({pacman.movimientoContinuoArriba()})
		keyboard.down().onPressDo({pacman.movimientoContinuoAbajo()})
		keyboard.right().onPressDo({		
			pacman.movimientoContinuoDerecha()
		})
		keyboard.left().onPressDo({pacman.movimientoContinuoIzquierda()})
	}
	
	
	// inicia el juego
	// TODO: si el juego no está preparado debe disparar un error
	method iniciar() {
		if(preparado) {
			game.start()		
		}
	}

}


object tablero {
	const position = game.at(2, 1)
	const ancho = 28
	const alto = 31

	method position() {
		return position
	}
	method image() = "tablero.png"

	method limiteIzquierdo() {
		return position.x()
	}

	method limiteDerecho() {
		return position.x() + ancho - 1
	}

	method limiteInferior() {
		return position.y()
	}

	method limiteSuperior() {
		return position.y() + alto - 1 
	}

	method puntoInicioPacman() {
		return game.at(
			position.x() + 13,
			position.y() + 13
		)
	}
	method puntoInicoFantasmas() {
		return game.at(
			position.x() + 13,
			position.y() + 16
		)
	}

}