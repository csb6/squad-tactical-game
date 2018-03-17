require 'tk'
require 'csv'
require_relative '../engine/classes/GameObject'
require_relative '../engine/classes/InteractiveObject'
require_relative '../Constants'

#Main UI file, adds/removes buttons, monitors for input
  
#jim = Soldier.new("Jim",0,50,40)

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

def initField(gameField) #When game starts, lays out all tiles as stored in the save
	
	rowArray = CSV.read(Constants::LEVEL_PATH, :col_sep => "	" )
	fieldArray = [ ]

	r = 0
	rowArray.each do |row|
		c = 0
		fieldArray[r] = [ ]
		row.each do |letter|
			case letter
				when 'l' #Land tile
					fieldArray[r][c] = Tk::Tile::Button.new(gameField) do
						style "Land.TButton"
						text "**"
						grid('row' => r, 'column' => c)
					end
					
				when 's' #Soldier tile
					fieldArray[r][c] = Tk::Tile::Button.new(gameField) do
						style "Soldier.TButton"
						#text "S"
						image Constants::SOLDIER_IMAGE
						grid('row' => r, 'column' => c )
					end
			end
			
			c += 1
		end
		r += 1
	end
	
end

def updateField
	
end

def saveField
	
end

initField(gameField)
Tk.mainloop