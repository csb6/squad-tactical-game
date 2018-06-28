class OWComponent #Overwatch Component
    attr_reader :soldiers

    def initialize(field)
        @field = field
        @soldiers = [ ]
    end

    def findAll(lookingForBlue) #Needs to be called once per turn
        @soldiers = [ ]

        @field.soldiers.each do |soldier|
            if soldier.isBlueTeam === lookingForBlue
                if soldier.inOverwatch
                    @soldiers << soldier
                end
            end
        end
        return @soldiers
    end

    def remove(pos)
        i = 0
        @soldiers.each do |s|
            if s.getCoords === pos
                @soldiers.delete_at(i)
                break
            end
            i += 1
        end
    end
end