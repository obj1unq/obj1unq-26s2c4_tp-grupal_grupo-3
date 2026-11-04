import fondo.*
import niveles.*
import wollok.game.*

class Partida {
    const personaje
    var puntos = 0
    var nivel = nivel1

    method puntos() = puntos

    method iniciar() {
        game.clear()
        fondo.iniciar(nivel.animacionFondo())
        personaje.position(game.at(0, 1))
        game.addVisual(personaje)
        personaje.inicializar()
        // TEMPORAL PARA TESTEAR FONDOS
        keyboard.n().onPressDo({ self.pasarDeNivel() })
    }

    method sumarPuntos(cantidad) {
        puntos = puntos + cantidad
    }

    method nivel(nuevoNivel) {
        nivel = nuevoNivel
    }

    method pasarDeNivel() {
        nivel.terminar(self)
    }

    method ganar() {
        game.say(personaje, "Gane!")
    }
}