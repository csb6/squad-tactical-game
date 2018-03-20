require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :currentName, :currentX, :currentY, :currentStyle, :targetStyle
	
	def initialize
		
		@inMovingMode = false
		
		@currentName = "Tubby"
		@currentX = nil
		@currentY = nil
		@currentStyle = nil
		
		@targetStyle = nil
	end
	
end