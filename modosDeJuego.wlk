import tateti.*
import visuales.*

object humano{
	method jugar() {}
	method rotar() = maquina
	method nombre() = "human"
	method interactiva() = true
	method image() = "human.png"
} 

object maquina {
	method image() = "machine.png"
	method interactiva() = false
	method nombre() = "Inteligencia artificial" + self.descripcion()
	method descripcion() = "facil"
	method jugar() {
		//Juega en cualquier posicion
		tateti.jugada(tateti.casillerosLibres().anyOne())
	}
	method rotar() = humano
}



