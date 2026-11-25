import wollok.game.*
import partida.*
import menu.*

object generadorDePickUps {
    const pickups = []
    var activado = false
    var tiempoEntreFramesP = 250

    method cambiarVelocidadDesplazamientoP(milisegundos) {
        tiempoEntreFramesP = milisegundos
    }

    method iniciarP() {
        self.activarP()
        self.siguientePickUp()
        game.onTick(tiempoEntreFramesP, "moverPickUps", {
            self.moverYLimpiarP()
        })
    }

    method siguientePickUp() {
        const tiempoAleatorio = (8000..10000).anyOne()
        game.schedule(tiempoAleatorio, {
           if (activado) { 
                self.crearPickUp()
           } 
           self.siguientePickUp()
        })
    }

    method crearPickUp() {
        // Para crear mas terrestres que aereos
        const bloqueCreador = [
            {self.crearTurbo()}, 
            {self.crearSumaDePuntos()}, 
            {self.crearModoDificil()},
            {self.crearModoNormal()},
            {self.crearFreno()},
            {self.crearSumaEnormeDePuntos()},
            {self.crearSumaDePuntos()},
            {self.crearSumaDePuntos()},
            {self.crearTurbo()},
            {self.crearFreno()},
            {self.crearModoNormal()}
        ]
        bloqueCreador.anyOne().apply()
    }

    method crearTurbo() {
        self.agregarP(new Turbo(
            position = game.at(game.width(), [3,1,2].anyOne()),
            image = "turbo.png",
            colisionado = false
        ))
    }

    method crearFreno() {
        self.agregarP(new Freno(
            position = game.at(game.width(), [3,1,2].anyOne()),
            image = "freno.png",
            colisionado = false
        ))
    }

    method crearSumaDePuntos() {
        self.agregarP(new SumaDePuntos(
            position = game.at(game.width(), [1,2,3].anyOne()),
            image = "suma_de_puntos.png",
            colisionado = false
        ))
    }

    method crearSumaEnormeDePuntos() {
        self.agregarP(new SumaEnormeDePuntos(
            position = game.at(game.width(), [1,2,3].anyOne()),
            image = "suma_enorme_de_puntos.png",
            colisionado = false
        ))
    }

    method crearModoDificil() {
        self.agregarP(new ModoDificil(
            position = game.at(game.width(), [3,1,2].anyOne()),
            image = "modo_dificil.png",
            colisionado = false
        ))
    }

    method crearModoNormal() {
        self.agregarP(new ModoNormal(
            position = game.at(game.width(), [3,1,2].anyOne()),
            image = "modo_normal.png",
            colisionado = false
        ))
    }

    method agregarP(pickup) {
        pickups.add(pickup)
        game.addVisual(pickup)
    }

    method moverYLimpiarP() {
        pickups.forEach({ pickup => pickup.desplazarP() })
        const fueraDePantalla = pickups.filter({ pickup => pickup.salioDePantallaP() })
        fueraDePantalla.forEach({ pickup =>
            game.removeVisual(pickup)
            pickups.remove(pickup)
        
            
        })
    }

    method activarP () {
        activado = true
    }

    method detenerP() {
        activado = false
    }
}




class Pickup {
    var property position
    var property image
    var property colisionado
      method desplazarP() {
        position = self.position().left(1)
    }

    method salioDePantallaP() = self.position().x() < 0

    method serRecogido() {
        game.removeVisual(self)
    }
    
    method hacerEfecto(unaPartida)

   method colisionarP() {
        colisionado = true
    }

    method colisionadoP() {
        return colisionado
    }

}

class SumaDePuntos inherits Pickup {
    
   override method hacerEfecto(unaPartida) {
    game.say(unaPartida.personaje(), "¡QUE BIEN!")
        unaPartida.sumar(25)
   }
}

class SumaEnormeDePuntos inherits Pickup {
   override method hacerEfecto(unaPartida) {
        game.say(unaPartida.personaje(), "¡GENIAL!")
        unaPartida.sumar(100)
   }
}

class ModoDificil inherits Pickup {

    override method hacerEfecto(unaPartida) {
       game.say(unaPartida.personaje(), "¡MODO DIFICIL ACTIVADO!")
       unaPartida.cambiarPuntajeARestarPorObs(50)
       game.addVisual(self.indicadorModoDificil())
   }
}

class ModoNormal inherits Pickup {
    override method hacerEfecto(unaPartida) {
        game.say(unaPartida.personaje(), "MODO NORMAL")
       unaPartida.cambiarPuntajeARestarPorObs(10)
       game.removeVisual(self.indicadorModoDificil())
   }
}

class Turbo inherits Pickup {
   
    override method hacerEfecto(unaPartida) {
        game.say(unaPartida.personaje(), "¡VELOCIDAD AUMENTADA!")
        unaPartida.generadorDeObstaculos().cambiarVelocidadDesplazamiento(150) 
        game.addVisual(self.indicadorTurbo())
    }
}

class Freno inherits Pickup {
   
    override method hacerEfecto(unaPartida) {
        game.say(unaPartida.personaje(), "VELOCIDAD NORMAL")
        unaPartida.generadorDeObstaculos().cambiarVelocidadDesplazamiento(250) 
        game.removeVisual(self.indicadorTurbo())
    }
}