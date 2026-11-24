import menu.*
import fondo.*
import nivel.*
import obstaculo.*
import wollok.game.*

class Partida {
    const personaje
    const fondoPartida = fondo
    const generadorObstaculos = generadorDeObstaculos
    const marcador = new Texto(position = game.at(game.width() - 2, game.height() - 1), text = "Puntos: 0")
    var puntos = 0
    var nivel = nivel1

    method iniciar() {
        game.clear()
        fondoPartida.iniciar(nivel.animacionFondo())
        game.addVisual(marcador)
        personaje.iniciar()
        generadorObstaculos.iniciar(
            { nivel.imagenesObstaculosTerrestres().anyOne() },
            { nivel.imagenesObstaculosAereos().anyOne() },
            {puntosGanados => self.sumar(puntosGanados)}
        )
        game.onCollideDo(personaje, { obstaculo =>
            game.say(personaje, "Opa! Me llevé puesto un obstaculo!")
            obstaculo.colisionar()
            self.restar(10)
        })
    }

    method puntos() {
        return puntos
    }

    method sumar(cantidad) {
        puntos = puntos + cantidad
        self.actualizarMarcador()
        if (nivel.superado(puntos)) {
            self.pasarDeNivel()
        }
    }

    method restar(cantidad) {
        self.validarPuntos(cantidad)
        puntos = puntos - cantidad
        self.actualizarMarcador()
    }

    method validarPuntos(cantidad) {
        if (puntos - cantidad < 0) {
            self.perder()
        }
    }

    method actualizarMarcador() {
        marcador.text("Puntos: " + puntos)
    }

    method manejarCambioNivel(animacionTransicion) {
        generadorObstaculos.detener()
        animacionTransicion.accionFinal({ self.comenzarNivel() })
        fondoPartida.mostrar(animacionTransicion)
        nivel = nivel.siguiente()
    }

    method pasarDeNivel() {
        nivel.terminar(self)
    }

    method comenzarNivel(){
        generadorObstaculos.activar()
        fondoPartida.mostrar(nivel.animacionFondo())
    }

    method ganar() {
        self.terminar("GANASTE!")
    }

    method perder() {
        self.terminar("GAME OVER")
    }

    method terminar(mensaje) {
        game.clear()
        game.addVisual(new Texto(position = game.center(), text = mensaje))
        game.schedule(3000, { game.stop() })
    }
}
