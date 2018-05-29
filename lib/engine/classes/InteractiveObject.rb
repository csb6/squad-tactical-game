class InteractiveObject < GameObject #Object on playing field that can be moved/has a control panel
		
	attr_reader :panelFile
	attr_accessor :isBlueTeam
	
	def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
		super
		
		@isInteractive = true
		@panelFile = ""
		@image.bind("2", proc {
			if selectManager.isBlueTurn
				updateLabels
				if !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but current is
					if (@xPos >= 24 && @yPos >= 2) || (@yPos >= 27 && @xPos >= 4) #Upper left position /
						a = -100; c = -65; e = -7
						b = -50; d = -40; f = -7
					elsif @xPos < 4 && @yPos >= 27 #Upper right position /
						a = 100; c = 35; e = 7
						b = -50; d = -40; f = -7
					elsif @xPos >= 24 && @yPos < 2 #Bottom left position /
						a = -100; c = -65; e = -7
						b = 50; d = 20; f = 7
					else #Bottom right position /
						a = 100; c = 35; e = 7
						b = 50; d = 20; f = 7
					end

					currentRow = selectManager.currentTraits.yPos
					currentCol = selectManager.currentTraits.xPos
					hitChance = GraphMath.calcHitChance(currentCol, currentRow, @xPos, @yPos, 1)

					contextMenu = TkcRectangle.new(@rootWin, @x1, @y1, @x1+a, @y1+b, :fill => 'grey')
						testText = TkcText.new(@rootWin, @x1+c, @y1+d, :text => "HC: #{hitChance}%")
						exitButton = TkcText.new(@rootWin, @x1+e, @y1+f, :text => "X")
						exitButton.bind("1", proc {
							contextMenu.delete
							exitButton.delete
							testText.delete
						})

				end
			end
		})
	end
	
	def openPanel
		@panel = TkToplevel.new(@rootWin) do
			title "Inventory"
			background "grey"
			geometry '500x200-350+250'
		end
	end
	
end
	
	class Cannon < InteractiveObject #Can launch projectiles, can be pushed aside
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			super
			
			@description = "A well-fortified, land-based weapon with powerful range"
			@weight = 300
			@size = 1
			@panelFile = "cannonControlPanel"
			@image[:image] = Constants::CANNON_IMAGE
		end
		
	end
	
	
	class Terminal < InteractiveObject #Can control base, can be pushed aside
		
		def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			super
			
			@description = "A computer used for operation of devices or communication with outsiders"
			@weight = 100
			@size = 1
			@panelFile = ""
			@image[:image] = Constants::TERM_IMAGE
		end
		
	end
	
		class BlueTerminal < Terminal
			
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A blue-colored computer used for operation of devices or communication with outsiders"
				@panelFile = "blueTerminalControlPanel"
			end
		end
		
		class RedTerminal < Terminal
			
			def initialize(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A red-colored computer used for operation of devices or communication with outsiders"
				@panelFile = "redTerminalControlPanel"
				@isBlueTeam = false
			end
		end
	
	class Soldier < InteractiveObject
		
		attr_accessor :weapon, :health, :ammo, :coverMod
		
		def initialize(objectName, weapon, xPos, yPos, x1, y1, selectManager, rootWin)
			super(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
			
			@description = "A stalwart, sometimes trigger-happy, GI"
			@weight = 50
			@size = 1
			@panelFile = "soldierInfoPanel"
			@isMovable = true
			@canShoot = true
			@weapon = weapon
			@health = 100
			@ammo = 50
			@coverMod = 1

			@image.bind("1", proc {
				if selectManager.isBlueTurn
					updateLabels
					performAction
				end
			})
		end

		def performAction #Makes the soldier move or shoot something, checking what is selected, if target/current positions are set

			if !@selectManager.isCurrentSet && @isMovable #If no current yet and this tile = movable
				setCurrent
				
			elsif !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but current is
				setTarget
			end
		end
		
		
		def setCurrent #tile to be this tile if it's the turn of the tile's team
			if @isBlueTeam === @selectManager.isBlueTurn
				@selectManager.currentTraits = self
				@selectManager.isCurrentSet = true
			end
		end
		
		def openPanel
			super
			objectName = @objectName
			description = @description
			@panel["title"] = objectName
			
			@descriptionLabel = TkLabel.new(@panel) do
				text "Description:\n#{description}"
				wraplength 350
				grid('row' => 0, 'column' => 0)
			end
			
			weapon = @weapon
			@weaponLabel = TkLabel.new(@panel) do
				text "Weapon:\n#{weapon}"
				grid('row' => 1, 'column' => 0)
			end
		end
	end
	
		class BlueSoldier < Soldier
			
			def initialize(objectName, weapon, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A stalwart, sometimes trigger-happy, GI working for Blu-o-polis"
				@image[:image] = Constants::B_SOLDIER_IMAGE
			end
			
		end
		
		class RedSoldier < Soldier
			
			def initialize(objectName, weapon, xPos, yPos, x1, y1, selectManager, rootWin)
				super
				
				@description = "A stalwart, sometimes trigger-happy, GI working for Red City"
				@image[:image] = Constants::R_SOLDIER_IMAGE
				@isBlueTeam = false
			end
			
		end
		