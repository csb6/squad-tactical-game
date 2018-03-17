require_relative '../../Constants'

class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	attr_reader :description, :isInteractive, :isMovable, :rootWin
	attr_accessor :xPos, :yPos, :weight, :size, :isBroken
	
	def initialize(objectName, id, xPos, yPos, rootWin)
		super(objectName, id)
		
		@description = ""
		@xPos = xPos
		@yPos = yPos
		@weight = 0
		@size = 0
		@isBroken = isBroken
		@isInteractive = false
		@isMovable = false
		
		@button.style("Wall.InteractObj.TLabel")
	end
	
end

	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(objectName, id, xPos, yPos, rootWin)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@isBroken = false
			
			@button.style("Wall.InteractObj.TLabel")
		end
	
	end
