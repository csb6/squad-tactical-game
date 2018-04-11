require 'tk'
require_relative '../../Constants'

class FieldSpace
	
	attr_reader :xPos, :yPos, :rootWin, :button
	
	def initialize(xPos, yPos, selectManager, rootWin)
		@xPos = xPos
		@yPos = yPos
		@selectManager = selectManager
		@rootWin = rootWin
		@button = Tk::Tile::Button.new(rootWin) do
			style "Field.TButton"
			grid("row" => yPos, "column" => xPos) #Key that it's xPos, not @xPos; tiles must stay at their initial assigned location
		end
		
		@button.command{
			@selectManager.nameLabel.value = @traits.objectName #Sets name of nameLabel on sidebar
			if @traits.canShoot
				@selectManager.healthLabel.value = "Health: #{@traits.health}"
				@selectManager.ammoLabel.value = "Ammo: #{@traits.ammo}"
			end
			
			
			if !@selectManager.isCurrentSet && @traits.isMovable #If no tile currently selected, select the one clicked on
				@selectManager.currentTraits = @traits
				@selectManager.isCurrentSet = true
				
			elsif !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile currently targeted, select the one clicked on
				if @selectManager.inShootingMode
					if @traits.canShoot
						@selectManager.targetTraits = @traits
						@selectManager.isTargetSet = true
					end
				else
					if @traits.isOccupiable
						@selectManager.targetTraits = @traits
						@selectManager.isTargetSet = true
						@selectManager.inMovingMode = true
					end
				end
				@selectManager.targetTraits = @traits
				@selectManager.isTargetSet = true
			end
			
#			if @selectManager.inMovingMode && @traits.isOccupiable #If this space is occupiable and something's ready to move here, swap places
#				@selectManager.targetTraits = @traits
#				@selectManager.inMovingMode = false
#				@selectManager.isTargetSet = true
#				
#			elsif @traits.canShoot && @selectManager.inShootingMode
#				@selectManager.currentTraits = @traits
#				@selectManager.inShootingMode = false
#				@selectManager.isShooterSet = true
#					
#			elsif @traits.canShoot && @selectManager.isShooterSet
#				@selectManager.targetTraits = @traits
#				@selectManager.isShooterSet = false
#				@selectManager.isVictimSet = true
#				
#			elsif @traits.isMovable && !@selectManager.inShootingMode #If space can be moved, not in shoot mode, put it in moving mode
#				@selectManager.currentTraits = @traits
#				@selectManager.inMovingMode = true
#			end
		}
	end
	
	def setTraits(traits)
		@traits = traits
		@button.style = traits.style
		@traits.xPos = @xPos
		@traits.yPos = @yPos
	end
	
	def setAmmo(ammoAmt)
		@traits.ammo = ammoAmt
	end
	
	def setHealth(healthAmt)
		@traits.health = healthAmt
	end
	
	def getStyle #button.style[0][0] === the actual style name string?? Why?!
		return @button.style[0][0]
	end
	
end