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
            @selectManager.currentTile = self
            @selectManager.isCurrentSet = true
        end
    end

    def openContextMenu
        #Configured for 28x29 field
        if (@xPos >= 24 && @yPos >= 2) || (@yPos >= 27 && @xPos >= 4) #Upper left position /
            a = -100; c = -63; e = -7; g = -25
            b = -50; d = -40; f = -7
        elsif @xPos < 4 && @yPos >= 27 #Upper right position /
            a = 100; c = 38; e = 7; g = -25
            b = -50; d = -40; f = -7
        elsif @xPos >= 24 && @yPos < 2 #Bottom left position /
            a = -100; c = -63; e = -7; g = 35
            b = 50; d = 20; f = 7
        else #Bottom right position /
            a = 100; c = 38; e = 7; g = 35
            b = 50; d = 20; f = 7
        end

        currentRow = selectManager.currentTile.yPos
        currentCol = selectManager.currentTile.xPos
        hitChance = GraphMath.calcHitChance(currentCol, currentRow, @xPos, @yPos, @coverMod) #Calc chance of current selected object to hit self

        @contextMenu = TkcRectangle.new(@rootWin, @x1, @y1, @x1+a, @y1+b, :fill => 'grey')
            @hitText = TkcText.new(@rootWin, @x1+c, @y1+d, :text => "HC: #{hitChance}%")
            @attackButton = TkcText.new(@rootWin, @x1+c, @y1+g, :text => "Attack")
            @exitButton = TkcText.new(@rootWin, @x1+e, @y1+f, :text => "X")

            def closeContextMenu
                @contextMenu.delete
                @attackButton.delete
                @exitButton.delete
                @hitText.delete
            end

            @attackButton.bind("1", proc {
                if selectManager.isCurrentSet && selectManager.currentTile.isBlueTeam === selectManager.isBlueTurn
                    selectManager.inShootingMode = true
                    setTarget
                    closeContextMenu
                end
            })
            @exitButton.bind("1", proc {
                closeContextMenu
            })
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