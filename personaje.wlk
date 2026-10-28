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
    var property position = game.at(0, 0)
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
        position = position.up(1)
        self.cambiarEstado(saltando)
    }
    
    method deslizar() {
        if (not self.estaEnElAire()) self.cambiarEstado(deslizando)
    }

    method caer() {
        if (self.estaEnElAire()) {
            position = position.down(1)
        } else {
            self.correr()
        }
    }

    method estaEnElAire() = position.y() > 0

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
}

const personaje1 = new Personaje(
    animacionCorriendo = new Animacion(imagenes = secuencia.de("personaje-1", "corriendo", 10)),
    animacionSaltando = new Animacion(imagenes = secuencia.de("personaje-1", "saltando", 10)),
    animacionDeslizando = new Animacion(imagenes = secuencia.de("personaje-1", "deslizando", 10))
)

const personaje2 = new Personaje(
    animacionCorriendo = new Animacion(imagenes = secuencia.de("personaje-2", "corriendo", 8)),
    animacionSaltando = new Animacion(imagenes = secuencia.de("personaje-2", "saltando", 10)),
    animacionDeslizando = new Animacion(imagenes = secuencia.de("personaje-2", "deslizando", 5))
)   

const personaje3 = new Personaje(
    animacionCorriendo = new Animacion(imagenes = secuencia.de("personaje-3", "corriendo", 8)),
    animacionSaltando = new Animacion(imagenes = secuencia.de("personaje-3", "saltando", 10)),
    animacionDeslizando = new Animacion(imagenes = secuencia.de("personaje-3", "deslizando", 10))
)