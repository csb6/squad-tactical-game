require 'engine/field/ColorComponent'
require 'engine/field/OWComponent'

class Field

    attr_reader :soldiers, :blue, :red, :overwatch

    def initialize(selectionManager)
        @selectManager = selectionManager
        @fieldArray = Array.new(29){ Array.new(28) }
        @blue = Blue.new(self)
        @red = Red.new(self)
        @overwatch = OWComponent.new(self)
        @soldiers = [ ]
    end

    def addTile(pos, tile)
        @fieldArray[ pos[1] ][ pos[0] ] = tile
    end

    def getTile(pos)
        return @fieldArray[ pos[1] ][ pos[0] ]
    end

    def getFieldArray
        return @fieldArray
    end

    def findAllSoldiers
        y = 0
        @fieldArray.each do |row|
            x = 0
            row.each do |tile|
                if tile.canShoot
                    @soldiers << @fieldArray[y][x]
                end
                x += 1
            end
            y += 1
        end
    end

    def findSoldiers(lookingForBlue)
        someSoldiers = [ ]
        @soldiers.each do |soldier|
            if soldier.isBlueTeam === lookingForBlue
                someSoldiers << soldier
            end
        end
        return someSoldiers
    end

    def getAllWalls
        wallTiles = [ ]
        @fieldArray.each do |row|
        	row.each do |tile|
        		if tile.description === "A sturdy, unmovable barrier"
        			wallTiles << [tile.xPos, tile.yPos]
        		end
        	end
        end
        return wallTiles
    end

    def swapPosition(startPos, targetPos)
        targetPx = @fieldArray[ targetPos[1] ][ targetPos[0] ].getPxCoords
        startPx = @fieldArray[ startPos[1] ][ startPos[0] ].getPxCoords

        @fieldArray[ startPos[1] ][ startPos[0] ].setPosition(targetPos, targetPx)
        @fieldArray[ targetPos[1] ][ targetPos[0] ].setPosition(startPos, startPx)
        temp = @fieldArray[ startPos[1] ][ startPos[0] ]
        @fieldArray[ startPos[1] ][ startPos[0] ] = @fieldArray[ targetPos[1] ][ targetPos[0] ]
        @fieldArray[ targetPos[1] ][ targetPos[0] ] = temp
    end

    def setCoverMod(pos, coverMod)
        @fieldArray[pos[1]][pos[0]].coverMod = coverMod
    end

    def clearCoverMods
        y = 0
        @fieldArray.each do |row|
            x = 0
            row.each do
                if @fieldArray[y][x].canShoot
                    if @fieldArray[y][x].isBlueTeam === @selectManager.isBlueTurn
                        @fieldArray[y][x].coverMod = 1
                    end
                end
                x += 1
            end
            y += 1
        end
    end

    def setAmmo(pos, amt)
        @fieldArray[pos[1]][pos[0]].ammo += amt
    end

    def setHealth(pos, amt)
        @fieldArray[pos[1]][pos[0]].health += amt
    end

    def deathCheck(pos) #Deactivates object at given position if health drops below 0
        soldier = @fieldArray[pos[1]][pos[0]]
        if soldier.health <= 0
            puts "#{soldier.objectName} died."
            soldier.die
        end
    end

    def getPxCoords(pos)
        return [ @fieldArray[pos[1]][pos[0]].x1, @fieldArray[pos[1]][pos[0]].y1 ]
    end
    
    def flashImage(pos, pic)
		@fieldArray[pos[1]][pos[0]].flashImage(pic)
    end
    
    def checkIfOccup(pos)
        return @fieldArray[pos[1]][pos[0]].isOccupiable
    end

    def checkIfExists(pos)
        if pos[0] < 28 && pos[1] < 29
            if pos[0] > 0 && pos[1] > 0
                return true
            end
        end

        return false
    end
end