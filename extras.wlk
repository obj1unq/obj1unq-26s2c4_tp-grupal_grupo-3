import personaje.*
import wollok.game.*

object menu {
    const personajes = [personaje1, personaje2, personaje3]
    var numeroElegido = 0

    method mostrar() {
        self.ubicarPersonajes()
        personajes.forEach({ personaje => game.addVisual(personaje) })
        game.addVisual(titulo)
        game.addVisual(ayudaElegir)
        game.addVisual(ayudaJugar)
        game.addVisual(cursor)
        self.controles()
    }

    // Deja a los personajes en fila, en las columnas 2, 4 y 6
    method ubicarPersonajes() {
        (0 .. personajes.size() - 1).forEach({ n => personajes.get(n).position(game.at(2 + n * 2, 5)) })
    }

    method controles() {
        keyboard.right().onPressDo({ self.elegirSiguiente() })
        keyboard.left().onPressDo({ self.elegirAnterior() })
        keyboard.enter().onPressDo({ juego.iniciar(self.elegido()) })
    }

    method elegido() = personajes.get(numeroElegido)

    method elegir(numero) {
        numeroElegido = numero
    }

    method elegirSiguiente() {
        self.elegir((numeroElegido + 1) % personajes.size())
    }

    method elegirAnterior() {
        self.elegir((numeroElegido - 1 + personajes.size()) % personajes.size())
    }
}

// Textos del menu
class Texto {
    const position
    var property text

    method position() {
        return position
    }
}

const titulo = new Texto(
    position = game.at(4, 8),
    text = "ENDLESS RUNNER"
)

const ayudaElegir = new Texto(
    position = game.at(4, 3),
    text = "Flechas (<- ->): elegir personaje"
)

const ayudaJugar = new Texto(
    position = game.at(4, 2),
    text = "ENTER: jugar"
)

// Marca debajo del personaje elegido
object cursor {
    method position() = menu.elegido().position().down(1)
    method text() = "^"
}

object juego {
    const niveles = []
    var puntaje = 0

    method iniciar(personaje) {
        game.clear()
        personaje.position(game.at(0, 0))
        game.addVisual(personaje)
        personaje.inicializar()
    }
}
