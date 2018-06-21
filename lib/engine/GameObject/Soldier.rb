class Soldier < GameObject
		
    attr_accessor :weapon, :health, :ammo, :coverMod, :inOverwatch, :panelComponent, :isBlueTeam
    
    def initialize(objectName, weapon, xPos, yPos, x1, y1, selectManager, rootWin)
        super(objectName, xPos, yPos, x1, y1, selectManager, rootWin)
        
        @description = "A stalwart, sometimes trigger-happy, GI"
        @weight = 50
        @size = 1
        @isMovable = true
        @canShoot = true
        @weapon = weapon
        @health = 100
        @ammo = 50
        @coverMod = 1
        @inOverwatch = false
        @isBlueTeam = true
        @contextComponent = ContextComponent.new(self, rootWin, selectManager)
        @panelComponent = SoldierPanelComponent.new(self, rootWin)

        @image.bind("1", proc {
            if selectManager.isBlueTurn
                updateLabels
                performAction
            end
        })

        @image.bind("2", proc {
			if selectManager.isBlueTurn
				updateLabels
				if !@selectManager.isTargetSet && @selectManager.isCurrentSet #If no tile target yet, but current is
					@contextComponent.openContextMenu
				end
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
            @selectManager.currentTile = self
            @selectManager.isCurrentSet = true
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