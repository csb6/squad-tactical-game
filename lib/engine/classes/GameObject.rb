class GameObject #General Object that appears on playing field
	
	attr_reader :isGameObject, :objectName, :description, :weight, :size
	attr_accessor :xPos, :yPos, :isBroken, :isMovable, :isOccupiable, :isOccupied, :style
	
	def initialize(objectName, xPos, yPos)
		@isGameObject = true
		@objectName = objectName
		@description = ""
		@xPos = xPos
		@yPos = yPos
		@weight = 0
		@size = 0
		@style = ""
		@isBroken = false
		@isMovable = false
		@isOccupiable = false
		@isOccupied = true
	end
	
end
		