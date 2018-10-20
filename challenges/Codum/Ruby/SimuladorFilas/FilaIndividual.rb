require_relative "Caja"
require_relative "Cliente"

class FilaIndividual
	def initialize numCajas, tiempo, deltaT
		@cajasMercado = []
		@hashCajasFila = Hash.new
		for i in 0..numCajas
		cajaTemp = Caja.new()
			@cajasMercado[i] = cajaTemp
			@hashCajasFila[i] = Array.new
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
		nuevosClientesCantidad = rand(0..4)
		#se agregan clientes segun el random a una cola
		for j in 0..nuevosClientesCantidad
			nuevoCliente = Cliente.new
			asignarMinimo nuevoCliente
		end
	end
	
	#atiende o avanza el tiempo en una caja
	def llamarClientes
		#recorre cada caja y revisa si hay que llamar a un cliente o hacer transcurrir el tiempo
		for i in 0..@hashCajasFila.length-1
			#si la caja esta vacia y hay un cliente en la fila lo atiende
			if ((!@cajasMercado[i].isOcupada) && (!@hashCajasFila.fetch(i).empty?))
				clienteTemp = @hashCajasFila.fetch(i).shift
				@cajasMercado[i].atenderCliente(clienteTemp)
			#si no, hace transcurrir un minuto en caja
			else
				@cajasMercado[i].reducir
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
	
	#imprime el layout de la fila por cada caja
	def mostrarFila
		i = 0
		max = getMaxFila
		while i < max
			for j in 0..@cajasMercado.length-1
				arrTemp = @hashCajasFila.fetch(j)
				if arrTemp[i] != nil
					print "| #{arrTemp[i].getNombre} |"
				else 
					print "|   |"
				end
			end			
			puts			
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
	
	#coloca al cliente en una fila, priorizando las de menos tamaño
	def asignarMinimo clienteAIngresar
		flag = false
		#Si hay cajas vacias y no hay fila, atiende automaticamente al cliente
		for i in 0..@cajasMercado.length-1
			if !@cajasMercado[i].isOcupada && @hashCajasFila.fetch(i).empty?
				@cajasMercado[i].atenderCliente clienteAIngresar
				flag = true
				break
			end
		end
		#revisa si el cliente se añadio directamente a la caja
		if flag
		
		else
			#Escoge un valor aleatorio para posicionar al cliente
			val = rand(0..@hashCajasFila.length-1)
			min = @hashCajasFila.fetch(val).length
			pos = val
			#recorre el conjunto de filas para verificar si existe un valor menor
			for i in 0..@hashCajasFila.length-1
				#Si existe, se actualiza la informacion 
				if @hashCajasFila.fetch(i).length < min
					pos = i
					min = @hashCajasFila.fetch(i).length
				end
			end
			#se agrega el cliente a la caja
			@hashCajasFila.fetch(pos).push clienteAIngresar
		end

	end
	
	#Calcula cual es el maximo tamaño de las filas existentes
	def getMaxFila
		max = 0
		for i in 0..@hashCajasFila.length-1
			if @hashCajasFila.fetch(i).length > max
				max = @hashCajasFila.fetch(i).length
			end
		end
		return max
	end
end

