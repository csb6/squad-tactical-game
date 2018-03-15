class GameObject #General Object that appears on playing field
	
	attr_reader :isGameObject, :name, :id, :description, :weight, :size #can only read these
	attr_accessor :xPos, :yPos, :isBroken #can edit/read these
	
	def initialize(name, id, description, xPos, yPos, weight, size, isBroken)
		@isGameObject = true
		@name = name
		@id = id
		@description = description
		@xPos = xPos
		@yPos = yPos
		@weight = weight
		@size = size
		@isBroken = isBroken
	end
	
end
		