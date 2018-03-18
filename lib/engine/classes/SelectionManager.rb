require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :xPos, :yPos, :style, :lastX, :lastY, :lastStyle
	
	def initialize
		@xPos = nil
		@yPos = nil
		@style = nil
	end
	
end