import animacion.*

class Nivel {
    const property animacionFondo
    const property imagenesObstaculosTerrestres
    const property imagenesObstaculosAereos
    const puntosParaPasar
 
    method terminar(unaPartida)

    method superado(puntos) {
        return puntos >= puntosParaPasar
    }
}

class NivelIntermedio inherits Nivel {
    const animacionTransicion
    const siguienteNivel

    override method terminar(unaPartida) {
        unaPartida.manejarCambioNivel(animacionTransicion)
    }

    method siguiente() {
        return siguienteNivel
    }
}

class UltimoNivel inherits Nivel {
    override method terminar(unaPartida) {
        unaPartida.ganar()
    }
}

const nivel1 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "nivel-1-bosque/fondo", nombre = "fondo", cantidad = 10),
    animacionTransicion = new Transicion(carpeta = "nivel-1-bosque/transicion", nombre = "transicion", cantidad = 10),
    imagenesObstaculosTerrestres = ["nivel-1-bosque/obstaculos/terrestres/stone.png", "nivel-1-bosque/obstaculos/terrestres/crate.png", "nivel-1-bosque/obstaculos/terrestres/mushroom.png", "nivel-1-bosque/obstaculos/terrestres/bush.png"],
    imagenesObstaculosAereos = ["nivel-1-bosque/obstaculos/aereos/ave.gif"],
    puntosParaPasar = 100,
    siguienteNivel = nivel2
)

const nivel2 = new NivelIntermedio(
    animacionFondo = new Animacion(carpeta = "nivel-2-desierto/fondo", nombre = "fondo", cantidad = 10),
    animacionTransicion = new Transicion(carpeta = "nivel-2-desierto/transicion", nombre = "transicion", cantidad = 10),
    imagenesObstaculosTerrestres = ["nivel-2-desierto/obstaculos/terrestres/stone.png", "nivel-2-desierto/obstaculos/terrestres/cactus_1.png", "nivel-2-desierto/obstaculos/terrestres/skeleton.png", "nivel-2-desierto/obstaculos/terrestres/cactus_2.png"],
    imagenesObstaculosAereos = ["nivel-2-desierto/obstaculos/aereos/buitre.gif"],
    puntosParaPasar = 200,
    siguienteNivel = nivel3
)

const nivel3 = new UltimoNivel(
    animacionFondo = new Animacion(carpeta = "nivel-3-cementerio/fondo", nombre = "fondo", cantidad = 10),
    imagenesObstaculosTerrestres = ["nivel-3-cementerio/obstaculos/terrestres/tomb-stone-1.png", "nivel-3-cementerio/obstaculos/terrestres/skeleton.png", "nivel-3-cementerio/obstaculos/terrestres/tomb-stone-2.png"],
    imagenesObstaculosAereos = ["nivel-3-cementerio/obstaculos/aereos/murcielago.gif"],
    puntosParaPasar = 300
)