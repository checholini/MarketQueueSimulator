require_relative "FilaSimple"
require_relative "FilaIndividual"

#genera un menu para interactuar
def menu
	system "cls"
	system "clear"
	sel = printSeleccionSistema
	if  sel == 1
		cajas = printNumeroCajas
		tiempo = printTiempo
		deltaT = printDeltaT
		fs = FilaSimple.new(cajas-1, tiempo, deltaT)
		fs.simular
	elsif sel == 2
		cajas = printNumeroCajas
		tiempo = printTiempo
		deltaT = printDeltaT
		fi = FilaIndividual.new(cajas-1, tiempo, deltaT)
		fi.simular
	else
		puts "opcion no valida"
		menu
	end
end

#muestra la opcion de fila que se desea simular
def printSeleccionSistema
	puts "Seleccione el tipo de sistema\n"
	puts "\t1. Fila Unica"
	puts "\t2. Fila Multiple"
	return gets.chomp.to_i
end

#pregunta el numero de cajas que se desean simular
def printNumeroCajas
	puts "seleccione el numero de cajas"
	val = gets.chomp.to_i
	if val <= 0
		puts "valor no valido"
		printNumeroCajas
	end
	return val
end

#pregunta cuanto dura la simulacion
def printTiempo
	puts "ingrese el tiempo de la simulacion"
	val = gets.chomp.to_i
	if val <= 0
		puts "valor no valido"
		printTiempo
	end
	return val
end

#pregunta por el delta de tiempo para la simulacion
def printDeltaT
	puts "ingrese el delta de tiempo de la simulacion"
	val = gets.chomp.to_i
	if val < 0
		puts "valor no valido"
		printTiempo
	end
	return val
end

menu