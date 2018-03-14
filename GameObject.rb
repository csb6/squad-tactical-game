class GameObject
	
	def initialize(name, id, description, xPos, yPos, weight, isBroken, size, isVisible, isMovable)
		@name = name
		@id = id
		@description = description
		@xPos = xPos
		@yPos = yPos
		@weight = weight
		@isBroken = isBroken
		@size = size
		@isVisible = isVisible
		@isMovable = isMovable
	end
	
	def isGameObject
		return true
	end
	
	def getName
		return @name
	end
	
	def getID
		return @id
	end
	
	def getDescription
		return @description
	end
	
	def getxPos
		return @xPos
	end
	
		def setxPos(x)
			@xPos = x
		end
	
	def getyPos
		return @yPos
	end
		
		def setyPos(y)
			@yPos = y
		end
	
	def getWeight
		return @weight
	end
	
	def isBroken
			return @isBroken
		end
		
		def setBroken(state)
			@isBroken = state
		end
	
	def getSize
		return @size
	end
	
	def isVisible
		return @isVisible
	end
		
		def setVisible(state)
			@isVisible = state
		end
	
	def isMovable
		return @isMovable
	end
	
end