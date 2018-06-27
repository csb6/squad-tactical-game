class Ai
    def initialize(field, selectionManager)
        print "Prepare to lose, human. I am initializing..."
        @field = field
        @selectManager = selectionManager

        field.findAllSoldiers
        @walls = PathFind.getWalls
        @blueSoldiers = field.blue.findSoldiers
        @redSoldiers = field.red.findSoldiers
        @mainSoldier = @redSoldiers[0] #Sgt Kolochev

        print "Done initializing.\n"
    end

    def takeTurn
        @owSoldiers = @field.findAllInOW(true)

        startPos = @mainSoldier.getCoords
        nearestEnemy = @field.blue.findNearestTo(@mainSoldier)
        puts "Nearest enemy is #{nearestEnemy.objectName}."
        attackPos = findFlankPos(true)
        FieldUtils.autoMove(startPos, attackPos, @field, @selectManager)
    end

    def findFlankPos(onRight)
        target = @field.blue.findOuterSoldier(onRight)
        targetPos = target.getCoords
        return findRelativePos(5, 0, targetPos)
    end

    def findRelativePos(x, y, targetPos) #Finds attack position close to a relative position from the target
        foundPos = false
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
end