import wollok.game.*

object tablero{
	const property image = "tablero.png"
	const property position = game.origin()
	
	const posicionesTablero = [game.origin(),game.at(0,6), game.at(3,6), game.at(6,6), game.at(0,3), game.at(3,3), game.at(6,3), game.at(0,0), game.at(3,0), game.at(6,0)]
	const posicionesJugadores = [game.at(15,6),game.at(15,0)] 
	const posicionesMarcas = [game.at(12,6),game.at(12,0)] 

	method iniciar(){
		game.width(18)
		game.height(9)
		game.addVisual(self)
	}
			
	method mostrarJugada(nombre,casillero){ 
		game.addVisual(new Marca(nombre = nombre, position = posicionesTablero.get(casillero)))
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
	method mostrarMarcas(marcas){
		self.mostrarElementos(marcas,posicionesMarcas)
	} 
	method mostrarJugadores(jugadores){
		self.mostrarElementos(jugadores,posicionesJugadores)
	} 
	method mostrarElementos(elementos,posiciones){
		game.addVisualIn(elementos.first(),posiciones.first())
		game.addVisualIn(elementos.last(),posiciones.last())
	}
}

object victoria{
	var property ganador = null
	method mensaje() = "El ganador es el jugador " + ganador.marca().nombre()	
}
object empate{
	method mensaje() ="Partido empatado" 
}
class Marca {
	var property position = null
	var property nombre
	
	method image() = nombre + ".png"

}


