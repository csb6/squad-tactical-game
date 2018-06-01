require_relative 'modules/Constants'
require_relative 'modules/GraphMath'
require_relative 'modules/FieldUtils'
require_relative 'classes/GameObject/GameObject'
require_relative 'classes/GameObject/InteractiveObject'
require_relative 'classes/GameObject/Soldier'
require_relative 'classes/GameObject/StaticObject'
require_relative 'classes/GameObject/OccupiableObject'

#Updates appearance of gameField as pieces are selected, move around, or perform actions on each other

def updateField(fieldArray, selectionManager)
		if selectionManager.resetCover
			fieldArray = FieldUtils.clearCoverMods(selectionManager, fieldArray)

		elsif selectionManager.isBlueTurn
			if selectionManager.inMovingMode
				fieldArray = FieldUtils.manualMove(fieldArray, selectionManager)
				
			elsif selectionManager.inTakeCoverMode
				fieldArray = FieldUtils.applyCoverMod(selectionManager, fieldArray)
				
			elsif selectionManager.inShootingMode && selectionManager.isTargetSet
				fieldArray = FieldUtils.shootTarget(fieldArray, selectionManager)
			end

		elsif !selectionManager.isBlueTurn #Red team is CPU controlled, follows path
			fieldArray = FieldUtils.autoMove([10,2], [25,27], fieldArray)
			selectionManager.resetCover = true
		end
		return fieldArray
end

def drawField(selectionManager, gameField) #Assigns styles to buttons, creates class instances w/ buttons' positions
	canvas = TkCanvas.new(gameField) do
		width 800 - 102
		height 724
		grid('row' => 0, 'column' => 0)
	end
	
	fieldArray = [ ]
	redTraits = CSV.read(Constants::RED_CHAR_PATH, :col_sep => "	")
	blueTraits = CSV.read(Constants::BLUE_CHAR_PATH, :col_sep => "	")
	
	r = 15
	y = 0
	rt = 0
	bt = 0
	CSV.foreach(Constants::LEVEL_PATH, :col_sep => "	") do |row|
		if row[0][0] != "#"
			c = 14
			x = 0
			fieldArray[y] = [ ]
			row.each do |letter|
				case letter
					when 's' #Sand tile
						fieldArray[y][x] = Sand.new("Sand", x, y, c, r, selectionManager, canvas)
						
					when 'w' #Wall tile
						fieldArray[y][x] = Wall.new("Wall", x, y, c, r, selectionManager, canvas)
						
					when 'c'
						fieldArray[y][x] = Cannon.new("Cannon", x, y, c, r, selectionManager, canvas)
						
					when 't'
						fieldArray[y][x] = Terminal.new("Terminal", x, y, c, r, selectionManager, canvas)
						
					when 'rh' #Soldier tile
						fieldArray[y][x] = RedSoldier.new(redTraits[rt][0], redTraits[rt][1], x, y, c, r, selectionManager, canvas)
						rt += 1
						
					when 'bh'
						fieldArray[y][x] = BlueSoldier.new(blueTraits[bt][0], blueTraits[bt][1], x, y, c, r, selectionManager, canvas)
						bt += 1
				end
				c += 25
				x += 1
			end
			r += 25
			y += 1
		else
			processedRow = [ ]
			i = 0
			row.each do |point|
				temp = point.delete("#").split(",")
				coord = [ temp[0].to_i, temp[1].to_i ]
				processedRow[i] = coord
				i += 1
			end
			PathFind.setWalls(processedRow)
		end
	end
	return fieldArray
end