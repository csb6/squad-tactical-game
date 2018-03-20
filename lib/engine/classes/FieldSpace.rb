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
			if @selectManager.inMovingMode
				@selectManager.targetStyle = @button.style
				@button.style = @selectManager.currentStyle
				@selectManager.destroyOrig
				
				@selectManager.inMovingMode = false
				
			elsif @button.style[0][0] === "Soldier.InteractObj.Field.TButton" #button.style[0][0] === the actual string?? Why?!
				@selectManager.currentTile = @button
				@selectManager.currentName = "Soldier"
#				@selectManager.currentX = @xPos
#				@selectManager.currentY = @yPos
				@selectManager.currentStyle = @button.style
				
				@selectManager.inMovingMode = true
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