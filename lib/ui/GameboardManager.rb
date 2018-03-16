require 'tk'
require 'csv'
require_relative '../engine/classes/GameObject'
require_relative '../engine/classes/InteractiveObject'
require_relative '../Constants'

#Main UI file, adds/removes buttons, monitors for input

Tk::Tile::Style.configure('Ocean.TLabel', {"font" => "helvetica 17", "background" => "blue", "foreground" => "blue", "width" => 4, "justify" => "right"} )
Tk::Tile::Style.configure('Land.TButton', {"font" => "helvetica 12", "background" => "tan", "foreground" => "tan", "width" => 1} )
Tk::Tile::Style.configure('Soldier.TButton', {"font" => "helvetica 12", "background" => "tan1", "width" => 1} )
#soldierImageFile = TkPhotoImage.new(:file => "/users/kevinblakley/downloads/soldier-smallest.png")
soldierImageFile = TkPhotoImage.new(:file => "C:\\users\\moose\\git\\project-1\\lib\\ui\\soldier-smallest.png")
  
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

def initField(gameField, soldierImageFile) #When game starts, lays out all tiles as stored in the save
	
	rowArray = CSV.read(Constants::LEVEL_PATH, :col_sep => "	" )

	r = 0
	rowArray.each do |row|
		c = 0
		row.each do |letter|
			
			case letter
#				when'o' #Ocean tile
#					Tk::Tile::Label.new(gameField) do
#						style "Ocean.TLabel"
#						text "~~"
#						grid('row' => r, 'column' => c )
#					end
					
				when 'l' #Land tile
					Tk::Tile::Button.new(gameField) do
						style "Land.TButton"
						text "**"
						grid('row' => r, 'column' => c)
					end
					
				when 's' #Soldier tile
					Tk::Tile::Button.new(gameField) do
						style "Soldier.TButton"
						#text "S"
						image soldierImageFile
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

initField(gameField, soldierImageFile)
Tk.mainloop