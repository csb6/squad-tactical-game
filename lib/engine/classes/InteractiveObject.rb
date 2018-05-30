class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :panelFile
	attr_accessor :isBlueTeam
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		super
		
		@isInteractive = true
		@panelFile = ""
		@isBlueTeam = true
		@image.bind("2", proc {
			if selectManager.isBlueTurn
				updateLabels
				if !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but current is
					openContextMenu
				end
			end
		})
	end
	
	def openContextMenu
		
	end

	def openPanel
		@panel = TkToplevel.new(@rootWin) do
			title "Inventory"
			background "grey"
			geometry '500x200-350+250'
		end
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