require 'tk'
require 'csv'
$LOAD_PATH << "./lib"
# require 'time'
require 'engine/SelectionManager'
require 'engine/Field/Field'
require 'ui/menus'
require 'engine/Game'
require 'engine/Ai'

#Main file, containing ui loop, as well as the selection singleton and gameField frame

selectionManager = SelectionManager.instance

			gameWindow = TkFrame.new(Constants::ROOT) do
				padx Constants::FIELD_PADX
				pady Constants::FIELD_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 0) 
			end

drawUI(selectionManager)
game = Game.new(selectionManager, gameWindow)

while selectionManager.rootExists #While main window exists
	game.updateField #Checks if styles of 2 tiles need to be switched
	Tk.update_idletasks
	Tk.update
end
