require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :rootExists, :currentTraits, :targetTraits, :labelText, :isTargetSet
	
	def initialize
		
		@inMovingMode = false
		@isTargetSet = false
		
		@labelText = TkVariable.new("")
		@rootExists = true
		
		@currentTraits = nil
		@targetTraits = nil
	end
	
	def destroyOrig
		@currentTile.style = @targetTraits.style
	end
	
end