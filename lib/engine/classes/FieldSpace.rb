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
			@selectManager.labelText.value = @traits.objectName #Sets name of nameLabel on sidebar
			
			if @selectManager.inMovingMode && @traits.isOccupiable #If this space is occupiable and something's ready to move here, swap places
				@selectManager.targetTraits = @traits
				@selectManager.inMovingMode = false
				@selectManager.isTargetSet = true
				
			elsif @traits.isInteractive && @selectManager.inShootingMode
				@selectManager.shooterAmmo = @traits.ammo
				@selectManager.shooterX = @xPos
				@selectManager.shooterY = @yPos
				@selectManager.inShootingMode = false
				@selectManager.isShooterSet = true
					
			elsif @traits.isInteractive && @selectManager.isShooterSet
				@selectManager.victimX = @xPos
				@selectManager.victimY = @yPos
				@selectManager.victimHealth = @traits.health
				@selectManager.isShooterSet = false
				@selectManager.isVictimSet = true
				
			elsif @traits.isMovable && !@selectManager.inShootingMode #If space can be moved, not in shoot mode, put it in moving mode
				@selectManager.currentTraits = @traits
				@selectManager.labelText.value = @traits.objectName #Sets name of nameLabel on sidebar
				@selectManager.inMovingMode = true
			end
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