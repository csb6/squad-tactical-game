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
			@selectManager.xPos = @xPos
			@selectManager.yPos = @yPos
			@selectManager.style = @button.style
		}
	end
	
	def setStyle(style)
		@button.style(style)
	end
	
end