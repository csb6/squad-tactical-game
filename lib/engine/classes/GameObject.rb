class GameObject #General Object that appears on playing field
	
	attr_reader :isGameObject, :objectName, :id
	
	def initialize(objectName, id)
		@isGameObject = true
		@objectName = objectName
		@id = id
	end
	
end
		