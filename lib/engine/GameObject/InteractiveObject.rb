class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :panelFile
	attr_accessor :isBlueTeam
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		super
		
		@isInteractive = true
		@panelComponent = PanelComponent.new(self, rootWin)
		@isBlueTeam = true
	end
	
end
	
	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			@image[:image] = Constants::CANNON_IMAGE
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = ""
			@image[:image] = Constants::TERM_IMAGE
		end
		
	end
	
		class BlueTerminal < Terminal
			
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A blue-colored computer used for operation of devices or communication with outsiders"
				@panelFile = "blueTerminalControlPanel"
			end
		end
		
		class RedTerminal < Terminal
			
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A red-colored computer used for operation of devices or communication with outsiders"
				@panelFile = "redTerminalControlPanel"
				@isBlueTeam = false
			end
		end