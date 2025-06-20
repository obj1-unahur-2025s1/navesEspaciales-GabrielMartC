class Nave{
  var velocidad
  var direccionSol //int -10, 0 o 10
  var combustible

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

  method cargarCombustible(unaCantidad) {
    combustible = combustible + unaCantidad
  }

  method descargarCombustible(unaCantidad) {
    combustible = 0.max(combustible - unaCantidad)
  }

  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTranquila() = combustible >= 4000 && velocidad <= 12000

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method escapar()
  method avisar()
}

class NaveBaliza inherits Nave{
  var colorBaliza

  method colorBaliza() = colorBaliza

  method cambiarColorDeBaliza(colorNuevo){
    colorBaliza = colorNuevo
  }

  override method prepararViaje(){
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method estaTranquila() = super() && colorBaliza != "rojo"

  override method escapar(){
    self.irHaciaElSol()
  }
  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
}

class NavePasajeros inherits Nave{
  var cantPasajeros
  var cantRacComida
  var cantRacBebida

  method cantPasajeros() = cantPasajeros
  method cantRacComida() = cantRacComida
  method cantRacBebida() =  cantRacBebida

  override method prepararViaje(){
    super()
    cantRacComida = 4 * cantPasajeros
    cantRacBebida = 6 * cantPasajeros
    self.acercarseUnPocoAlSol()
  }

  override method escapar(){
    self.acelerar(velocidad * 2)

  }
  override method avisar(){
    cantRacComida = 0.min(cantRacComida - cantPasajeros)
    cantRacBebida = 0.min(cantRacBebida - (cantPasajeros * 2))
  }

 
}

class NaveCombate inherits Nave{
  var estaVisible
  // var misilesFueronDesplegados
  const misiles //[] lista de Misil
  const mensajesEmitidos//lista de strings

  method ponerseVisible(){
    estaVisible = true
  }

  method ponerseInvisible(){
    estaVisible = false
  }

  method estaInvisible() = estaVisible

  method desplegarMisiles(){
    misiles.forEach({m => m.desplegar()})
  }

  method replegarMisiles(){
    misiles.forEach({m => m.replegar()})
  }

  method misilesDesplegados() = misiles.count({m => m.estaDesplegado()})


  // method desplegarMisiles(){
  //   misilesFueronDesplegados = true
  // }

  // method replegarMisiles(){
  //   misilesFueronDesplegados = false
  // }

  // method misilesDesplegados() = misilesFueronDesplegados

  method emitirMensaje(mensaje){
    mensajesEmitidos.add(mensaje)
  }

  method mensajesEmitidos() = mensajesEmitidos


  method primerMensajeEmitido() = if(self.emitioAlgunMensaje()) mensajesEmitidos.first() else self.error("No hay mensajes emitidos")

  method ultimoMensajeEmitido() = if(self.emitioAlgunMensaje()) mensajesEmitidos.last() else self.error("No hay mensajes emitidos")

  method esEscueta() = if(self.emitioAlgunMensaje()) mensajesEmitidos.all({m => m.length() < 30})

  method emitioMensaje(unMensaje) = mensajesEmitidos.contains(unMensaje)

  method emitioAlgunMensaje() = mensajesEmitidos.size() > 0

  override method prepararViaje(){
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }

  override method estaTranquila() = super() && self.todosLosMisilesNoEstanDesplegados()

  method todosLosMisilesNoEstanDesplegados() = misiles.all({m => !m.estaDesplegado()})

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar(){
    self.emitirMensaje("Amenaza recibida")
  }
}


class Misil{
  var estaDesplegado

  method estaDesplegado() = estaDesplegado

  method desplegar(){
    estaDesplegado = true
  }

  method replegar(){
    estaDesplegado = false
  }
}

class NaveHospital inherits NavePasajeros{
  const quirofanos // []

  method quirofanosEstanPreparados() = quirofanos.all({quir => quir.estaPreparado()}) 

  override method estaTranquila() = super() && !self.quirofanosEstanPreparados()

  override method recibirAmenaza(){
    super()
    self.prepararQuirofanos()
  }

  method prepararQuirofanos(){
    quirofanos.forEach({quir => quir.prepararse()})
  }
}

class Quirofano{
  var estaPreparado

  method estaPreparado() = estaPreparado

  method prepararse(){ 
    estaPreparado = true
  }
}

class NaveCombateSigilosa inherits NaveCombate{
  override method estaTranquila() = super() && estaVisible

  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}