import wollok.game.*
import animacion.*

// Movimientos
object corriendo {
    method animacion(personaje) = personaje.animacionCorriendo()
    method alTerminar(personaje) { }
}

object saltando {
   method animacion(personaje) = personaje.animacionSaltando()
   method alTerminar(personaje) { personaje.quedarEnUltimoFrame() }
}

object deslizando {
    method animacion(personaje) = personaje.animacionDeslizando()
    method alTerminar(personaje) { personaje.correr() }
}

// Personaje
class Personaje {
    const property animacionCorriendo
    const property animacionSaltando
    const property animacionDeslizando
    var property position = game.at(0, 1)
    const posicionEnMenu 
    const maximoDeSaltos = 2
    var saltosRealizados = 0

    var estado = corriendo

    method inicializar() {
        keyboard.w().onPressDo({self.saltar()})
        keyboard.a().onPressDo({self.deslizar()})
        game.onTick(80, "animacion", {self.avanzarFrame()})
        game.onTick(500, "gravedad", { self.caer() })
    }

    method animacionActual() = estado.animacion(self)

    method image() = self.animacionActual().imagen()

    method correr() {
        self.cambiarEstado(corriendo)
    }

    method saltar() {
        if (self.puedeSaltar()) self.impulsarse()
    }
    
    method deslizar() {
        if (not self.estaEnElAire()) self.cambiarEstado(deslizando)
    }

    method caer() {
        if (self.estaEnElAire()) {
            position = position.down(1)
        } else {
            saltosRealizados = 0
            self.correr()
        }
    }

    method estaEnElAire() = position.y() > 1

    method cambiarEstado(nuevoEstado) {
        estado = nuevoEstado
        self.animacionActual().reiniciar()
    }

    method avanzarFrame() {
        self.animacionActual().avanzar()
        if (self.animacionActual().terminoUnaVuelta()) estado.alTerminar(self)
    }

    method quedarEnUltimoFrame() {
        self.animacionActual().irAlUltimo()
    }

    method mostrarEnMenu() {
        position = posicionEnMenu
        game.addVisual(self)
    }

    method puedeSaltar() = saltosRealizados < maximoDeSaltos

    method impulsarse() {
        position = position.up(1)
        saltosRealizados = saltosRealizados + 1
        self.cambiarEstado(saltando)
    }
}

const personaje1 = new Personaje(
    animacionCorriendo = new Animacion(carpeta = "personaje-1", nombre = "corriendo", cantidad = 10),
    animacionSaltando = new Animacion(carpeta = "personaje-1", nombre = "saltando", cantidad = 10),
    animacionDeslizando = new Animacion(carpeta = "personaje-1", nombre = "deslizando", cantidad = 10),
    posicionEnMenu = game.at(4, 3)
)

const personaje2 = new Personaje(
    animacionCorriendo = new Animacion(carpeta = "personaje-2", nombre = "corriendo", cantidad = 8),
    animacionSaltando = new Animacion(carpeta = "personaje-2", nombre = "saltando", cantidad = 10),
    animacionDeslizando = new Animacion(carpeta = "personaje-2", nombre = "deslizando", cantidad = 5),
    posicionEnMenu = game.at(6, 3)
)   

const personaje3 = new Personaje(
    animacionCorriendo = new Animacion(carpeta = "personaje-3", nombre = "corriendo", cantidad = 8),
    animacionSaltando = new Animacion(carpeta = "personaje-3", nombre = "saltando", cantidad = 10),
    animacionDeslizando = new Animacion(carpeta = "personaje-3", nombre = "deslizando", cantidad = 10),
    posicionEnMenu = game.at(8, 3)
)