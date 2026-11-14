import animacion.*
import fondo.*

class Nivel {
    const property animacionFondo

    method terminar(unaPartida)
}

class NivelIntermedio inherits Nivel {
    const animacionTransicion

    override method terminar(unaPartida) {
        unaPartida.nivel(animacionTransicion.siguienteNivel())
        unaPartida.fondoPartida().mostrar(animacionTransicion)
    }
}

class UltimoNivel inherits Nivel {
    override method terminar(unaPartida) {
        unaPartida.ganar()
    }
}

const nivel1 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "fondo-1", nombre = "fondo", cantidad = 10),
    animacionTransicion = new Transicion(carpeta = "transicion-1-2", nombre = "transicion", cantidad = 10, siguienteNivel = nivel2)
)

const nivel2 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "fondo-2", nombre = "fondo", cantidad = 10),
    animacionTransicion = new Transicion(carpeta = "transicion-2-3", nombre = "transicion", cantidad = 10, siguienteNivel = nivel3)
)

const nivel3 = new UltimoNivel(
    animacionFondo = new Animacion(carpeta = "fondo-3", nombre = "fondo", cantidad = 10)
)