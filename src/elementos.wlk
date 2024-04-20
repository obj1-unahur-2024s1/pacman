import wollok.game.*

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
}
