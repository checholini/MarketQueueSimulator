def isBestOption?(newOption, previousOption)
	if newOption < previousOption
		return true
	end
	return false
end


def readData (fileName)
	lineNumber = 0.to_i
	#creacion de una matriz data[lineRead] => Renglon, palabras
	data = []
	lineRead = []
	#apertura e iteracion del archivo
	File.open(fileName).each do |line|
		#guardado de palabras en renglones
		lineRead[lineNumber] = line.to_s.split
		lineNumber += 1
	end
	if(fileName == "football.dat")
		processDataSoccer(lineRead)
	else
		processDataSpread(lineRead)
	end
	
end

def processDataSoccer (lineRead)
	lineRead.delete_at(0)
	lineRead.delete_at(17)
	#inicializacion de variables con el primer valor 
	maxGoalDifference = (lineRead[0][6].to_i - lineRead[0][8].to_i).abs
	teamName = lineRead[0][1].to_s
	lineRead.each { |line|	
		goalDifference  = (line[6].to_i-line[8].to_i).abs
		if (isBestOption?(goalDifference, maxGoalDifference))
			maxGoalDifference = goalDifference
			teamName = line[1].to_s
		end
	}
	puts "the team with the smallest difference ‘for’ and ‘against’ goals is #{teamName} with #{maxGoalDifference}"
end

def processDataSpread (lineRead)
	#eliminacion de renglones sin informacion explicita
	lineRead.delete_at(1)
	lineRead.delete_at(0)	
	#inicializacion de variables con el primer valor 
	maxSpreadTemp = lineRead[0][1].to_i - lineRead[0][2].to_i
	dayMaxSpread = 1
	#recorrido del arreglo 
	lineRead.each { |line|
		#calulo de la diferencia de temperaturas
		spread = line[1].to_i - line[2].to_i
		#busqueda del mejor valor en el arreglo 
		if(isBestOption?(spread , maxSpreadTemp))
			maxSpreadTemp = spread
			dayMaxSpread = line[0]
		end
	}	
	puts "Smallest Temperature Spread on day #{dayMaxSpread} with a value of #{maxSpreadTemp}"
end

def menu
	puts 'Select a option'
	puts "press 1 for weather spread\npress 2 for goal difference\n press 3 to quit2"
	a = gets.chomp.to_i
	if a == 1
		readData("weather.dat")
	elsif a == 2
		readData("football.dat")
	elsif a == 3 
		exit
	else
		puts 'not an option'
	end
	menu
end

menu
