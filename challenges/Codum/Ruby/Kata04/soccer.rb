def readData
	#variable para iterar
	lineNumber = 0.to_i
	#creacion de una matriz data[lineRead] => Renglon, palabras
	data = []
	lineRead = []
	#apertura e iteracion del archivo
	File.open("football.dat").each do |line|
		#guardado de palabras en renglones
		lineRead[lineNumber] = line.to_s.split
		lineNumber += 1
	end
	processData(lineRead)
end

def processData (lineRead)
	lineRead.delete_at(0)
	lineRead.delete_at(17)
	#inicializacion de variables con el primer valor 
	maxGoalDifference = (lineRead[0][6].to_i - lineRead[0][8].to_i).abs
	teamName = lineRead[0][1].to_s
	lineRead.each { |line|	
		goalDifference  = (line[6].to_i-line[8].to_i).abs
		if (isBestScore?(goalDifference, maxGoalDifference))
			maxGoalDifference = goalDifference
			teamName = line[1].to_s
		end
	}
	puts "the team with the smallest difference ‘for’ and ‘against’ goals is #{teamName} with #{maxGoalDifference}"
end

def isBestScore?(goalDifference, maxGoalDifference)
	if goalDifference < maxGoalDifference
		return true
	end
	return false
end

	readData
