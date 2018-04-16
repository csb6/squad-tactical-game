class OccupiableObject < GameObject #Tile that someone can stand on, basically just the ground
	
	def initialize(objectName, xPos, yPos)
		super
		
		@isOccupiable = true
		@isOccupied = false
		@image = "OccupObj.Field.TButton"
	end
end

		class Sand < OccupiableObject
			def initialize(objectName, xPos, yPos)
				super
				
				@description = "Coarse, sandy soil, common throughout the island"
				@weight = 100
				@size = 1
				@image = Constants::SAND_IMAGE
			end
		end