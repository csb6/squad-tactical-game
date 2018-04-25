require 'tk'
require 'csv'
require_relative 'engine/classes/GameObject'
require_relative 'engine/classes/InteractiveObject'
require_relative 'engine/classes/StaticObject'
require_relative 'engine/classes/OccupiableObject'
require_relative 'engine/classes/SelectionManager'
require_relative 'ui/menus'
require_relative 'engine/GameboardManager'

#Main file, containing ui loop, as well as the selection singleton and gameField frame

selectionManager = SelectionManager.instance

			gameField = TkFrame.new(Constants::ROOT) do
				padx Constants::FIELD_PADX
				pady Constants::FIELD_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 0) 
			end

drawUI(selectionManager)
fieldArray = drawField(selectionManager, gameField)

while selectionManager.rootExists #While main window exists
	fieldArray = updateField(fieldArray, selectionManager) #Checks if styles of 2 tiles need to be switched
	Tk.update_idletasks
	Tk.update
end
