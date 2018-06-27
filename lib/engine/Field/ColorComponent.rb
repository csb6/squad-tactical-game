class Blue
    def initialize(field)
        @field = field
        @traits = CSV.read(Constants::BLUE_CHAR_PATH, :col_sep => "	")
        @i = 0
        @isBlue = true
    end

    def getName
        return @traits[@i][0]
    end

    def getGun
        gun = @traits[@i][1]
        @i += 1
        return gun
    end

    def findSoldiers
        @soldiers = [ ]
        @field.soldiers.each do |soldier|
            if soldier.isBlueTeam === @isBlue
                @soldiers << soldier
            end
        end
        return @soldiers
    end

    def findNearestTo(tile)
        tilePos = tile.getCoords
        nearest = nil
        @soldiers.each do |soldier|
            soldierPos = soldier.getCoords
            distance = GraphMath.distanceFormula( soldierPos[0], soldierPos[1], tilePos[0], tilePos[1] )
            if nearest === nil 
                nearest = [ soldier, distance ]
            elsif distance < nearest[1]
                nearest = [ soldier, distance ]
            end
        end
        return nearest[0]
    end

    def findOuterSoldier(onRight)
        outerMost = nil
        @soldiers.each do |soldier|
            soldierX = soldier.xPos
            if outerMost === nil
                outerMost = [ soldier, soldierX ]
            else
                if onRight
                    if soldierX > outerMost[1]
                        outerMost = [ soldier, soldierX ]
                    end
                else
                    if soldierX < outerMost[1]
                        outerMost = [ soldier, soldierX ]
                    end
                end
            end
        end
        return outerMost[0]
    end
end

    class Red < Blue
        def initialize(field)
            super
            @traits = CSV.read(Constants::RED_CHAR_PATH, :col_sep => "	")
            @isBlue = false
        end
    end