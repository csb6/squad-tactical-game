require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :xPos, :yPos, :style, :lastX, :lastY, :lastStyle, :name
	
	def initialize
		@xPos = nil
		@yPos = nil
		@name = "Sand"
		@style = nil
	end
	
end