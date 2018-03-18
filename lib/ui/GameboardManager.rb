require 'tk'
require 'csv'
require_relative '../engine/classes/FieldSpace'
require_relative '../engine/classes/GameObject'
require_relative '../engine/classes/InteractiveObject'
require_relative '../engine/classes/StaticObject'
require_relative '../engine/classes/OccupiableObject'
require_relative '../engine/classes/SelectionManager'
require_relative '../Constants'

#Main UI file, adds/removes buttons, monitors for input
  
#jim = Soldier.new("Jim",0,50,40)

selectionManager = SelectionManager.instance

root = TkRoot.new() do
  title Constants::TITLE
  background Constants::BACKGROUND
  minsize(Constants::WIDTH, Constants::HEIGHT)
  resizable true, true
end

      menu = TkFrame.new(root) { grid('row' => 0, 'column' => 0) }
      
            TkButton.new(menu) do
              text "Exit"
              command{root.destroy}
              grid('row' => 0, 'column' => 0)
            end
            
            TkButton.new(menu) do
            		text "Load Game"
            		
            		command do
            			loadFile = Tk::getOpenFile
            		end
            		grid('row' => 0, 'column' => 2)
            end
            
            TkButton.new(menu) do
            		text "Save Game"
            		
							command do
								saveFile = Tk::getSaveFile
							end
							grid('row' => 0, 'column' => 1)
					 end

			gameField = TkFrame.new(root) do
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
			
			fieldArray[r][c].setStyle( styleArray[r][c].style )
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