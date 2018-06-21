
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
		
		@image.bind("1", proc {
			if selectManager.isBlueTurn
				updateLabels
				if !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but current is
					setTarget
				end
			end
		})
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
	
	
	def setTarget #tile to be this tile if it's the turn of the tile's team
		if @selectManager.inShootingMode #If looking for a shooting target and this tile can shoot, make it a target
			if @canShoot
				@selectManager.targetTile = self
				@selectManager.isTargetSet = true
			end
		else #If not looking for shooting target, see if this tile is within 5 tiles, set it as target if it is
			distanceToCurrent = GraphMath.distanceFormula(@selectManager.currentTile.xPos, @selectManager.currentTile.yPos, @xPos, @yPos)
			if @isOccupiable &&  distanceToCurrent <= 5
				@selectManager.targetTile = self
				@selectManager.isTargetSet = true
				@selectManager.inMovingMode = true
			end
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
		