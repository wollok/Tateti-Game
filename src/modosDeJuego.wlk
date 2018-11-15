import tateti.*
import visuales.*

object humano{
	method image() = "humano.jpg"
	method jugar() {}
	method rotar() = facil
	method nombre() = "Humano"
	method interactiva() = true
} 

class InteligenciaArtificial {
	method image() = "maquina.jpg"
	method interactiva() = false
	method nombre() = "Inteligencia artificial" + self.descripcion()
	method descripcion()
}

object facil inherits InteligenciaArtificial{
	override method descripcion() = "facil"
	method jugar() {
		//Juega en cualquier posicion
		//tablero.pausa()
		tateti.jugada(tateti.casillerosLibres().anyOne())
	}
	method rotar() = humano
}

object avanzado inherits InteligenciaArtificial{
	override method descripcion() = "avanzado"
	
} 



