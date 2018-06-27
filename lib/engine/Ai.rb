class Ai
    def initialize(field, selectionManager)
        print "Prepare to lose, human. I am initializing..."
        @field = field
        @selectManager = selectionManager
        field.findAllSoldiers
        @blueSoldiers = field.findSoldiers(true)
        @redSoldiers = field.findSoldiers(false)
        print "Done initializing.\n"
    end

    def takeTurn
        @owSoldiers = @field.findAllInOW(true)
        target = @owSoldiers[0]
        targetPos = [ target.xPos+1, target.yPos-1 ]
        FieldUtils.autoMove([10,2], targetPos, @field, @selectManager)
    end

    def test #Tests that arrays of useful tiles are updated
        @owSoldiers = @field.findAllInOW(true)
        puts "#{@owSoldiers[0].objectName} is in overwatch at #{@owSoldiers[0].xPos}, #{@owSoldiers[0].yPos}"
        puts "#{@blueSoldiers[0].objectName} is blue and at #{@blueSoldiers[0].xPos}, #{@blueSoldiers[0].yPos}"
        puts "#{@redSoldiers[0].objectName} is red and at #{@redSoldiers[0].xPos}, #{@redSoldiers[0].yPos}"
    end
end