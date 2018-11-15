object partidoTerminado inherits Exception("Partido Terminado"){} 
object casilleroOcupado inherits Exception("Casillero ocupado " ){
	var property casillero 
	override method getMessage() = super() + casillero		

}

object tablero{
	const image = "tablero.png"
	const position = game.origin()
	
	const posicionesTablero = [game.origin(),game.at(0,6), game.at(3,6), game.at(6,6), game.at(0,3), game.at(3,3), game.at(6,3), game.at(0,0), game.at(3,0), game.at(6,0)]
	const posicionesInteligencias = [game.at(15,6),game.at(15,0)] 
	const posicionesJugadores = [game.at(12,6),game.at(12,0)] 

	method iniciar(){
		game.width(18)
		game.height(9)
		game.addVisual(self)
	}
			
	method mostrarJugada(icono,casillero){ 
		game.addVisual(new Marca(icono = icono, position = posicionesTablero.get(casillero)))
	}
	method mensaje(resultado,casillero) {
		game.say(self.marcaEn(casillero),resultado.mensaje())
	}
	method vaciar(casilleros){
		casilleros.forEach({casillero=> game.removeVisual(self.marcaEn(casillero))})
	}
	method marcaEn(casillero){
		return game.getObjectsIn(posicionesTablero.get(casillero)).last()
	}
	method mostrarJugadores(iconos){
		self.mostrarElementos(iconos,posicionesJugadores)
	} 
	method mostrarInteligencias(inteligencias){
		self.mostrarElementos(inteligencias,posicionesInteligencias)
	} 
	method mostrarElementos(elementos,posiciones){
		game.addVisualIn(elementos.first(),posiciones.first())
		game.addVisualIn(elementos.last(),posiciones.last())
	}
}

object victoria{
	var property ganador
	method mensaje() = "El ganador es el jugador " + ganador.nombre()	
}
object empate{
	method mensaje() ="Partido empatado" 
}
class Marca {
	var property position
	var property icono
	method image() = icono.image()
}

object circulo{
	method nombre() = "CIRCULO"
	method image() = "circulo.png" 
}

object cruz{
	method nombre() = "CRUZ"
	method image() = "cruz.png" 
}

