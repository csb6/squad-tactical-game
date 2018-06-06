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
			owSoldiers = FieldUtils.findOWSoldiers(false, fieldArray)
			owSoldiers.each do |soldier|
				puts "#{soldier.objectName}"
			end
			fieldArray = FieldUtils.autoMove([10,2], [25,27], fieldArray)
			puts "#{FieldUtils.findNearbyOW(fieldArray[27][25], owSoldiers)}"
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
	
	field = Field.new
	
	r = 15
	y = 0
	CSV.foreach(Constants::LEVEL_PATH, :col_sep => "	") do |row|
		if row[0][0] != "#"
			c = 14
			x = 0

			row.each do |letter|
				pos = [x,y]
				case letter
					when 's' #Sand tile
						field.addTile(pos, Sand.new("Sand", x, y, c, r, selectionManager, canvas) )
						
					when 'w' #Wall tile
						field.addTile(pos, Wall.new("Wall", x, y, c, r, selectionManager, canvas) )
						
					when 'c'
						field.addTile(pos, Cannon.new("Cannon", x, y, c, r, selectionManager, canvas) )
						
					when 't'
						field.addTile(pos, Terminal.new("Terminal", x, y, c, r, selectionManager, canvas) )
						
					when 'rh' #Soldier tile
						field.addTile(pos, RedSoldier.new(field.getRedName, field.getRedGun, x, y, c, r, selectionManager, canvas) )
						
					when 'bh'
						field.addTile(pos, BlueSoldier.new(field.getBlueName, field.getBlueGun, x, y, c, r, selectionManager, canvas) )
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
	return field
end