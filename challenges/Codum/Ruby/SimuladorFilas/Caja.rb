require_relative "Cliente"

class Caja

	def initialize
		@nombre = 'C'
		@ocupada = false
		@tiempoRestante = 0
		@tiempoPromedio = 0
		@clientesAtendidos = 0
		@clienteEnCaja = nil
		
	end
	#Retorna la disponibilidad de la caja
	def isOcupada
		return @ocupada
	end
	#Retorna el tiempo de atención restante en la caja
	def getTiempoRestante
		return @tiempoRestante
	end
	
	def getNombre
		return @nombre
	end
	
	def atenderCliente clienteEnCaja
		@ocupada = true
		@clienteActual = clienteEnCaja
		@tiempoRestante = clienteEnCaja.getDuracion
		#se añade el tiempo que el cliente tardara y se añade un contador (como flotante para realizar posteriormente una division)
		@tiempoPromedio += @tiempoRestante
		@clientesAtendidos += "1.0".to_f
	end
	
	def getCliente
		return @clienteActual
	end
	
	def finalizarAtencion
		@ocupada = false
	end
	
	def reducir
    if(@tiempoRestante>0)
      @tiempoRestante = @tiempoRestante-1
	else
		finalizarAtencion
    end
	
	def getPromedio
		#resta el tiempo que le falto al cliente para salir de la caja
		@tiempoPromedio -= @tiempoRestante
		return @tiempoPromedio/@clientesAtendidos
	end
  end
end