require_relative '../../Constants'

class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :description, :isInteractive, :isMovable, :panelFile
	attr_accessor :xPos, :yPos, :weight, :size, :isBroken
	
	def initialize(objectName, id, xPos, yPos)
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
		Tk::Tile::Style.configure('InteractObj.TButton', {
			"font" => "helvetica 12",
			"width" => 1} )
	end
	
	def openPanel
		
	end
	
	def closePanel
		
	end
	
end


	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, id, xPos, yPos)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			Tk::Tile::Style.configure('Cannon.InteractObj', {
				"background" => "green",
				"foreground" => "green",
				"image" => Constants::CANNON_IMAGE} )
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, id, xPos, yPos)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = "cannonControlPanel"
			Tk::Tile::Style.configure('Cannon.InteractObj', {
				"background" => "grey",
				"foreground" => "grey",
				"image" => Constants::TERM_IMAGE} )
		end
		
	end
	
	class Soldier < InteractiveObject
		
		def initialize(objectName, id, xPos, yPos)
			super
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@panelFile = "soldierInfoPanel"
			Tk::Tile::Style.configure('Soldier.TButton', {
				"background" => "tan1", 
				"foreground" => "tan1",
				"image" => Constants::SOLDIER_IMAGE} )
		end
		
	end	
		