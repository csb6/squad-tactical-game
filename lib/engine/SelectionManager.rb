require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :inShootingMode, :rootExists, :currentTile, :targetTile, :nameLabel, :isTargetSet, :isCurrentSet
	attr_accessor :ammoLabel, :healthLabel, :hitText, :isBlueTurn, :turnLabel, :isBlueTurn, :inTakeCoverMode, :coverLabel, :resetCover
	
	def initialize
		
		#Variables for action modes
		@inMovingMode = false
		@inShootingMode = false
		@inTakeCoverMode = false
		@resetCover = false
		@setContextMenu = false
		
		#Variables for actions
		@isTargetSet = false
		@isCurrentSet = false
		@currentTile = nil
		@targetTile = nil
		
		@nameLabel = TkVariable.new("")
		@healthLabel = TkVariable.new("Health: ")
		@ammoLabel = TkVariable.new("Ammo: ")
		@coverLabel = TkVariable.new("Cover: ")
		@hitText = TkVariable.new("")
		@rootExists = true
		
		@isBlueTurn = true
		@turnLabel = TkVariable.new("Blue Turn")
	end
	
	def resetAll
		@isCurrentSet, @isTargetSet, @inMovingMode, @inShootingMode = false
		@currentTile, @targetTile = nil
		@healthLabel.value = "Health: "
		@ammoLabel.value = "Ammo: "
		@coverLabel.value = "Cover: "
	end
	
end