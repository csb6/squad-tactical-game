require "engine/util/GraphMath"
module PathFind

    @@walls = [ ]
    def PathFind.setWalls(walls)
        @@walls = walls
    end

    def PathFind.getWalls
        return @@walls
    end

    def PathFind.findAllWallsOnField(field) #Consider using this to precalculate where all walls are on a level, store it on 1st line of each map
        return field.getAllWalls
    end
    
    def PathFind.findNeighbors(current, field)
        neighbors = [ ]
        values = [ [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1] ]

        values.each do |x, y|
            point = [ current[0]+x, current[1]+y ]
            if point[0] >= 0 && point[1] >= 0
                if point[0] < 28 && point[1] < 29
                    if field[ point[1] ][ point[0] ].isOccupiable
                        neighbors << point
                    end
                end
            end
        end
        return neighbors
    end
    
    def PathFind.getSmallestFScore(fScore, openSet)
        # start = Time.now
        lowPoint = nil
        openSet.each do |point|
            if fScore[point] != nil
                score = fScore[point]
                if lowPoint === nil
                    lowPoint = [point, score]
                elsif score < lowPoint[1]
                    lowPoint = [point, score]
                end
            end
        end
        # puts "Smallest score in #{Time.now-start}"
        return lowPoint[0]
    end

    def PathFind.reconstructPath(cameFrom, start, target)
        path = [ target ]
        while target != start
            prevPoint = cameFrom[target]
            path << prevPoint
            target = prevPoint
        end
        return path.reverse
    end

    def PathFind.findBestPath(start, target, fieldArray)
        # start1 = Time.now
        openSet = [ start ]
        closedSet = [ ]

        cameFrom = { }
        gScore = { } #Cost from start to given point
        gScore[start] = 0
        fScore = { } #Cost from start to target through this point
        fScore[start] = GraphMath.estimateTravelCost( start[0], start[1], target[0], target[1] )

        while !openSet.empty?
            current = PathFind.getSmallestFScore(fScore, openSet)
            if current === target
                # puts "Found BP in: #{Time.now-start1}"
                return PathFind.reconstructPath(cameFrom, start, target)
            end
            openSet.delete(current)
            closedSet << current
            neighbors = PathFind.findNeighbors(current, fieldArray)

            neighbors.each do |neighbor|
                if closedSet.include?(neighbor)
                    next
                end
                if !openSet.include?(neighbor)
                    openSet << neighbor
                end
                tempG = gScore[current] + GraphMath.estimateTravelCost( current[0], current[1], neighbor[0], neighbor[1] )
                if gScore.has_key?(neighbor)
                    if tempG >= gScore[neighbor]
                        next
                    end
                end

                cameFrom[neighbor] = current
                gScore[neighbor] = tempG
                fScore[neighbor] = gScore[neighbor] + GraphMath.estimateTravelCost( neighbor[0], neighbor[1], target[0], target[1] )
            end
        end
        puts "Error: no path found"

    end
end