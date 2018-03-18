require 'tk'
require_relative '../../Constants'

class FieldSpace
	
	attr_reader :xPos, :yPos, :rootWin, :button
	
	def initialize(xPos, yPos, selectManager, rootWin)
		@xPos = xPos
		@yPos = yPos
		@selectManager = selectManager
		@rootWin = rootWin
		@button = Tk::Tile::Button.new(rootWin) do
			style "Field.TButton"
			grid("row" => yPos, "column" => xPos)
		end
		
		#@button.command{setStyle("Soldier.InteractObj.Field.TButton") }
		@button.command{
			@selectManager.style = @button.style
			if @button.style != 'Sand.OccupObj.Field.TButton'
				@button.style('Sand.OccupObj.Field.TButton')
			end
		}
	end
	
	def setStyle(style)
		@button.style(style)
	end
	
	def getStyle #Seems broken; fix this
		return @button.style
	end
	
end