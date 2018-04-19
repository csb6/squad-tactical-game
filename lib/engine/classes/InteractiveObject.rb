class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :panelFile, :team
	
	def initialize(objectName, xPos, yPos)
		super
		
		@isInteractive = true
		@panelFile = ""
		@team = ""
		@image = ""
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
			@image = Constants::CANNON_IMAGE
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, xPos, yPos)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = ""
			@image = Constants::CANNON_IMAGE
		end
		
	end
	
		class BlueTerminal < Terminal
			
			def initialize(objectName, xPos, yPos)
				super
				
				@description = "A blue-colored computer used for operation of devices or communication with outsiders"
				@panelFile = "blueTerminalControlPanel"
				@team = "blue"
			end
		end
		
		class RedTerminal < Terminal
			
			def initialize(objectName, xPos, yPos)
				super
				
				@description = "A red-colored computer used for operation of devices or communication with outsiders"
				@panelFile = "redTerminalControlPanel"
				@team = "red"
			end
		end
	
	class Soldier < InteractiveObject
		
		attr_accessor :weapon, :health, :ammo, :coverMod
		
		def initialize(objectName, xPos, yPos)
			super
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@panelFile = "soldierInfoPanel"
			@isMovable = true
			@canShoot = true
			@weapon = "gun"
			@health = 100
			@ammo = 50
			@image = ""
			@coverMod = 1
		end
		
	end
	
		class BlueSoldier < Soldier
			
			def initialize(objectName, xPos, yPos)
				super
				
				@description = "A stalwart, sometimes trigger-happy, GI, working for Blu-o-polis"
				@image = Constants::B_SOLDIER_IMAGE
				@team = "blue"
			end
			
		end
		
		class RedSoldier < Soldier
			
			def initialize(objectName, xPos, yPos)
				super
				
				@description = "A stalwart, sometimes trigger-happy, GI, working for Red City"
				@image = Constants::R_SOLDIER_IMAGE
				@team = "red"
			end
			
		end
		