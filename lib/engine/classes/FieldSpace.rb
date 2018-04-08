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
			grid("row" => yPos, "column" => xPos) #Key that it's xPos, not @xPos; tiles must stay at their initial assigned location
		end
		
		@button.command{
			if @selectManager.inMovingMode && @traits.isOccupiable #If this space is occupiable and something's ready to move here, swap places
				@selectManager.targetTraits = @traits
				@selectManager.inMovingMode = false
				@selectManager.isTargetSet = true
				
			elsif @traits.isMovable
				@selectManager.currentTraits = @traits
				@selectManager.labelText.value = @traits.objectName #Sets name of nameLabel on sidebar
				@selectManager.inMovingMode = true
			else
				@selectManager.labelText.value = @traits.objectName #Sets name of nameLabel on sidebar
			end
		}
	end
	
	def setTraits(traits)
		@traits = traits
		@button.style = traits.style
		@traits.xPos = @xPos
		@traits.yPos = @yPos
	end
	
	def getStyle #button.style[0][0] === the actual style name string?? Why?!
		return @button.style[0][0]
	end
	
end