
class Animacion {
    const carpeta
    const nombre
    const cantidad
    var frame = 0

    method imagen() = carpeta + "/" + nombre + "_" + frame + ".png"

    method avanzar() {
        frame = (frame + 1) % cantidad
    }

    method reiniciar() {
        frame = 0
    }

    method irAlUltimo() {
        frame = cantidad - 1
    }

    method esElUltimo() = frame == cantidad - 1
}

class Transicion inherits Animacion {
    var property accionFinal = {}

    override method avanzar() {
        if (self.esElUltimo()) accionFinal.apply() else super()
    }
}
