class OccupiableObject < GameObject #Tile that someone can stand on, basically just the ground
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		super
		
		@isOccupiable = true
		@isOccupied = false
		@image[:image] = Constants::SAND_IMAGE
	end
end

		class Sand < OccupiableObject
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "Coarse, sandy soil, common throughout the island"
				@weight = 100
				@size = 1
				@image[:image] = Constants::SAND_IMAGE
			end
		end