require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :inShootingMode, :rootExists, :currentTraits, :targetTraits, :labelText, :isTargetSet, :isCurrentSet
	
	def initialize
		
		#Variables for action modes
		@inMovingMode = false
		@inShootingMode = false
		
		#Variables for actions
		@isTargetSet = false
		@isCurrentSet = false
		@currentTraits = nil
		@targetTraits = nil
		
		@labelText = TkVariable.new("")
		@rootExists = true
	end
	
end