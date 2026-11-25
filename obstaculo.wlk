import wollok.game.*

object generadorDeObstaculos {
    const obstaculos = []
    var proveedorImagenesTerrestres = null
    var proveedorImagenesAereos = null
    var alEsquivar = null
    var activado = false
    var tiempoEntreFrames = 250

    method cambiarVelocidadDesplazamiento(milisegundos) {
        tiempoEntreFrames = milisegundos
    }

    method iniciar(imagenesTerrestres, imagenesAereos, accionAlEsquivar) {
        proveedorImagenesTerrestres = imagenesTerrestres
        proveedorImagenesAereos = imagenesAereos
        alEsquivar = accionAlEsquivar
        self.activar()
        self.siguienteObstaculo()
        game.onTick(tiempoEntreFrames, "moverObstaculos", {
            self.moverYLimpiar()
        })
    }

    method siguienteObstaculo() {
        const tiempoAleatorio = (800..2500).anyOne()
        game.schedule(tiempoAleatorio, {
           if (activado) { 
                self.crearObstaculo()
           } 
           self.siguienteObstaculo()
        })
    }

    method crearObstaculo() {
        // Para crear mas terrestres que aereos
        const bloqueCreador = [
            {self.crearTerrestre()}, 
            {self.crearTerrestre()}, 
            {self.crearTerrestre()}, 
            {self.crearAereo()}
        ]
        bloqueCreador.anyOne().apply()
    }

    method crearTerrestre() {
        self.agregar(new ObstaculoTerrestre(
            position = game.at(game.width(), 1),
            image = proveedorImagenesTerrestres.apply()
        ))
    }

    method crearAereo() {
        self.agregar(new ObstaculoAereo(
            position = game.at(game.width(), 2),
            image = proveedorImagenesAereos.apply()
        ))
    }

    method agregar(obstaculo) {
        obstaculos.add(obstaculo)
        game.addVisual(obstaculo)
    }

    method moverYLimpiar() {
        obstaculos.forEach({ obstaculo => obstaculo.desplazar() })
        const fueraDePantalla = obstaculos.filter({ obstaculo => obstaculo.salioDePantalla() })
        fueraDePantalla.forEach({ obstaculo =>
            game.removeVisual(obstaculo)
            obstaculos.remove(obstaculo)
            if ( not obstaculo.colisionado()) { alEsquivar.apply(obstaculo.puntosQueAporta()) }
            
        })
    }

    method activar () {
        activado = true
    }

    method detener() {
        activado = false
    }
}

class Obstaculo {
    var property position 
    const property image
    var colisionado = false

    method desplazar() {
        position = self.position().left(1)
    }

    method salioDePantalla() = self.position().x() < 0

    method spawnear() {
        game.addVisual(self)
        position = game.at(12, 0)
    }

   method colisionar() {
        colisionado = true
    }

    method colisionado() {
        return colisionado
    }

    method puntosQueAporta() 
}

class ObstaculoTerrestre inherits Obstaculo {
    override method puntosQueAporta() {
        return 10
    }
}

class ObstaculoAereo inherits Obstaculo {
     override method puntosQueAporta() {
        return 0
    }
}



