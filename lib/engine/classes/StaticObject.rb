class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	attr_reader :isInteractive, :isMovable
	
	def initialize(name, id, description, xPos, yPos, weight, size, isBroken)
		super(name, id, description, xPos, yPos, weight, size, isBroken)
		
		@isInteractive = false
		@isMovable = false
	end
	
end


	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(name, id, xPos, yPos)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@isBroken = false
		end
	
	end
