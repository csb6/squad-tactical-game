require 'tk'
require 'csv'
# require 'time'
require_relative 'lib/engine/SelectionManager'
require_relative 'lib/engine/Field'
require_relative 'lib/ui/menus'
require_relative 'lib/engine/GameboardManager'
require_relative 'lib/engine/Ai'

#Main file, containing ui loop, as well as the selection singleton and gameField frame

selectionManager = SelectionManager.instance

			gameField = TkFrame.new(Constants::ROOT) do
				padx Constants::FIELD_PADX
				pady Constants::FIELD_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 0) 
			end

drawUI(selectionManager)
field = drawField(selectionManager, gameField)
ai = Ai.new(field, selectionManager)

while selectionManager.rootExists #While main window exists
	updateField(field, selectionManager, ai) #Checks if styles of 2 tiles need to be switched
	Tk.update_idletasks
	Tk.update
end
