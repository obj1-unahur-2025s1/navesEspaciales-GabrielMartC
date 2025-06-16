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
}