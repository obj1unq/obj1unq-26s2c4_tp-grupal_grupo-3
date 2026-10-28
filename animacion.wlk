
// Arma la lista "carpeta/nombre_0.png" ... "carpeta/nombre_(cantidad-1).png"
object secuencia {
    method de(carpeta, nombre, cantidad) = (0 .. cantidad - 1).map({ n => carpeta + "/" + nombre + "_" + n + ".png" })
}


class Animacion {
    const imagenes
    var frame = 0

    method imagen() = imagenes.get(frame)

    method avanzar() {
        frame = (frame + 1) % imagenes.size()
    }

    method terminoUnaVuelta() = frame == 0

    method reiniciar() {
        frame = 0
    }

    method irAlUltimo() {
        frame = imagenes.size() - 1
    }

}