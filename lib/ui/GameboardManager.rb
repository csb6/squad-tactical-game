require 'tk'
require 'csv'
require_relative '../engine/classes/FieldSpace'
require_relative '../engine/classes/GameObject'
require_relative '../engine/classes/InteractiveObject'
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

def initField(selectionManager, gameField) #When game starts, lays out all tiles as stored in the save
	
	fieldArray = [ ]
	
	r = 0
	27.times do #Creates rows and columns of buttons on UI
		c = 0
		fieldArray[r] = [ ]
		32.times do
			fieldArray[r][c] = FieldSpace.new(c, r, selectionManager, gameField)
			c += 1
		end
		r += 1
	end
	
	rowArray = CSV.read(Constants::LEVEL_PATH, :col_sep => "	" )
	styleArray = [ ]

	r = 0
	rowArray.each do |row| #Assigns styles to the buttons, creates class instances associated w/ those buttons' positions
		c = 0
		styleArray[r] = [ ]
		row.each do |letter|
			case letter
				when 's' #Sand tile
					styleArray[r][c] = Sand.new("Sand", c, r)
					
				when 'w' #Wall tile
					styleArray[r][c] = Tk::Tile::Button.new(gameField) do
						style "Wall.StatObj.TButton"
						grid('row' => r, 'column' => c)
					end
				when 'h' #Soldier tile
					styleArray[r][c] = Soldier.new("Soldier", c, r)
			end
			
			fieldArray[r][c].setStyle( styleArray[r][c].style )
			c += 1
		end
		r += 1
	end
	
end

def updateField(isRunning, selectionManager)
	
end

def saveField
	
end

initField(selectionManager, gameField)
Tk.mainloop