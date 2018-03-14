require 'GameObject'

class LandObject < GameObject
	
	def initialize(name, id, description, xPos, yPos, weight, isBroken, size, isVisible, isMovable, isInteractive)
		super(name, id, description, xPos, yPos, weight, isBroken, size, isVisible, isMovable)
		@isInteractive = isInteractive
	end
	
	def isLandObject
		return true
	end
	
	def isInteractive
			return @isInteractive
	end
		
			def setInteractive(state)
				@isInteractive = state
			end
	
end

	class Wall < LandObject
		
		def initialize(name, id, xPos, yPos)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@isBroken = false
			@size = 1
			@isVisible = true
			@isMovable = false
			@isInteractive = false
			@hasControlPanel = false
		end
	
	end
	
	class Cannon < LandObject
		
		def initialize(name, id, xPos, yPos, isBroken)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@isVisible = true
			@isMovable = false
			@isInteractive = false
			@hasControlPanel = false
		end
	end