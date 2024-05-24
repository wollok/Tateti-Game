import visuales.*
import modosDeJuego.*

object tateti {
	const combinacionesGanadoras = [
		[1, 2, 3],
		[1, 4, 7],
		[1, 5, 9],
		[2, 5, 8],
		[3, 6, 9],
		[3, 5, 7],
		[4, 5, 6],
		[7, 8, 9]
	]

	const jugadores = [
		new Jugador(marca = new Marca(nombre = "cruz", position = game.at(12, 6)), inteligencia = maquina, position = game.at(15,6)),
		new Jugador(marca = new Marca(nombre = "circulo", position = game.at(12, 0)), position = game.at(15,0))
	]
	var property casillerosLibres = []
	const property casillerosOcupados = []
	var jugadorActual = jugadores.first()
	
	method iniciar() {
		self.desplegarMarcas()
		self.desplegarJugadores()
		self.comenzar()
	}
	
	method limpiar() {
		tablero.vaciar(casillerosOcupados)
		casillerosOcupados.clear()
		jugadores.forEach({ jugador => jugador.recomenzar() })
		casillerosLibres = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	}
	
	method comenzar() {
		self.limpiar()
		jugadorActual = jugadores.first()
		jugadorActual.jugar()
	}
	
	method desplegarJugadores() {
		tablero.mostrarJugadores(jugadores)
	}
	
	method desplegarMarcas() {
		tablero.mostrarMarcas(jugadores.map({ j => j.marca() }))
	}
	
	method siguienteJugada() {
		jugadorActual.jugar()
	}
	
	method jugadaInteractiva(casillero) {
		if (jugadorActual.interactivo()) self.jugada(casillero)
	}
	
	method jugada(casillero) {
		self.validarFinPartido()
		self.validarCasilleroLibre(casillero)
		self.jugarTurno(jugadorActual, casillero)
		if (self.terminoElPartido()) self.finalizar() else self.cambiarTurno()
	}
	
	method validarCasilleroLibre(casillero) {
		if (!self.estaLibre(casillero)) {
			throw new Exception(message = "Casillero ocupado" + casillero.printString())
		}
	}
	
	method validarFinPartido() {
		if (self.terminoElPartido()) {
			throw new Exception(message = "Partido terminado")
		}
	}
	
	method estaLibre(casillero) = casillerosLibres.contains(casillero)
	
	method ocuparCasillero(casillero) {
		casillerosLibres.remove(casillero)
		casillerosOcupados.add(casillero)
	}
	
	method jugarTurno(jugador, casillero) {
		self.ocuparCasillero(casillero)
		jugador.marcarCasillero(casillero)
		tablero.mostrarJugada(jugador.nombre(), casillero)
	}
	
	method oponente(jugador) = jugadores.find({ j => j != jugador })
	
	method cambiarTurno() {
		jugadorActual = self.oponente(jugadorActual)
	}
	
	method terminoElPartido() = self.sinCasillerosLibres() or self.hayGanador()
	
	method finalizar() {
		var resultado = empate
		
		if (self.hayGanador()) {
			victoria.ganador(self.ganador())
			resultado = victoria
			game.onTick(5000, "gameEnd", { self.iniciar() })
		}
		tablero.mensaje(resultado, casillerosOcupados.last())
	}
	
	method esGanador(jugador) = combinacionesGanadoras.any(
		{ combinacion => jugador.tieneCombinacion(combinacion) }
	)
	
	method hayGanador() = jugadores.any({ jugador => self.esGanador(jugador) })
	
	method ganador() = jugadores.find({ jugador => self.esGanador(jugador) })
	
	method sinCasillerosLibres() = casillerosLibres.isEmpty()
	
	method cambioModoPrimero() {
		jugadores.first().rotarInteligencia()
	}
	
	method cambioModoUltimo() {
		jugadores.last().rotarInteligencia()
	}
}

class Jugador {
	var property marca
	const ocupados = []
	var property inteligencia = humano
	var property position
	
	method image() = inteligencia.image()
	
	method nombre() = marca.nombre()
	
	method marcarCasillero(casillero) {
		ocupados.add(casillero)
	}
	
	method recomenzar() {
		ocupados.clear()
	}
	
	method tieneCombinacion(combinacion) = combinacion.all(
		{ casillero => ocupados.contains(casillero) }
	)
	
	method jugar() {
		inteligencia.jugar()
	}
	
	method rotarInteligencia() {
		inteligencia = inteligencia.rotar()
	}
	
	method interactivo() = inteligencia.interactiva()
}