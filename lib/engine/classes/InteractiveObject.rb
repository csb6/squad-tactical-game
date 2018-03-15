class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :isInteractive, :isMovable, :image
	attr_accessor :panelFile
	
	def initialize(name, id, description, xPos, yPos, weight, size, isBroken, panelFile)
		super(name, id, description, xPos, yPos, weight, size, isBroken)
		
		@isInteractive = true
		@isMovable = true
		@panelFile = panelFile
	end
	
	def openPanel
		
	end
	
	def closePanel
		
	end
	
end


	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		attr_reader :image
		
		def initialize(name, id, xPos, yPos, isBroken)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@image = cannon.png
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		attr_reader :image
		
		def initialize(name, id, xPos, yPos, isBroken)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@image = terminal.png
		end
	end
	
	class Soldier < InteractiveObject
		
		attr_reader :image
		
		def initialize(name, id, xPos, yPos, isBroken, image)
			super
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@image = image
		end
		
	end	
		