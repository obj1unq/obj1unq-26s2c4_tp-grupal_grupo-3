import personajes.*
import partida.*
import wollok.game.*

object menu {
    const personajes = [personaje1, personaje2, personaje3]
    var numeroElegido = 0

    method mostrar() {
        personajes.forEach({ personaje => personaje.mostrarEnMenu() })
        game.addVisual(titulo)
        game.addVisual(ayudaElegir)
        game.addVisual(ayudaJugar)
        game.addVisual(cursor)
        self.controles()
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
    position = game.at(6, 4),
    text = "ENDLESS RUNNER"
)

const ayudaElegir = new Texto(
    position = game.at(6, 1),
    text = "Flechas (<- ->): elegir personaje"
)

const ayudaJugar = new Texto(
    position = game.at(6, 0),
    text = "ENTER: jugar"
)

// Marca debajo del personaje elegido
object cursor {
    method position() = menu.elegido().position().down(1)
    method text() = "^"
}

object juego {
    var property partida = null

    method iniciar(personajeElegido) {
        partida = new Partida(personaje = personajeElegido)
        partida.iniciar()
    }
}
