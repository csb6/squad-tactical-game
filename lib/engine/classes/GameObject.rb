
#Parent class to all trait classes. Trait classes contain attritubes such as weight and typically a Tk style which
#is applied to FieldSpace instances by GameboardManager.stylizeField and when a player moves and a tile passes its trait class
#to the tile the player moves to, using SelectionManager

class GameObject
	
	attr_reader :isGameObject, :objectName, :description, :weight, :size, :isInteractive, :canShoot, :selectManager, :isBlueTeam
	attr_accessor :xPos, :yPos, :isBroken, :isMovable, :isOccupiable, :isOccupied, :image, :x1, :y1
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		@isGameObject = true
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
		@isInteractive = false
		@canShoot = false
		@isBlueTeam = true
		
		@image.bind("1", proc {
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
			
			
			if !@selectManager.isCurrentSet && @isMovable #If no current yet and this tile = movable
				if @isBlueTeam === @selectManager.isBlueTurn #make it the current if it is one of current player's men
					@selectManager.currentTraits = self
					@selectManager.isCurrentSet = true
				end
				
			elsif !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but current is
				if @selectManager.inShootingMode #If looking for a shooting target and this tile can shoot, make it a target
					if @canShoot
						@selectManager.targetTraits = self
						@selectManager.isTargetSet = true
					end
				else #If not looking for shooting target, see if its within 5 tiles, set it as target if it is
					distanceToCurrent = GraphMath.distanceFormula(@selectManager.currentTraits.xPos, @selectManager.currentTraits.yPos, @xPos, @yPos)
					if @isOccupiable &&  distanceToCurrent <= 5
						@selectManager.targetTraits = self
						@selectManager.isTargetSet = true
						@selectManager.inMovingMode = true
					end
				end
				#@selectManager.targetTraits = @traits
				#@selectManager.isTargetSet = true
			end
		})
	end
	
	def setPosition(x, y, a, b)
		@xPos = x
		@yPos = y
		@x1 = a
		@y1 = b
		@image.coords(@x1, @y1)
	end
	
	def flashImage(pic)
		origImage = @image[:image]
		@image[:image] = pic
		Tk.update
		sleep(0.4)
		@image[:image] = origImage
	end
	
end
		