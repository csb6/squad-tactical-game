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
					styleArray[r][c] = Soldier.new("Soldier", c, r)
			end
			
			fieldArray[r][c].setTraits( styleArray[r][c] )
			c += 1
		end
		r += 1
	end
	
	return styleArray
end

#def updateTiles(fieldArray, selectionManager)
#	targetX = selectionManager.xPos
#	targetY = selectionManager.yPos
#	
#	fieldArray[ currentxPos ][ currentyPos ].setStyle("Sand.OccupObj.Field.TButton")
#	fieldArray[ 5 ][ 5 ].setStyle(currentStyle)
#end

nameText = drawUI(selectionManager)
fieldArray = drawField(selectionManager, gameField)
styleArray = stylizeField(fieldArray, selectionManager, gameField)
Tk.mainloop
#while true
#	if selectionManager.xPos != nil
#		if selectionManager.style != fieldArray[selectionManager.yPos][selectionManager.xPos].getStyle
#			updateTiles(fieldArray, selectionManager)
#		end
#	end
#	Tk.update_idletasks
#	Tk.update
#end