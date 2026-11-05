import wollok.game.*


class Obstaculo {
    
    var property posicionObs 

  
    method image()

    method spawnear() {
        game.addVisual(self)
        posicionObs = game.at(12, 0)
    }

    method yaAtravesoLaPantalla() {
        return posicionObs.x() == 0
    }
    
    method salirDePantalla() {
        game.removeVisual(self)
    }

    method chocar(unPersonaje) {
        unPersonaje.perder()
    }

    method colisionoCon(unPersonaje) {
        return unPersonaje.position() == posicionObs
    } 
}
 const spawnearObstaculo = game.tick(2000, "spawnearObstaculo", {Obstaculo.posicionObs().left(1)} )
 const moverObstaculo = game.tick(200, "moverObstaculo", {Obstaculo.posicionObs().left(1)} )

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