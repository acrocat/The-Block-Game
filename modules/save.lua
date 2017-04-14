local save = {}

local highScoreFile = "highscore.txt"

function loadFile (fileName) 
	local path = system.pathForFile(fileName , system.DocumentsDirectory)

	local file , errorString = io.open(path , "r")
	 if not file then
	 	-- There was an error reading the file
	 	print("File error: " .. errorString)
	 else
	 	local contents = file:read("*a")
	 	io.close(file)

	 	return contents
	 end
end

function storeInFile (fileName , data)
	local path = system.pathForFile(fileName , system.DocumentsDirectory)

	local file , errorString = io.open(path , "w")
	 if not file then
	 	-- There was an error reading the file
	 	print("File error: " .. errorString)
	 else
	 	print("Writing the data")
	 	file:write(data)

	 	io.close(file)
	 end
end

save.getHighScore = function ()
	local score = loadFile(highScoreFile)
	if score == nil then return 0 else return score end
end

save.setHighScore = function (self , score)
	storeInFile(highScoreFile , score)
end

return save