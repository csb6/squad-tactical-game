require 'engine/util/FieldUtils'
require 'engine/util/PathFind'
require 'engine/util/GraphMath'

class Ai
    def initialize(field, selectionManager)
        print "Prepare to lose, human. I am initializing..."
        @field = field
        @selectManager = selectionManager

        @field.findAllSoldiers
        @walls = PathFind.getWalls
        @blueSoldiers = field.blue.findSoldiers
        @redSoldiers = field.red.findSoldiers
        @mainSoldier = @redSoldiers[0] #Sgt Kolochev

        print "Done initializing.\n"
    end

    def takeTurn
        @owSoldiers = @field.overwatch.findAll(true)

        startPos = @mainSoldier.getCoords
        nearestEnemy = @field.blue.findNearestTo(@mainSoldier)
        puts "Nearest enemy is #{nearestEnemy.objectName}."
        attackPos = findFlankPos(true)
        FieldUtils.autoMove(startPos, attackPos, @field, @selectManager) #TODO: Fix this mess. AI decisions should be spread into multiple ticks, using util methods in Game object, not FieldUtils
    end

    def findFlankPos(onRight)
        target = @field.blue.findOuterSoldier(onRight)
        targetPos = target.getCoords
        return findRelativePos(5, 0, targetPos)
    end

    def findRelativePos(x, y, targetPos) #Finds attack position close to a relative position from the target
        candidatePos = [ targetPos[0]+x, targetPos[1]+y ]

        if !@field.checkIfExists(candidatePos) || !@field.checkIfOccup(candidatePos)
            neighbors = PathFind.findNeighbors(candidatePos, @field.getFieldArray)

            if neighbors != [ ]
                currentBest = nil
                neighbors.each do |neighbor|
                    distance = GraphMath.distanceFormula( neighbor[0], neighbor[1], targetPos[0], targetPos[1] )
                    if currentBest === nil
                        currentBest = [ neighbor, distance ]
                    else
                        if distance > currentBest[1]
                            currentBest = [ neighbor, distance ]
                        end
                    end
                end
                return currentBest[0]
            else
                return [3,3]
            end
        else
            return candidatePos
        end
    end
end