require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :currentTile, :currentName, :currentX, :currentY, :currentStyle, :targetStyle
	
	def initialize
		
		@inMovingMode = false
		
		@currentTile = nil
		
		@currentName = "Tubby"
		@currentX = nil
		@currentY = nil
		@currentStyle = nil
		
		@targetStyle = nil
	end
	
	def destroyOrig
		@currentTile.style = @targetStyle
	end
	
end