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
			
def drawField(selectionManager, gameField)#Creates rows and columns of buttons on UI
	fieldArray = [ ]
	r = 0
	27.times do
		c = 0
		fieldArray[r] = [ ]
		32.times do
			fieldArray[r][c] = FieldSpace.new(c, r, selectionManager, gameField)
			c += 1
		end
		r += 1
	end
	
	return fieldArray
end

def updateField(fieldArray, selectionManager)
		if selectionManager.isTargetSet #If a soldier is directed to go somewhere
			targetRow = selectionManager.targetTraits.yPos
			targetCol = selectionManager.targetTraits.xPos
			currentRow = selectionManager.currentTraits.yPos
			currentCol = selectionManager.currentTraits.xPos
			
			fieldArray[currentRow][currentCol].setTraits(selectionManager.targetTraits)
			fieldArray[targetRow][targetCol].setTraits(selectionManager.currentTraits)
			selectionManager.isTargetSet = false
			targetRow, targetCol, currentRow, currentCol = nil
			
		elsif selectionManager.isVictimSet #If a soldier has picked a target to shoot
			targetRow = selectionManager.victimY
			targetCol = selectionManager.victimX
			currentRow = selectionManager.shooterY
			currentCol = selectionManager.shooterX
			
			fieldArray[currentRow][currentCol].setAmmo(selectionManager.shooterAmmo - 1)
				puts "Ammo: #{selectionManager.shooterAmmo-1}"
			fieldArray[targetRow][targetCol].setHealth(selectionManager.victimHealth - 15)
				puts "Ouch!!"
			
			selectionManager.isVictimSet = false
			targetRow, targetCol, currentRow, currentCol = nil
		end
		return fieldArray
end

def stylizeField(fieldArray, selectionManager, gameField)#Assigns styles to buttons, creates class instances w/ buttons' positions
	styleArray = [ ]
	rowArray = CSV.read(Constants::LEVEL_PATH, :col_sep => "	" )
	
	r = 0
	rowArray.each do |row| 
		c = 0
		styleArray[r] = [ ]
		row.each do |letter|
			case letter
				when 's' #Sand tile
					styleArray[r][c] = Sand.new("Sand", c, r)
					
				when 'w' #Wall tile
					styleArray[r][c] = Wall.new("Wall", c, r)
					
				when 'c'
					styleArray[r][c] = Cannon.new("Cannon", c, r)
					
				when 't'
					styleArray[r][c] = Terminal.new("Terminal", c, r)
					
				when 'h' #Soldier tile
					styleArray[r][c] = Soldier.new("Soldier #{c} #{r}", c, r)
			end
			
			fieldArray[r][c].setTraits( styleArray[r][c] )
			c += 1
		end
		r += 1
	end
	
	styleArray = nil
end

drawUI(selectionManager)
fieldArray = drawField(selectionManager, gameField)
stylizeField(fieldArray, selectionManager, gameField)

while selectionManager.rootExists #While main window exists
	fieldArray = updateField(fieldArray, selectionManager) #Checks if styles of 2 tiles need to be switched
	Tk.update_idletasks
	Tk.update
end