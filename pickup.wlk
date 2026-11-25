import wollok.game.*
import obstaculo.*

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
        const tiempoAleatorio = (3000..10000).anyOne()
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
            {self.crearModoDificil()}
        ]
        bloqueCreador.anyOne().apply()
    }

    method crearTurbo() {
        self.agregarP(new Turbo(
            position = game.at(game.width(), [0,1,2].anyOne()),
            image = "turbo.png",
            colisionado = false
        ))
    }

    method crearSumaDePuntos() {
        self.agregarP(new SumaDePuntos(
            position = game.at(game.width(), [0,1,2].anyOne()),
            image = "suma_de_puntos.png",
            colisionado = false
        ))
    }

    method crearModoDificil() {
        self.agregarP(new ModoDificil(
            position = game.at(game.width(), [0,1,2].anyOne()),
            image = "modo_dificil.png",
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

  

   method colisionarP() {
        colisionado = true
    }

    method colisionadoP() {
        return colisionado
    }

}

class SumaDePuntos inherits Pickup {

}

class ModoDificil inherits Pickup {

}

class Turbo inherits Pickup {
   

   
}
