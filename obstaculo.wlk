import wollok.game.*
import nivel.*

object generadorDeObstaculos {
    const obstaculos = []
    var proveedorImagenes = null
    
    method iniciar(imagenesObstaculos) {
        proveedorImagenes = imagenesObstaculos
        self.siguienteObstaculo()
        game.onTick(300, "moverObstaculos", {
            self.moverYLimpiar()
        })
    }

    method siguienteObstaculo() {
        const tiempoAleatorio = (800..2500).anyOne()
        game.schedule(tiempoAleatorio, {
            self.crearObstaculo()
            self.siguienteObstaculo() 
        })
    }

    method crearObstaculo() {
        const nuevo = new Obstaculo(position = game.at(game.width(), 1), image = proveedorImagenes.apply())
        obstaculos.add(nuevo)
        game.addVisual(nuevo)
    }

    method moverYLimpiar() {
        obstaculos.forEach({ obstaculo => obstaculo.desplazar() })
        const fueraDePantalla = obstaculos.filter({ obstaculo => obstaculo.salioDePantalla() })
        fueraDePantalla.forEach({ obstaculo =>
            game.removeVisual(obstaculo)
            obstaculos.remove(obstaculo)
        })
    }

    method detener() {
        game.removeTickEvent("moverObstaculos")
    }
}

class Obstaculo {
    
    var property position 
    var property image

    method desplazar() {
        position = self.position().left(1)
    }

    method salioDePantalla() = self.position().x() < 0

    method spawnear() {
        game.addVisual(self)
        position = game.at(12, 0)
    }

    method colisionoCon(unPersonaje) {
        return unPersonaje.position() == self.position()
    } 
}



