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
    }

    method iniciar(animacionInicial) {
        self.mostrar(animacionInicial)
        game.addVisual(self)
        game.onTick(80, "fondo", {self.avanzarFrame()})
    }

}