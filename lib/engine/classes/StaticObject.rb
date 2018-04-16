require_relative '../../Constants'

class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	attr_reader :isInteractive
	
	def initialize(objectName, xPos, yPos)
		super
		
		@isInteractive = false
		@style = "Wall.InteractObj.TLabel"
	end
	
end

	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(objectName, xPos, yPos)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@image = Constants::WALL_IMAGE
		end
	
	end
