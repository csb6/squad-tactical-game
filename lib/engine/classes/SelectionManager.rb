require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :currentTile, :currentTraits, :targetTraits, :labelText, :isTargetSet
	
	def initialize
		
		@inMovingMode = false
		@isTargetSet = false
		
		@currentTile = nil
		
		@labelText = TkVariable.new("")
		@currentTraits = nil
		
		@targetTraits = nil
	end
	
	def destroyOrig
		@currentTile.style = @targetTraits.style
	end
	
end