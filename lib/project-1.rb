require 'tk'
require 'csv'
require_relative 'engine/classes/GameObject'
require_relative 'engine/classes/InteractiveObject'
require_relative 'engine/classes/StaticObject'
require_relative 'engine/classes/OccupiableObject'
require_relative 'engine/classes/SelectionManager'
require_relative 'ui/menus'
require_relative 'engine/GameboardManager'

#Main file, containing ui loop, initial drawing of gameboard, as well as the selection singleton and gameField root window

selectionManager = SelectionManager.instance

			gameField = TkFrame.new(Constants::ROOT) do
				padx Constants::FIELD_PADX
				pady Constants::FIELD_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 0) 
			end

def drawField(selectionManager, gameField)#Assigns styles to buttons, creates class instances w/ buttons' positions
	canvas = TkCanvas.new(gameField) do
			width 800 - 102
			height 725
			grid('row' => 0, 'column' => 0)
	end
	
	fieldArray = [ ]
	
	r = 14
	y = 0
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
					fieldArray[y][x] = RedSoldier.new("Red Soldier #{x} #{y}", x, y, c, r, selectionManager, canvas)
					
				when 'bh'
					fieldArray[y][x] = BlueSoldier.new("Blue Soldier #{x} #{y}", x, y, c, r, selectionManager, canvas)
			end
			c += 25
			x += 1
		end
		r += 25
		y += 1
	end
	return fieldArray
end

drawUI(selectionManager)
fieldArray = drawField(selectionManager, gameField)

while selectionManager.rootExists #While main window exists
	fieldArray = updateField(fieldArray, selectionManager) #Checks if styles of 2 tiles need to be switched
	Tk.update_idletasks
	Tk.update
end
