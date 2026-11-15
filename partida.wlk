import fondo.*
import nivel.*
import obstaculo.*
import wollok.game.*

class Partida {
    const personaje
    const fondoPartida = fondo
    var puntos = 0
    var nivel = nivel1
   
    method puntos() = puntos

    method iniciar() {
        game.clear()
        fondoPartida.iniciar(nivel.animacionFondo())
        personaje.position(game.at(0, 1))
        game.addVisual(personaje)
        personaje.inicializar()
        generadorDeObstaculos.iniciar({nivel.imagenesObstaculos().anyOne()})
        // TEMPORAL PARA TESTEAR FONDOS
        keyboard.n().onPressDo({ self.pasarDeNivel() })
    }

    method sumarPuntos(cantidad) {
        puntos = puntos + cantidad
    }

    method nivel(nuevoNivel) {
        nivel = nuevoNivel
    }

    method mostrarTransicion(animacionTransicion) {
        fondoPartida.mostrar(animacionTransicion)
    }

    method pasarDeNivel() {
        nivel.terminar(self)
    }

    method ganar() {
        game.say(personaje, "Gane!")
    }
}