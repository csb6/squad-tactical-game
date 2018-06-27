class Ai
    def initialize(field, selectionManager)
        print "Prepare to lose, human. I am initializing..."
        @field = field
        @selectManager = selectionManager

        field.findAllSoldiers
        @walls = PathFind.getWalls
        @blueSoldiers = field.findSoldiers(true)
        @redSoldiers = field.findSoldiers(false)
        @mainSoldier = @redSoldiers[0] #Sgt Kolochev

        print "Done initializing.\n"
    end

    def takeTurn
        @owSoldiers = @field.findAllInOW(true)

        startPos = @mainSoldier.getCoords
        target = findNearestEnemy(@mainSoldier)
        targetPos = target.getCoords

        attackPos = findAttackPos(targetPos)
        puts "Target: #{target.objectName}. Planned attack Pos: #{attackPos}"
        FieldUtils.autoMove(startPos, attackPos, @field, @selectManager)
    end

    def findNearestEnemy(tile)
        tilePos = tile.getCoords
        nearest = nil
        @blueSoldiers.each do |soldier|
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

    def findAttackPos(targetPos)
        foundPos = false
        x = 5
        y = -5
        while !foundPos
            candidatePos = [ targetPos[0]+x, targetPos[1]+y ]
            if @field.checkIfOccup(candidatePos)
                foundPos = true
            else
                x += 1
                y -= 1
            end
        end
        return candidatePos
    end

    def test #Tests that arrays of useful tiles are updated
        @owSoldiers = @field.findAllInOW(true)
        puts "#{@owSoldiers[0].objectName} is in overwatch at #{@owSoldiers[0].xPos}, #{@owSoldiers[0].yPos}"
        puts "#{@blueSoldiers[0].objectName} is blue and at #{@blueSoldiers[0].xPos}, #{@blueSoldiers[0].yPos}"
        puts "#{@redSoldiers[0].objectName} is red and at #{@redSoldiers[0].xPos}, #{@redSoldiers[0].yPos}"
    end
end