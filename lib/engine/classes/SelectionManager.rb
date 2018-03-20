require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :currentTile, :currentName, :currentX, :currentY, :currentTraits, :targetTraits
	
	def initialize
		
		@inMovingMode = false
		
		@currentTile = nil
		
		@currentName = "Soldier"
		@currentX = nil
		@currentY = nil
		@currentTraits = nil
		
		@targetTraits = nil
	end
	
	def destroyOrig
		@currentTile.style = @targetTraits.style
	end
	
end