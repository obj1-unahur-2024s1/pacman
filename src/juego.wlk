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

		var fantasma1 = new Fantasma(posicionInicial = game.at(10, 17))
		var fantasma2 = new Fantasma(posicionInicial = game.at(15, 17))
		var fantasma3 = new Fantasma(posicionInicial = game.at(20, 17))
		var fantasma4 = new Fantasma(posicionInicial = game.at(25, 17))

		self.dibujarMuros()
		game.addVisual(fantasma1)
		game.addVisual(fantasma2)
		game.addVisual(fantasma3)
		game.addVisual(fantasma4)
		game.addVisual(pacman)

		var inador1 = new SuperPacmanInador(position= game.at(3,5))
		var inador2 = new SuperPacmanInador(position= game.at(28,5))
		var inador3 = new SuperPacmanInador(position= game.at(3,27))
		var inador4 = new SuperPacmanInador(position= game.at(28,27))

		game.addVisual(inador1)
		game.addVisual(inador2)
		game.addVisual(inador3)
		game.addVisual(inador4)
		
		inador1.animar()
		
		// game.addVisual(muro)
		pacman.animar()
		self.configurarTeclas()
		game.onCollideDo(pacman, {o => o.recibirMordiscoDe(pacman)})
		game.onCollideDo(fantasma1, {o => o.recibirAtaqueDe(fantasma1)})
		game.onCollideDo(fantasma2, {o => o.recibirAtaqueDe(fantasma2)})
		game.onCollideDo(fantasma3, {o => o.recibirAtaqueDe(fantasma3)})
		game.onCollideDo(fantasma4, {o => o.recibirAtaqueDe(fantasma4)})

		preparado = true
	}

	method agregarMuroEn(x, y) {
		const muro = new Muro(position = game.at(x,y))
		game.addVisual(muro)
	}

	method dibujarMurosEnPosiciones(matriz) {
		
	}
/* 
	// version 1
	method dibujarMuros() {
		self.agregarMuroEn(2,1)
		self.agregarMuroEn(3,1)
		self.agregarMuroEn(4,1)
		self.agregarMuroEn(5,1)
		self.agregarMuroEn(6,1)
	}
*/
	// version 2
	method dibujarMuros() {
		self.dibujarLineaDeMuros(31, [0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0])
		self.dibujarLineaDeMuros(30, [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0])
		self.dibujarLineaDeMuros(29, [0,0,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(28, [0,0,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(27, [0,0,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(26, [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0])
		self.dibujarLineaDeMuros(25, [0,0,1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(24, [0,0,1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(23, [0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0])
		self.dibujarLineaDeMuros(22, [0,0,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1,0])
		self.dibujarLineaDeMuros(21, [0,0,0,0,0,0,0,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(20, [0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(19, [0,0,0,0,0,0,0,1,0,1,1,0,1,1,1,0,0,1,1,1,0,1,1,0,1,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(18, [0,0,1,1,1,1,1,1,0,1,1,0,1,0,0,0,0,0,0,1,0,1,1,0,1,1,1,1,1,1,0])
		self.dibujarLineaDeMuros(17, [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(16, [0,0,1,1,1,1,1,1,0,1,1,0,1,0,0,0,0,0,0,1,0,1,1,0,1,1,1,1,1,1,0])
		self.dibujarLineaDeMuros(15, [0,0,0,0,0,0,0,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(14, [0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,2,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(13, [0,0,0,0,0,0,0,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,0,0,0,0,0,0])
		self.dibujarLineaDeMuros(12, [0,0,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,0])
		self.dibujarLineaDeMuros(11, [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0])
		self.dibujarLineaDeMuros(10, [0,0,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(09, [0,0,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(08, [0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0])
		self.dibujarLineaDeMuros(07, [0,0,1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,1,0])
		self.dibujarLineaDeMuros(06, [0,0,1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,1,0])
		self.dibujarLineaDeMuros(05, [0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0])
		self.dibujarLineaDeMuros(04, [0,0,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(03, [0,0,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0])
		self.dibujarLineaDeMuros(02, [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0])
		self.dibujarLineaDeMuros(01, [0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0])
	}

	method dibujarLineaDeMuros(y, vectorFila) {		
		(0..vectorFila.size()-1).forEach({i=> 
			if(vectorFila.get(i) > 0 ) {
				self.agregarMuroEn(i, y)
			}
		})
	}




	method configurarTeclas() {
		keyboard.up().onPressDo({
			pacman.iniciarMovimientoContinuoArriba()
		})
		keyboard.down().onPressDo({
			pacman.iniciarMovimientoContinuoAbajo()
		})
		keyboard.right().onPressDo({		
			pacman.iniciarMovimientoContinuoDerecha()
		})
		keyboard.left().onPressDo({
			pacman.iniciarMovimientoContinuoIzquierda()
		})
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
	const property ancho = 28
	const property alto = 31

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