class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :description, :weight, :size, :isInteractive, :isMovable, :panelFile
	attr_accessor :xPos, :yPos, :weight, :size, :isBroken, :imageFile
	
	def initialize(objectName, id, xPos, yPos, isBroken)
		super(objectName, id)
		
		@description = ""
		@xPos = xPos
		@yPos = yPos
		@weight = 0
		@size = 0
		@isBroken = isBroken
		@isInteractive = true
		@isMovable = true
		@panelFile = ""
		@imageFile = ""
	end
	
	def openPanel
		
	end
	
	def closePanel
		
	end
	
end


	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, id, xPos, yPos, isBroken)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			@imageFile = "cannon.png"
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, id, xPos, yPos, isBroken)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = "cannonControlPanel"
			@imageFile = "terminal.png"
		end
		
	end
	
	class Soldier < InteractiveObject
		
		def initialize(objectName, id, xPos, yPos, isBroken)
			super
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@panelFile = "cannonControlPanel"
			@imageFile = "image.png"
		end
		
	end	
		