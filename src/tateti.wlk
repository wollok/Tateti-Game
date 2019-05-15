import visuales.*
import modosDeJuego.*


object tateti {
	const combinacionesGanadoras = [[1,2,3],[1,4,7],[1,5,9],[2,5,8],[3,6,9],[3,5,7],[4,5,6],[7,8,9]]
	var jugadores = [new Jugador(icono = cruz,inteligencia=maquina),new Jugador(icono = circulo)]

	var property casillerosLibres  
	var property casillerosOcupados = [] 

	var jugadorActual = jugadores.first()
	
	method iniciar()	{
		self.desplegarJugadores()
		self.desplegarInteligencias()
		self.limpiar()
		self.comenzar()		
	}
	
	method limpiar() {
		tablero.vaciar(casillerosOcupados)
		casillerosOcupados.clear()
		jugadores.forEach{j=>j.recomenzar()}
		casillerosLibres = [1,2,3,4,5,6,7,8,9]
	}
	method comenzar(){
		jugadorActual = jugadores.first()
		jugadorActual.jugar()
	}
	method desplegarInteligencias(){
		tablero.mostrarInteligencias(jugadores.map{j=>j.inteligencia()})
	}
	method desplegarJugadores() {
		tablero.mostrarJugadores(jugadores.map{j=>j.icono()})
	}
	method siguienteJugada(){
		jugadorActual.jugar()
	}

	method jugadaInteractiva(casillero){
		if(jugadorActual.interactivo()){
			self.jugada(casillero)
		}
	}

	method jugada(casillero){
		self.validarFinPartido()
		self.validarCasilleroLibre(casillero)
		self.jugarTurno(jugadorActual,casillero)
		if(self.terminoElPartido())
			self.finalizar()
		else
			self.cambiarTurno()
	}
	
	method validarCasilleroLibre(casillero){
		if(!self.estaLibre(casillero)){
			casilleroOcupado.casillero(casillero)
			throw casilleroOcupado 
		}
	}
	method validarFinPartido(){
		if(self.terminoElPartido())
			throw partidoTerminado 
	}
	method estaLibre(casillero)	= 
		casillerosLibres.contains(casillero)
	
	method ocuparCasillero(casillero){
		casillerosLibres.remove(casillero)
		casillerosOcupados.add(casillero)
	}
		
	method jugarTurno(jugador, casillero) {
		self.ocuparCasillero(casillero)
		jugador.marcarCasillero(casillero)
		tablero.mostrarJugada(jugador.icono(),casillero)
	}
		
	method oponente(jugador) = jugadores.find{j=>j != jugador}
	
	method cambiarTurno(){
		jugadorActual = self.oponente(jugadorActual)
	}
	
	method terminoElPartido() =
		self.sinCasillerosLibres() or self.hayGanador() 
		
	method finalizar(){
		var resultado = empate
		if(self.hayGanador()){
			victoria.ganador(self.ganador())			
			resultado = victoria 
		}
		tablero.mensaje(resultado,casillerosOcupados.last())
	}
	
	method esGanador(jugador) =
		return combinacionesGanadoras.any({combinacion => jugador.tieneCombinacion(combinacion)})
	
	method hayGanador()	= 
		jugadores.any{jugador => self.esGanador(jugador)}
	
	method ganador() =
		jugadores.find{jugador => self.esGanador(jugador)}


	method sinCasillerosLibres() = casillerosLibres.isEmpty()
	
	method cambioModoPrimero(){
		jugadores.first().rotarInteligencia()
		self.desplegarInteligencias()
	}
	method cambioModoUltimo(){
		jugadores.last().rotarInteligencia()
		self.desplegarInteligencias()
	}

}

class Jugador {
	var property icono
	var ocupados = []
	var property inteligencia = humano

	method nombre() = icono.nombre()
		
	method marcarCasillero(casillero)	{
		ocupados.add(casillero)
	}
	method recomenzar(){
		ocupados.clear()
	}

	method tieneCombinacion(combinacion) = combinacion.all{casillero => ocupados.contains(casillero)}
	
	method jugar(){
		inteligencia.jugar()
	}
	method rotarInteligencia(){
		inteligencia = inteligencia.rotar()
	}
	method interactivo() = inteligencia.interactiva()
	
}
