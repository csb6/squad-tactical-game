class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :description, :isInteractive, :isMovable, :panelFile, :rootWin
	attr_accessor :xPos, :yPos, :weight, :size, :isBroken
	
	def initialize(objectName, id, xPos, yPos, rootWin)
		super(objectName, id)
		
		@description = ""
		@xPos = xPos
		@yPos = yPos
		@weight = 0
		@size = 0
		@isBroken = false
		@isInteractive = true
		@isMovable = true
		@panelFile = ""
		@rootWin = rootWin
		
		@button = Tk::Tile::Button.new(rootWin) do
			style "InteractObj.TButton"
			grid("row" => yPos, "column" => xPos)
		end
		
		def setStyle(style)
			@button.style(style)
		end
		
		@button.command{setStyle("Soldier.InteractObj.TButton") }
	end
	
	def openPanel
		
	end
	
	def closePanel
		
	end
	
end

	class Sand < InteractiveObject
			def initialize(objectName, id, xPos, yPos, rootWin)
				super
				
				@description = "Coarse, sandy soil, common throughout the island"
				@weight = 100
				@size = 1
				@isBroken = false
				@button.text("**")
				@button.style("Sand.InteractObj.TButton")
			end
	end
	
	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, id, xPos, yPos, rootWin)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			@button.style("Cannon.InteractObj.TButton")
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, id, xPos, yPos, rootWin)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = "terminalControlPanel"
			@button.style("Terminal.InteractObj.TButton")
		end
		
	end
	
	class Soldier < InteractiveObject
		
		def initialize(objectName, id, xPos, yPos, rootWin)
			super
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@panelFile = "soldierInfoPanel"
			@button.style("Soldier.InteractObj.TButton")
		end
		
	end	
		