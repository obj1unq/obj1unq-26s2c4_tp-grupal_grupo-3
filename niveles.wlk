import animacion.*
import fondo.*

class Nivel {
    const property animacionFondo

    method terminar(unaPartida)
}

class NivelIntermedio inherits Nivel {
    const transicion

    override method terminar(unaPartida) {
        unaPartida.nivel(transicion.destino())
        fondo.mostrar(transicion)
    }
}

class UltimoNivel inherits Nivel {
    override method terminar(unaPartida) {
        unaPartida.ganar()
    }
}

const nivel1 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "fondo-1", nombre = "fondo", cantidad = 10),
    transicion = new Transicion(carpeta = "transicion-1-2", nombre = "transicion", cantidad = 10, destino = nivel2)
)

const nivel2 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "fondo-2", nombre = "fondo", cantidad = 10),
    transicion = new Transicion(carpeta = "transicion-2-3", nombre = "transicion", cantidad = 10, destino = nivel3)
)

const nivel3 = new UltimoNivel(
    animacionFondo = new Animacion(carpeta = "fondo-3", nombre = "fondo", cantidad = 10)
)