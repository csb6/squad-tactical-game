require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :inShootingMode, :rootExists, :currentTraits, :targetTraits, :nameLabel, :isTargetSet, :isCurrentSet
	attr_accessor :ammoLabel, :healthLabel
	
	def initialize
		
		#Variables for action modes
		@inMovingMode = false
		@inShootingMode = false
		
		#Variables for actions
		@isTargetSet = false
		@isCurrentSet = false
		@currentTraits = nil
		@targetTraits = nil
		
		@nameLabel = TkVariable.new("")
		@healthLabel = TkVariable.new("Health: ")
		@ammoLabel = TkVariable.new("Ammo: ")
		@rootExists = true
	end
	
	def resetAll
		@isCurrentSet, @isTargetSet, @inMovingMode, @inShootingMode = false
		@currentTraits, @targetTraits = nil
		@healthLabel.value = "Health: "
		@ammoLabel.value = "Ammo: "
	end
	
end