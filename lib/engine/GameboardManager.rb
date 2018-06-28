require_relative 'util/Constants'
require_relative 'util/GraphMath'
require_relative 'util/FieldUtils'
require_relative 'GameObject/GameObject'
require_relative 'GameObject/Soldier'
require_relative 'GameObject/StaticObject'
require_relative 'GameObject/OccupiableObject'
require_relative 'Components/ContextComponent'
require_relative 'Components/PanelComponent'
require_relative 'Components/InputComponent'

#Updates appearance of gameField as pieces are selected, move around, or perform actions on each other

def updateField(field, selectionManager, ai)
	if selectionManager.resetCover
		FieldUtils.clearCoverMods(selectionManager, field)

	elsif selectionManager.isBlueTurn
		if selectionManager.inMovingMode
			field.overwatch.findAll(false)
			FieldUtils.manualMove(field, selectionManager)
			
		elsif selectionManager.inTakeCoverMode
			FieldUtils.applyCoverMod(selectionManager, field)
			
		elsif selectionManager.inShootingMode && selectionManager.isTargetSet
			shooterPos = selectionManager.currentTile.getCoords
			targetPos = selectionManager.targetTile.getCoords
			targetMod = selectionManager.targetTile.coverMod
			FieldUtils.shootTarget(shooterPos, targetPos, targetMod, field, selectionManager)
		end

	elsif !selectionManager.isBlueTurn #Red team is CPU controlled, follows path
		ai.takeTurn
		selectionManager.resetCover = true
	end
end

def drawField(selectionManager, gameField) #Assigns styles to buttons, creates class instances w/ buttons' positions
	canvas = TkCanvas.new(gameField) do
		width 800 - 102
		height 724
		grid('row' => 0, 'column' => 0)
	end
	
	field = Field.new(selectionManager)
	
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
						field.addTile(pos, RedSoldier.new(field.red.getName, field.red.getGun, x, y, c, r, selectionManager, canvas) )
						
					when 'bh'
						field.addTile(pos, BlueSoldier.new(field.blue.getName, field.blue.getGun, x, y, c, r, selectionManager, canvas) )
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