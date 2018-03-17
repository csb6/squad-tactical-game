require 'tk'

class FieldSpace
	
	attr_reader :xPos, :yPos, :rootWin, :button
	
	def initialize(xPos, yPos, rootWin)
		@xPos = xPos
		@yPos = yPos
		@rootWin = rootWin
		@button = Tk::Tile::Button.new(rootWin) do
			style "Field.TButton"
			grid("row" => yPos, "column" => xPos)
		end
		
		@button.command{setStyle("Soldier.InteractObj.Field.TButton") }
	end
	
	def setStyle(style)
		@button.style(style)
	end
	
end