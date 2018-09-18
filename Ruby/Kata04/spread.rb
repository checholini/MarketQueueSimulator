def readData
	#variable para numerar las posiciones del arreglo
	lineNumber = 0.to_i
	lineRead = []
	#apertura e iteracion del archivo
	File.open("weather.dat").each do |line|	
		#guardado de palabras en renglones
		lineRead[lineNumber] = line.to_s.split
		lineNumber += 1		
	end
	#eliminacion de renglones sin informacion explicita
	lineRead.delete_at(1)
	lineRead.delete_at(0)	
	lineRead.delete_at(lineRead.count - 1)
	processData(lineRead)
end

def processData(lineRead)
	#inicializacion de variables con el primer valor 
	maxSpreadTemp = lineRead[0][1].to_i - lineRead[0][2].to_i
	dayMaxSpread = 1
	#recorrido del arreglo 
	lineRead.each { |line|
		#calulo de la diferencia de temperaturas
		spread = line[1].to_i - line[2].to_i
		#busqueda del mejor valor en el arreglo 
		if(isBestSpread?(spread , maxSpreadTemp))
			maxSpreadTemp = spread
			dayMaxSpread = line[0]
		end
	}	
	puts "Smallest Temperature Spread on day #{dayMaxSpread} with a value of #{maxSpreadTemp}"
end

#metodo para comparar temperaturas
def isBestSpread?(dayTemp, maxSpreadTemp)
	if dayTemp < maxSpreadTemp
		return true
	end
	return false
end

	readData
