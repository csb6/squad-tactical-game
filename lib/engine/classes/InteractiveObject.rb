class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :isInteractive, :panelFile
	
	def initialize(objectName, xPos, yPos)
		super
		
		@isInteractive = true
		@panelFile = ""
		@style = "InteractObj.Field.TButton"
	end
	
	def openPanel
		
	end
	
	def closePanel
		
	end
	
end
	
	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, xPos, yPos)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			@style = "Cannon.InteractObj.Field.TButton"
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, xPos, yPos)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = "terminalControlPanel"
			@style = "Terminal.InteractObj.Field.TButton"
		end
		
	end
	
	class Soldier < InteractiveObject
		
		def initialize(objectName, xPos, yPos)
			super
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@panelFile = "soldierInfoPanel"
			@isMovable = true
			@style = "Soldier.InteractObj.Field.TButton"
		end
		
	end	
		