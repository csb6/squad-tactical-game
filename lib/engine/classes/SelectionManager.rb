require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :xPos, :yPos, :style
	
	def initialize
		@xPos = nil
		@yPos = nil
		@style = nil
		
		@lastX = @xPos
		@lastY = @yPos
		@lastStyle = @style
	end
	
	def updateStyle
		if @lastX != nil
			
		end
	end
	
end