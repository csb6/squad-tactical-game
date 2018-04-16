require 'tk'
require 'csv'
require_relative 'classes/FieldSpace'
require_relative 'classes/GameObject'
require_relative 'classes/InteractiveObject'
require_relative 'classes/StaticObject'
require_relative 'classes/OccupiableObject'
require_relative 'classes/SelectionManager'
require_relative '../ui/menus'
require_relative '../Constants'

#Main UI file, adds/removes buttons, monitors for input
  
selectionManager = SelectionManager.instance

			gameField = TkFrame.new(Constants::ROOT) do
				padx Constants::FIELD_PADX
				pady Constants::FIELD_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 0) 
			end

def drawCanvas(gameField, selectionManager)
	canvas = TkCanvas.new(gameField) do
		width 800 - 77
		height 700
		grid('row' => 0, 'column' => 0)
	end
	
	r = 2
	y = 0
	fieldArray = [ ]
	29.times do
		c = 2
		x = 0
		fieldArray[y] = [ ]
		28.times do
			fieldArray[y][x] = FieldSpace.new(x, y, r, c, selectionManager, canvas)
			c += 25
			x += 1
		end
		r += 25
		y += 1
	end
	return fieldArray
end

def updateField(fieldArray, selectionManager)

		if selectionManager.inMovingMode
			targetRow = selectionManager.targetTraits.yPos
			targetCol = selectionManager.targetTraits.xPos
			currentRow = selectionManager.currentTraits.yPos
			currentCol = selectionManager.currentTraits.xPos
			
			fieldArray[currentRow][currentCol].setTraits(selectionManager.targetTraits)
			fieldArray[targetRow][targetCol].setTraits(selectionManager.currentTraits)
			selectionManager.isCurrentSet = false
			selectionManager.isTargetSet = false
			selectionManager.inMovingMode = false
			targetRow, targetCol, currentRow, currentCol = nil
			
		elsif selectionManager.inShootingMode && selectionManager.isTargetSet
			targetRow = selectionManager.targetTraits.yPos
			targetCol = selectionManager.targetTraits.xPos
			currentRow = selectionManager.currentTraits.yPos
			currentCol = selectionManager.currentTraits.xPos
			
			fieldArray[currentRow][currentCol].setAmmo(selectionManager.currentTraits.ammo - 1)
				puts "Ammo: #{selectionManager.currentTraits.ammo}"
			fieldArray[targetRow][targetCol].setHealth(selectionManager.targetTraits.health - 15)
				puts "Ouch!!"
			
			selectionManager.isCurrentSet = false
			selectionManager.isTargetSet = false
			selectionManager.inShootingMode = false
			targetRow, targetCol, currentRow, currentCol = nil
		end
		return fieldArray
end

def stylizeField(fieldArray, selectionManager, gameField)#Assigns styles to buttons, creates class instances w/ buttons' positions
	style = nil
	
	r = 0
	CSV.foreach(Constants::LEVEL_PATH, :col_sep => "	") do |row|
		c = 0
		row.each do |letter|
			case letter
				when 's' #Sand tile
					style = Sand.new("Sand", c, r)
					
				when 'w' #Wall tile
					style = Wall.new("Wall", c, r)
					
				when 'c'
					style = Cannon.new("Cannon", c, r)
					
				when 't'
					style = Terminal.new("Terminal", c, r)
					
				when 'rh' #Soldier tile
					style = RedSoldier.new("Red Soldier #{c} #{r}", c, r)
					
				when 'bh'
					style = BlueSoldier.new("Blue Soldier #{c} #{r}", c, r)
			end
			
			fieldArray[r][c].setTraits( style )
			style = nil
			c += 1
		end
		r += 1
	end
end

drawUI(selectionManager)
fieldArray = drawCanvas(gameField, selectionManager)
stylizeField(fieldArray, selectionManager, gameField)

while selectionManager.rootExists #While main window exists
	fieldArray = updateField(fieldArray, selectionManager) #Checks if styles of 2 tiles need to be switched
	Tk.update_idletasks
	Tk.update
end