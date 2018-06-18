require_relative "../lib/util/GraphMath"

fieldArray = [ ]
y = 0
8.times do
	x = 0
	fieldArray[y] = [ ]
	8.times do
		fieldArray[y][x] = [x, y]
		x += 1
	end
	y += 1
end
fieldArray.flatten
GraphMath.findBestPath(0,0,7,7)