class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :panelFile
	attr_accessor :isBlueTeam
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		super
		
		@isInteractive = true
		@panelFile = ""
	end
	
	def openPanel
		
	end
	
	def closePanel
		
	end
	
end
	
	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			@image = TkcImage.new(@selectManager, rootWin, @x1, @y1)
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
	
	class Soldier < InteractiveObject
		
		attr_accessor :weapon, :health, :ammo, :coverMod
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
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
			@coverMod = 1
		end
	end
	
		class BlueSoldier < Soldier
			
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A stalwart, sometimes trigger-happy, GI, working for Blu-o-polis"
				@image[:image] = Constants::B_SOLDIER_IMAGE
			end
			
		end
		
		class RedSoldier < Soldier
			
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A stalwart, sometimes trigger-happy, GI, working for Red City"
				@image[:image] = Constants::R_SOLDIER_IMAGE
				@isBlueTeam = false
			end
			
		end
		