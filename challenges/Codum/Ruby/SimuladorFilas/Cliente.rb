class Cliente

  #Recibe un numero que indica el numero del cliente
  def initialize
    #se llama al metodo asignarChar
    #Se utiliza .chr que devuelve el caracter en ascii del numero ingresado
    @nombre = asignarChar.chr
    #Se genera un numero aleatorio para la duracion del cliente
    @duracion = rand(4..25)
  end

  #metodo que evita que el numero aleatorio sea 99 es decir el caracter c
  def asignarChar
    val = rand(97..121)
    if val == 99
      asignarChar
    else
      return val
    end
  end

  def getDuracion
    return @duracion
  end

  def getNombre
      return @nombre
  end

end