import animacion.*
import fondo.*

class Nivel {
    const property animacionFondo
    const property imagenesObstaculos
 
    method terminar(unaPartida)

}

class NivelIntermedio inherits Nivel {
    const animacionTransicion

    override method terminar(unaPartida) {
        unaPartida.nivel(animacionTransicion.siguienteNivel())
        unaPartida.mostrarTransicion(animacionTransicion)
    }
}

class UltimoNivel inherits Nivel {
    override method terminar(unaPartida) {
        unaPartida.ganar()
    }
}

const nivel1 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "nivel-1-bosque/fondo", nombre = "fondo", cantidad = 10),
    animacionTransicion = new Transicion(carpeta = "nivel-1-bosque/transicion", nombre = "transicion", cantidad = 10, siguienteNivel = nivel2),
    imagenesObstaculos = ["nivel-1-bosque/obstaculos/stone.png", "nivel-1-bosque/obstaculos/crate.png", "nivel-1-bosque/obstaculos/mushroom.png", "nivel-1-bosque/obstaculos/bush.png"]
)

const nivel2 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "nivel-2-desierto/fondo", nombre = "fondo", cantidad = 10),
    animacionTransicion = new Transicion(carpeta = "nivel-2-desierto/transicion", nombre = "transicion", cantidad = 10, siguienteNivel = nivel3),
    imagenesObstaculos = ["nivel-2-desierto/obstaculos/stone.png", "nivel-2-desierto/obstaculos/cactus_1.png", "nivel-2-desierto/obstaculos/skeleton.png", "nivel-2-desierto/obstaculos/cactus_2.png"]
)

const nivel3 = new UltimoNivel(
    animacionFondo = new Animacion(carpeta = "nivel-3-cementerio/fondo", nombre = "fondo", cantidad = 10),
    imagenesObstaculos = ["nivel-3-cementerio/obstaculos/dead-bush.png", "nivel-3-cementerio/obstaculos/tomb-stone-1.png", "nivel-3-cementerio/obstaculos/skeleton.png", "nivel-3-cementerio/obstaculos/tomb-stone-2.png"]
)