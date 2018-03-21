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
			if @selectManager.inMovingMode && @traits.isOccupiable #If this space is occupiable and there's an object ready to move here, swap places with it
				@selectManager.targetTraits = @traits
				setTraits(@selectManager.currentTraits)
				@selectManager.destroyOrig
				@selectManager.inMovingMode = false
				
			elsif @traits.isMovable
				@selectManager.currentTile = @button
				@selectManager.labelText.value = @traits.objectName
#				@selectManager.currentName = "Soldier"
#				@selectManager.currentX = @xPos
#				@selectManager.currentY = @yPos
				@selectManager.currentTraits = @traits
				
				@selectManager.inMovingMode = true
			end
		}
	end
	
	def setTraits(traits)
		@traits = traits
		@button.style = traits.style
		@traits.xPos = @xPos
		@traits.yPos = @yPos
	end
	
	def getStyle #button.style[0][0] === the actual string?? Why?!
		return @button.style[0][0]
	end
	
end