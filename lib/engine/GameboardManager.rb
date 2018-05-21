require_relative '../Constants'
require_relative '../GraphMath'

#Updates appearance of gameField as pieces are selected, move around, or perform actions on each other


def updateField(fieldArray, selectionManager)
		if selectionManager.resetCover
			selectionManager.isBlueTurn = !selectionManager.isBlueTurn
			selectionManager.resetAll
			selectionManager.resetCover = false
			
			if selectionManager.isBlueTurn
				selectionManager.turnLabel.value = "Blue Turn"
			else
				selectionManager.turnLabel.value = "Red Turn "
			end
			
			y = 0
			fieldArray.each do |row|
				x = 0
				row.each do
					if fieldArray[y][x].canShoot && fieldArray[y][x].isBlueTeam === selectionManager.isBlueTurn
						fieldArray[y][x].coverMod = 1
					end
					x += 1
				end
				y += 1
			end

		elsif selectionManager.isBlueTurn
			if selectionManager.inMovingMode
				targetRow = selectionManager.targetTraits.yPos
				targetCol = selectionManager.targetTraits.xPos
				targetXPx = selectionManager.targetTraits.x1
				targetYPx = selectionManager.targetTraits.y1
				
				currentRow = selectionManager.currentTraits.yPos
				currentCol = selectionManager.currentTraits.xPos
				currentXPx = selectionManager.currentTraits.x1
				currentYPx = selectionManager.currentTraits.y1
				
				fieldArray[currentRow][currentCol].setPosition(targetCol, targetRow, targetXPx, targetYPx)
				fieldArray[targetRow][targetCol].setPosition(currentCol, currentRow, currentXPx, currentYPx)
				temp = fieldArray[currentRow][currentCol]
				fieldArray[currentRow][currentCol] = fieldArray[targetRow][targetCol]
				fieldArray[targetRow][targetCol] = temp
				
				selectionManager.isCurrentSet = false
				selectionManager.isTargetSet = false
				selectionManager.inMovingMode = false
				selectionManager.hitText.value = ""
				targetRow, targetCol, targetXPx, targetYPx, currentRow, currentCol, currentXPx, currentYPx, temp = nil
				
			elsif selectionManager.inTakeCoverMode
				currentRow = selectionManager.currentTraits.yPos
				currentCol = selectionManager.currentTraits.xPos
				
				fieldArray[currentRow][currentCol].coverMod = 0.8
				
				selectionManager.coverLabel.value = "Cover: #{fieldArray[currentRow][currentCol].coverMod}"
				selectionManager.isCurrentSet = false
				selectionManager.inTakeCoverMode = false
				currentRow, currentCol = nil
				
			elsif selectionManager.inShootingMode && selectionManager.isTargetSet
				targetRow = selectionManager.targetTraits.yPos
				targetCol = selectionManager.targetTraits.xPos
				currentRow = selectionManager.currentTraits.yPos
				currentCol = selectionManager.currentTraits.xPos
				coverModifier = selectionManager.targetTraits.coverMod
				
				fieldArray[currentRow][currentCol].ammo = selectionManager.currentTraits.ammo - 1
				chanceToHit = GraphMath.calcHitChance(currentCol, currentRow, targetCol, targetRow, coverModifier, fieldArray)
				selectionManager.hitText.value = "#{chanceToHit}% chance"
				
				if GraphMath.hitDeterminer(chanceToHit)
					fieldArray[targetRow][targetCol].health = selectionManager.targetTraits.health - 15
					fieldArray[targetRow][targetCol].flashImage(Constants::EXPLO_IMAGE)
				end
				
				selectionManager.isCurrentSet = false
				selectionManager.isTargetSet = false
				selectionManager.inShootingMode = false
				selectionManager.currentTraits.coverMod = 1
				targetRow, targetCol, currentRow, currentCol, coverModifier, chanceToHit = nil
			end
		elsif !selectionManager.isBlueTurn #Red team is CPU controlled, follows path
			# path = [ [10, 2], [9, 2], [8, 2], [ 7, 2] ]
			path = [ [10,2], [11, 3], [11, 2], [11, 1], [10, 1], [9, 1], [9, 2], [9, 3], [10, 3], [8, 1], [8, 2], [8, 3], [7, 1], [7, 2], [6, 1], [6, 2], [6, 3], [5, 1], [5, 2], [5, 3], [5, 4], [6, 4]]
			
			currentRow = nil
			path.each do |point|
				if currentRow === nil
					currentRow = fieldArray[ point[1] ][ point[0] ].yPos
					currentCol = fieldArray[ point[1] ][ point[0] ].xPos
					currentXPx = fieldArray[ point[1] ][ point[0] ].x1
					currentYPx = fieldArray[ point[1] ][ point[0] ].y1
				else
					targetRow = fieldArray[ point[1] ][ point[0] ].yPos
					targetCol = fieldArray[ point[1] ][ point[0] ].xPos
					targetXPx = fieldArray[ point[1] ][ point[0] ].x1
					targetYPx = fieldArray[ point[1] ][ point[0] ].y1
					
					fieldArray[currentRow][currentCol].setPosition(targetCol, targetRow, targetXPx, targetYPx)
					fieldArray[targetRow][targetCol].setPosition(currentCol, currentRow, currentXPx, currentYPx)
					temp = fieldArray[currentRow][currentCol]
					fieldArray[currentRow][currentCol] = fieldArray[targetRow][targetCol]
					fieldArray[targetRow][targetCol] = temp
					currentRow = targetRow
					currentCol = targetCol
					currentXPx = targetXPx
					currentYPx = targetYPx
					temp = nil
					Tk.update
					sleep(0.4)
				end
			end
			selectionManager.resetCover = true
		end
		return fieldArray
end

def drawField(selectionManager, gameField) #Assigns styles to buttons, creates class instances w/ buttons' positions
	canvas = TkCanvas.new(gameField) do
		width 800 - 102
		height 725
		grid('row' => 0, 'column' => 0)
	end
	
	fieldArray = [ ]
	redTraits = CSV.read(Constants::RED_CHAR_PATH, :col_sep => "	")
	blueTraits = CSV.read(Constants::BLUE_CHAR_PATH, :col_sep => "	")
	
	r = 14
	y = 0
	rt = 0
	bt = 0
	CSV.foreach(Constants::LEVEL_PATH, :col_sep => "	") do |row|
		c = 12
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
	end
	return fieldArray
end