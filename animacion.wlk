
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
}