require_relative "Caja"
require_relative "Cliente"

class FilaSimple
	def initialize numCajas, tiempo, deltaT
		@cajasMercado = []
		for i in 0..numCajas
		cajaTemp = Caja.new()
			@cajasMercado[i] = cajaTemp
		end
		@tiempo = tiempo
		@clientesEnCola = Array.new
		@deltaT = deltaT		
	end
	
	
	def simular
		#simula mientras haya tiempo
		for i in 0..@tiempo
		puts "tiempo transcurrido #{i}"
			#verifica si en ese instante llegan clientes o no
			if i % 3 == 0 
				anadirClientes
			end
			llamarClientes
			mostrarCajas
			puts
			mostrarFila
			#pausa la simulasion por deltaT segundos
			sleep(@deltaT)
			if i < @tiempo
			system "cls" #limpia la terminal (SO windows)
			system "clear" #limpia la terminal (SO linux)
			end
		end
		darPromedios
	end
	
	#inserta clientes a la cola	
	def anadirClientes
	#se genera un random con los clientes
		nuevosClientes = rand(0..6) #numero aleatorio que genera de 0 a 5 clientes por iteracion
		#puts nuevosClientes
		#se agregan clientes segun el random a una cola
		for j in 0..nuevosClientes
			@clientesEnCola << Cliente.new
		end
	end
	
	#atiende o avanza el tiempo en una caja
	def llamarClientes
		#recorre cada caja y revisa si hay que llamar a un cliente o hacer transcurrir el tiempo
		for j in 0..@cajasMercado.length-1
			#si la caja esta vacia y hay un cliente en la fila lo atiende
			if ((!@cajasMercado[j].isOcupada) && (!@clientesEnCola.empty?))
				clienteTemp = @clientesEnCola.shift
				@cajasMercado[j].atenderCliente(clienteTemp)
			#si no, hace transcurrir un minuto en caja
			else
				@cajasMercado[j].reducir
			end
		end
	end
	
	#imprime el layout de las cajas
	def mostrarCajas
		for i in 0..@cajasMercado.length-1
			print '| '+@cajasMercado[i].getNombre + ' |'
		end
		puts
		for i in 0..@cajasMercado.length-1
			if @cajasMercado[i].isOcupada 
				clienteActual = @cajasMercado[i].getCliente
				print '| '+clienteActual.getNombre+' |' 
			else
				print '|   |'
			end
		end
		puts
	end
	
	#imprime el layout de la fila	
	def mostrarFila
		i = 0
		while i < @clientesEnCola.length-1
			puts '| '+@clientesEnCola[i].getNombre + ' |'
			i+=1
		end
	end
	
	#devuelve el promedio de todas las cajas
	def darPromedios
		puts "los promedios por caja fueron: "
		for i in 0..@cajasMercado.length-1
			puts "caja #{i+1}: #{@cajasMercado[i].getPromedio}"
			
		end
	end
end



