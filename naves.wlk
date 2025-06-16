class Nave{
  var velocidad
  var direccionSol //int -10, 0 o 10

  method acelerar(cuanto){
    velocidad = 10000.min(velocidad + cuanto)
  }
  method desacelerar(cuanto){
    velocidad = 0.max(velocidad - cuanto)
  }

  method irHaciaElSol(){
    direccionSol = 10
  }

  method escaparDelSol(){
    direccionSol = -10
  }

  method ponerseParaleloAlSol(){
    direccionSol = 0
  }

  method acercarseUnPocoAlSol(){
    direccionSol = 10.min(direccionSol + 1)
  }
  method alejarseUnPocoDelSol(){
    direccionSol = -10.max(direccionSol - 1)
  }

  method prepararViaje()
}

class NaveBaliza inherits Nave{
  var colorBaliza

  method colorBaliza() = colorBaliza

  method cambiarColorDeBaliza(colorNuevo){
    colorBaliza = colorNuevo
  }

  // override method prepararViaje() = true
}

class NavePasajeros inherits Nave{
  var property cantPasajeros
  var property cantRacComida
  var property cantRacBebida

  // override method prepararViaje() = true
}

class NaveCombate inherits Nave{
  var estaVisible
  var misilesFueronDesplegados
  const mensajesEmitidos = [] //lista de strings

  method ponerseVisible(){
    estaVisible = true
  }

  method ponerseInvisible(){
    estaVisible = false
  }

  method estaInvisible() = estaVisible

  method desplegarMisiles(){
    misilesFueronDesplegados = true
  }

  method replegarMisiles(){
    misilesFueronDesplegados = false
  }

  method misilesDesplegados() = misilesFueronDesplegados

  method emitirMensaje(mensaje){
    mensajesEmitidos.add(mensaje)
  }

  method mensajesEmitidos() = mensajesEmitidos


  method primerMensajeEmitido() = if(self.emitioAlgunMensaje()) mensajesEmitidos.first()
  

  method ultimoMensajeEmitido() = if(self.emitioAlgunMensaje()) mensajesEmitidos.last()

  method esEscueta() = if(self.emitioAlgunMensaje()) mensajesEmitidos.all({m => m.length() < 30})

  method emitioMensaje(unMensaje) = mensajesEmitidos.contains(unMensaje)

  method emitioAlgunMensaje() = mensajesEmitidos.size() > 0

  // override method prepararViaje() = true
}