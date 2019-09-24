import tateti.*
import visuales.*

object humano{
	method jugar() {}
	method rotar() = maquina
	method nombre() = "humano"
	method interactiva() = true
	method image() = self.nombre() + ".jpg"
} 

object maquina {
	method image() = "maquina.jpg"
	method interactiva() = false
	method nombre() = "Inteligencia artificial" + self.descripcion()
	method descripcion() = "facil"
	method jugar() {
		//Juega en cualquier posicion
		tateti.jugada(tateti.casillerosLibres().anyOne())
	}
	method rotar() = humano
}



