require_relative '../../Constants'

class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		super
	end
	
end

	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@image[:image] = Constants::WALL_IMAGE
		end
	
	end
