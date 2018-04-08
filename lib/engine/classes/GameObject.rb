
#Parent class to all trait classes. Trait classes contain attritubes such as weight and typically a Tk style which
#is applied to FieldSpace instances by GameboardManager.stylizeField and when a player moves and a tile passes its trait class
#to the tile the player moves to, using SelectionManager

class GameObject
	
	attr_reader :isGameObject, :objectName, :description, :weight, :size, :isInteractive
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
		@isInteractive = false
	end
	
end
		