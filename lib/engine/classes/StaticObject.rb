require_relative '../../Constants'

class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	attr_reader :isInteractive
	
	def initialize(objectName, xPos, yPos, rootWin)
		super
		
		@isInteractive = false
		@style = "Wall.InteractObj.TLabel"
	end
	
end

	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(objectName, xPos, yPos, rootWin)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@style = "Wall.InteractObj.TLabel"
		end
	
	end
