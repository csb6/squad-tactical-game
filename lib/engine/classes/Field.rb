class Field
    @soldiers = [ ]
    @OWSoldiers = [ ]

    def initialize(selectionManager)
        @selectManager = selectionManager
        @fieldArray = Array.new(29){ Array.new(28) }
        @redTraits = CSV.read(Constants::RED_CHAR_PATH, :col_sep => "	")
        @blueTraits = CSV.read(Constants::BLUE_CHAR_PATH, :col_sep => "	")
        @bi = 0
        @ri = 0
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

    def getBlueName
        return @blueTraits[@bi][0]
    end

    def getBlueGun
        gun = @blueTraits[@bi][1]
        @bi += 1
        return gun
    end

    def getRedName
        return @redTraits[@ri][0]
    end

    def getRedGun
        gun = @blueTraits[@ri][1]
        @ri += 1
        return gun
    end

    def findAllInOW(lookingForBlue)
        y = 0
        @fieldArray.each do |row|
            x = 0
            row.each do |tile|
                if tile.canShoot
                    if tile.isBlueTeam === lookingForBlue
                        @OWSoldiers << @fieldArray[y][x]
                    end
                end
                x += 1
            end
            y += 1
        end
    end

    def getAllInOW
        return @OWSoldiers
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

    def getAllSoldiers
        return @soldiers
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

    def updateSoldier(soldier)
        i = 0
        @soldiers.each do |s|
            if s.objectName === soldier.objectName
                @soldiers[i] = soldier
            end
            i += 1
        end
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

    def getPxCoords(pos)
        return [ @fieldArray[pos[1]][pos[0]].x1, @fieldArray[pos[1]][pos[0]].y1 ]
    end
    
    def flashImage(pos, pic)
		@fieldArray[pos[1]][pos[0]].flashImage(pic)
    end
    
    def checkIfOccup(pos)
        return @fieldArray[pos[1]][pos[0]].isOccupiable
    end
end