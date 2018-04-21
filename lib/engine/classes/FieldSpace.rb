require 'tk'
require_relative '../../Constants'
require_relative '../../GraphMath'

class FieldSpace
	
	attr_reader :xPos, :yPos, :x1, :y1, :rootWin, :button, :traits
	
	def initialize(xPos, yPos, y1, x1, selectManager, rootWin)
		@xPos = xPos
		@yPos = yPos
		@x1 = x1
		@y1 = y1
		@selectManager = selectManager
		@rootWin = rootWin
		@button = TkcImage.new(@rootWin, @x1, @y1)
		
		@button.bind("1", proc {
			@selectManager.nameLabel.value = @traits.objectName #Sets name of nameLabel on sidebar
			
			if @traits.canShoot
				@selectManager.healthLabel.value = "Health: #{@traits.health}"
				@selectManager.ammoLabel.value = "Ammo: #{@traits.ammo}"
			else
				@selectManager.healthLabel.value = "Health: "
				@selectManager.ammoLabel.value = "Ammo: "
			end
			
			
			if !@selectManager.isCurrentSet && @traits.isMovable #If no current yet and this tile = movable, one pressed = target
				if @traits.isBlueTeam === @selectManager.isBlueTurn
					@selectManager.currentTraits = @traits
					@selectManager.isCurrentSet = true
				end
				
			elsif !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but have current, one pressed = target
				if @selectManager.inShootingMode
					if @traits.canShoot
						@selectManager.targetTraits = @traits
						@selectManager.isTargetSet = true
					end
				else
					distanceToCurrent = GraphMath.distanceFormula(@selectManager.currentTraits.xPos, @selectManager.currentTraits.yPos, @traits.xPos, @traits.yPos)
					if @traits.isOccupiable &&  distanceToCurrent <= 5
						@selectManager.targetTraits = @traits
						@selectManager.isTargetSet = true
						@selectManager.inMovingMode = true
					end
				end
#				@selectManager.targetTraits = @traits
#				@selectManager.isTargetSet = true
			end
		})
	end
	
	def setTraits(traits)
		@traits = traits
		@button[:image] = @traits.image
		@traits.xPos = @xPos
		@traits.yPos = @yPos
	end
	
	def setAmmo(ammoAmt)
		@traits.ammo = ammoAmt
	end
	
	def setHealth(healthAmt)
		@traits.health = healthAmt
	end
	
	def flashImage(image)
		origImage = @button[:image]
		@button[:image] = image
		Tk.update
		sleep(0.4)
		@button[:image] = origImage
	end
	
	def getStyle #button.style[0][0] === the actual style name string?? Why?!
		return @button.style[0][0]
	end
	
end