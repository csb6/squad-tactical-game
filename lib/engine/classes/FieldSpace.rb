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
			else
				@selectManager.healthLabel.value = "Health: "
				@selectManager.ammoLabel.value = "Ammo: "
			end
			
			
			if !@selectManager.isCurrentSet && @traits.isMovable #If no current yet and this tile = movable, one pressed = target
				@selectManager.currentTraits = @traits
				@selectManager.isCurrentSet = true
				
			elsif !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but have current, one pressed = target
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