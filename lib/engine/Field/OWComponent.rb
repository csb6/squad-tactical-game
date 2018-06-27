class OWComponent #Overwatch Component
    attr_reader :soldiers

    def initialize(field)
        @field = field
        @soldiers = [ ]
    end

    def findAll(lookingForBlue) #Needs to be called once per turn
        @soldiers = [ ]
        y = 0
        @field.getFieldArray.each do |row|
            x = 0
            row.each do |tile|
                if tile.canShoot
                    if tile.isBlueTeam === lookingForBlue
                        if tile.inOverwatch
                            @soldiers << @fieldArray[y][x]
                        end
                    end
                end
                x += 1
            end
            y += 1
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