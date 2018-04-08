require 'singleton'

class SelectionManager
	include Singleton
	
	attr_accessor :inMovingMode, :rootExists, :currentTraits, :targetTraits, :labelText, :isTargetSet, :inShootingMode, :isShooterSet
	attr_accessor :isVictimSet, :shooterAmmo, :shooterX, :shooterY, :victimHealth, :victimX, :victimY
	
	def initialize
		
		#Variables for moving soldiers
		@inMovingMode = false
		@isTargetSet = false
		@currentTraits = nil
		@targetTraits = nil
		
		#Variables for attacking
		@inShootingMode = false
		@isShooterSet = false
		@isVictimSet = false
		@shooterAmmo = nil
			@shooterX = nil
			@shooterY = nil
		@victimHealth = nil
			@victimX = nil
			@victimY = nil
		
		@labelText = TkVariable.new("")
		@rootExists = true
	end
	
end