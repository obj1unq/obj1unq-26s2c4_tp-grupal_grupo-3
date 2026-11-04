import wollok.game.*

object fondo {
    var animacion = null

    method position() = game.origin()

    method image() = animacion.imagen()

    method mostrar(nuevaAnimacion) {
        animacion = nuevaAnimacion
        animacion.reiniciar()
    }

    method avanzarFrame() {
        animacion.avanzar()
        if (animacion.terminoUnaVuelta()) animacion.alTerminar(self)
    }

    method iniciar(animacionInicial) {
        self.mostrar(animacionInicial)
        game.addVisual(self)
        game.onTick(80, "fondo", {self.avanzarFrame()})
    }

}