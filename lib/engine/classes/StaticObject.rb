require_relative '../../Constants'

class StaticObject < GameObject #Object on playing field that is not interactive, not movable
	
	attr_reader :description, :isInteractive, :isMovable, :rootWin
	attr_accessor :xPos, :yPos, :weight, :size, :isBroken
	
	def initialize(objectName, id, xPos, yPos, rootWin)
		super(objectName, id)
		
		@description = ""
		@xPos = xPos
		@yPos = yPos
		@weight = 0
		@size = 0
		@isBroken = isBroken
		@isInteractive = false
		@isMovable = false
		
		@style = Tk::Tile::Style.configure('StatObj.TLabel', {
			"font" => "helvetica 17", 
			"width" => 4, 
			"justify" => "right"
		} )
		
		@button = Tk::Tile::Labelnew(rootWin) do
					style "StatObj.TLabel"
					grid('row' => yPos, 'column' => xPos)
		end
	end
	
end

	class Wall < StaticObject #Object that is not movable, blocks path
		
		def initialize(objectName, id, xPos, yPos)
			super
			
			@description = "A sturdy, unmovable barrier"
			@weight = 100
			@size = 1
			@isBroken = false
			Tk::Tile::Style.configure('Wall.StatObj', {
				"image" => Constants::WALL_IMAGE})
			@button.style("Wall.StatObj.TLabel")
		end
	
	end
