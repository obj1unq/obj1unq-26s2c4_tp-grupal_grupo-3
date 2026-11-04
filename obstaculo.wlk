import wollok.game.*


class Obstaculo {
    
    var property posicionObs = game.at(12, 0)

  
    method image()

    method yaAtravesoLaPantalla() {
        return posicionObs.x() == 0
    }
    
   

    method colisionoCon(unPersonaje) {
        return unPersonaje.position() == posicionObs
    } 
}

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