import wollok.game.*

// Movimientos
object corriendo {
    method imagenes(personaje) = personaje.imagenesCorriendo()
    method alTerminar(personaje) { }
}

object saltando {
    method imagenes(personaje) = personaje.imagenesSaltando()
    method alTerminar(personaje) { personaje.correr() }
}

object deslizando {
    method imagenes(personaje) = personaje.imagenesDeslizando()
    method alTerminar(personaje) { personaje.correr() }
}


// Arma la lista "carpeta/nombre_0.png" ... "carpeta/nombre_(cantidad-1).png"
object secuencia {
    method de(carpeta, nombre, cantidad) = (0 .. cantidad - 1).map({ n => carpeta + "/" + nombre + "_" + n + ".png" })
}


// Personaje
class Personaje {
    const property imagenesCorriendo
    const property imagenesSaltando
    const property imagenesDeslizando
    var property position = game.at(0, 0)
    var estado = corriendo
    var frame = 0

    method inicializar() {
        keyboard.w().onPressDo({self.saltar()})
        keyboard.a().onPressDo({self.deslizar()})
        game.onTick(80, "animacion", {self.avanzarFrame()})
    }

    method imagenesActuales() = estado.imagenes(self)

    method image() = self.imagenesActuales().get(frame)

    method correr() {
        self.cambiarEstado(corriendo)
    }

    method saltar() {
        self.cambiarEstado(saltando)
    }

    method deslizar() {
        self.cambiarEstado(deslizando)
    }

    method cambiarEstado(nuevoEstado) {
        estado = nuevoEstado
        frame = 0
    }

    method avanzarFrame() {
        frame = (frame + 1) % self.imagenesActuales().size()
        if (frame == 0) estado.alTerminar(self)
    }
}

const personaje1 = new Personaje(
    imagenesCorriendo = secuencia.de("personaje", "corriendo", 10),
    imagenesSaltando = secuencia.de("personaje", "saltando", 10),
    imagenesDeslizando = secuencia.de("personaje", "deslizando", 10)
)
