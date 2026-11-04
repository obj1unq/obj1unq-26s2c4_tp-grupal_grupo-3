import fondo.*
import niveles.*

class Partida {
    const personaje
    var puntos = 0
    var nivel = Nivel1

    method puntos() = puntos

    method iniciar() {
        game.clear()
        fondo.iniciar(nivel.animacionFondo())
        personaje.position(game.at(0, 1))
        game.addVisual(personaje)
        personaje.inicializar()
    }

    method sumarPuntos(cantidad) {
        puntos = puntos + cantidad
    }
}