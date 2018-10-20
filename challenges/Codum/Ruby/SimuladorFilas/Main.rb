require_relative "FilaSimple"
require_relative "FilaIndividual"

#genera un menú para interactuar
def menu
	system "cls" #limpia la terminal (SO windows)
	system "clear" #limpia la terminal (SO linux)
	selec = printSeleccionSistema
	if  selec == 1
		cajas = printNumeroCajas
		tiempo = printTiempo
		deltaT = printDeltaT
		fs = FilaSimple.new(cajas-1, tiempo, deltaT)
		fs.simular
	elsif selec == 2
		cajas = printNumeroCajas
		tiempo = printTiempo
		deltaT = printDeltaT
		fi = FilaIndividual.new(cajas-1, tiempo, deltaT)
		fi.simular
	else
		puts 'Opcion no valida.. intente nuevamente'
		menu
	end
end

#muestra la opción de fila que se desea simular
def printSeleccionSistema
	puts "Seleccione el tipo de sistema\n"
	puts "\t1. Fila Unica"
	puts "\t2. Fila Multiple"
	return gets.chomp.to_i
end

#pregunta el numero de cajas que se desean simular
def printNumeroCajas
	puts 'Seleccione el numero de cajas'
	val = gets.chomp.to_i
	if val <= 0
		puts 'Valor no valido... intente nuevamente'
		printNumeroCajas
	end
	return val
end

#pregunta cuántos minutos dura la simulación
def printTiempo
	puts 'Ingrese el tiempo de la simulación'
	val = gets.chomp.to_i
	if val <= 0
		puts 'Valor no valido... intente nuevamente'
		printTiempo
	end
	return val
end

#pregunta por el delta de tiempo para la simulacion 
def printDeltaT
	puts 'Ingrese el delta de tiempo de la simulación'
	val = gets.chomp.to_i
	if val < 0
		puts 'Valor no valido... intente nuevamente'
		printTiempo
	end
	return val
end

#Iniciar simulación
menu