import wollok.game.*

/*
 * la comidita otorga 1 punto al ser comida
 */
object comidita {
	method recibirMordiscoDe(objeto) {
		game.removeVisual(self)
		objeto.recibirPuntos(1)
	}
	
	method recibirAtaqueDe(fantasma) { }
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

object animacionSuperPacmanInador {
	var fotograma = 0
	var animando = false
	const velocidad = 200
	
	
	method siguienteFotograma() {
		fotograma = (fotograma +1) % 3
	}
	
	method image() {
		const img = "elementos/premio-" + fotograma.toString() + ".png"
		return img
	}
	
	method animar() {
		self.detener()
		animando = true
		game.onTick(velocidad, "premio-animacion", {
			self.siguienteFotograma()
		})
	}
	
	method detener() {
		if(animando) {
			animando = false
			game.removeTickEvent("premio-animacion")		
		}
	}
}


/*
 * el superPacmanInador 5 puntos al ser comido
 * además, el superPacmanInador tiene la característica de ofrecerle superpoderes al pacman por un tiempo determinado
 */
object superPacmanInador {
	const animacion = animacionSuperPacmanInador
	const position = game.at(3,5)
	
	method position() {
		return position
	}
	
	method image() {		
		return animacion.image()
	}
	
	method puntosQueOtorga(){
		return 5
	}
	method animar() {
		animacion.animar()
	}
	method recibirMordiscoDe(objeto) {
		game.removeVisual(self)
		objeto.convertirSuperPacman()
	}

	method recibirAtaqueDe(fantasma) { }
	
	
}


/*
object muro {
	const property position = game.at(2,2)
	method image() = "elementos/obstaculo.png"
	
	method recibirMordiscoDe(objeto) {
		objeto.volver()
	}
	
	method recibirAtaqueDe(fantasma) {
		fantasma.volver()
	}
}
*/
class Muro {
	const property position
	// method image() = "elementos/obstaculo.png"
	method image() =  "elementos/invisible.png"
	
	method recibirMordiscoDe(objeto) {
		objeto.volver()
	}
	
	method recibirAtaqueDe(fantasma) {
		fantasma.volver()
	}
}




object este {
	method opuesto() = oeste
	method toString() = "este"
	method siguienteDireccion() = norte
	method siguienteX() = 1
	method siguienteY() = 0
}

object oeste {
	method opuesto() = este
	method toString() = "oeste"
	method siguienteDireccion() = sur
	method siguienteX() = -1
	method siguienteY() = 0
}

object norte {
	method opuesto() = sur
	method toString() = "norte"
	method siguienteDireccion() = oeste
	method siguienteX() = 0
	method siguienteY() = 1
}

object sur {
	method opuesto() = norte
	method toString() = "sur"
	method siguienteDireccion() = este
	method siguienteX() = 0
	method siguienteY() = -1
}

