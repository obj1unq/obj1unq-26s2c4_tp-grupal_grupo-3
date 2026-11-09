import wollok.game.*


object generadorDeObstaculos {
    const obstaculos = []
    
    method iniciar() {
        self.siguienteObstaculo()
        game.onTick(50, "moverObstaculos", {
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
        const nuevo = new ObstaculoTipo1(posicionObs = game.at(game.width(), 1))
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
    
    var property posicionObs 

  
    method image()

    method desplazar() {
        posicionObs = posicionObs.left(1)
    }

    method salioDePantalla() = posicionObs.x() < 0

    method spawnear() {
        game.addVisual(self)
        posicionObs = game.at(12, 0)
    }

    
    
    method salirDePantalla() {
        game.removeVisual(self)
    }


    method colisionoCon(unPersonaje) {
        return unPersonaje.position() == posicionObs
    } 
}


class ObstaculoTipo1 inherits Obstaculo {
    override method image() {
        return ["Stone.png", "Crate.png", "Mushroom_1.png", "Bush (3).png"].anyOne()
    }
}

class ObstaculoTipo2 inherits Obstaculo {
    override method image() {
        return ["Stone (2).png", "Cactus (1).png", "Skeleton.png", "Cactus (3).png"].anyOne()
    }
}

class ObstaculoTipo3 inherits Obstaculo {
    override method image() {
        return ["DeadBush.png", "TombStone (1).png", "Skeleton.png", "TombStone (2).png"].anyOne()
    }
}


