
class Animacion {
    const carpeta
    const nombre
    const cantidad
    var frame = 0

    method imagen() = carpeta + "/" + nombre + "_" + frame + ".png"

    method avanzar() {
        frame = (frame + 1) % cantidad
    }

    method terminoUnaVuelta() = frame == 0

    method reiniciar() {
        frame = 0
    }

    method irAlUltimo() {
        frame = cantidad - 1
    }

    method alTerminar(unFondo) { }
}

class Transicion inherits Animacion {
    const property destino

    override method alTerminar(unFondo) {
        unFondo.mostrar(destino.animacionFondo())
    }
}
