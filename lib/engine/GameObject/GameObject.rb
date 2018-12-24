require 'engine/Components/InputComponent'
#Parent class to all trait classes. Trait classes contain attritubes such as weight and a TkImage. When a player moves
#he selects a Trait class as currentTile and one for targetTile; they switch places, simulating movement

class GameObject
	
	attr_reader :objectName, :description, :weight, :size, :canShoot, :selectManager
	attr_accessor :xPos, :yPos, :isBroken, :isMovable, :isOccupiable, :isOccupied, :image, :x1, :y1
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		@objectName = objectName
		@description = ""
		@xPos = xPos
		@yPos = yPos
		@x1 = x1
		@y1 = y1
		@rootWin = rootWin
		@selectManager = selectManager
		@weight = 0
		@size = 0
		@image = TkcImage.new(@rootWin, @x1, @y1)
		@isBroken = false
		@isMovable = false
		@isOccupiable = false
		@isOccupied = true
		@canShoot = false
		@inputComponent = BasicInputComponent.new(self, selectManager)
	end
	
	
	def updateLabels #on the side menu, for selected item
		@selectManager.nameLabel.value = @objectName #Sets name of nameLabel on sidebar
							
		if @canShoot
			@selectManager.healthLabel.value = "Health: #{@health}"
			@selectManager.ammoLabel.value = "Ammo: #{@ammo}"
			@selectManager.coverLabel.value = "Cover: #{@coverMod}"
		else
			@selectManager.healthLabel.value = "Health: "
			@selectManager.ammoLabel.value = "Ammo: "
			@selectManager.coverLabel.value = "Cover: "
		end
	end
	
	
	def setPosition(pos, px)
		@xPos = pos[0]
		@yPos = pos[1]
		@x1 = px[0]
		@y1 = px[1]
		@image.coords(@x1, @y1)
	end

	def getCoords
		return [ @xPos, @yPos ]
	end

	def getPxCoords
		return [ @x1, @y1 ]
	end
	
	def flashImage(pic)
		origImage = @image[:image]
		@image[:image] = pic
		Tk.update
		sleep(0.4)
		@image[:image] = origImage
	end
	
end
		