require_relative '../../Constants'

class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	attr_reader :isInteractive, :isMovable
	
	def initialize(objectName, id, description, xPos, yPos, weight, size, isBroken)
		super(objectName, id)
		
		@xPos = xPos
		@yPos = yPos
		@weight = weight
		@size = size
		@isBroken = isBroken
		@isInteractive = false
		@isMovable = false
		Tk::Tile::Style.configure('StatObj.TLabel', {
			"font" => "helvetica 17", 
			"width" => 4, 
			"justify" => "right"
		} )
	end
	
end

	
	class Sand < StaticObject
		def initialize(objectName, id, xPos, yPos)
			super
			
			@description = "Coarse, sandy soil, common throughout the island"
			@weight = 100
			@size = 1
			@isBroken = false
			Tk::Tile::Style.configure('.StatObj', {
				"image" => Constants::WALL_IMAGE})
		end
	end

	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(objectName, id, xPos, yPos)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@isBroken = false
			Tk::Tile::Style.configure('Wall.StatObj', {
				"image" => Constants::WALL_IMAGE})
		end
	
	end
