class Soldier < GameObject
		
    attr_accessor :weapon, :health, :ammo, :coverMod, :inOverwatch, :panelComponent, :contextComponent, :inputComponent, :isBlueTeam
    
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
        @inputComponent = SoldierInputComponent.new(self, selectManager)
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