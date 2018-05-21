require_relative "GraphMath"
module PathFind

    WALL_TILES = [ [7, 0], [7, 3], [7, 4], [8, 4], [9, 4], [10, 4], [10, 5], [10, 6] ]

    def PathFind.checkIfWall(point)
        isWall = false
        WALL_TILES.each do |tile|
            if tile[0] === point[0] && tile[1] === point[1]
                isWall = true
                break
            end
        end
        return isWall
    end
    
    def PathFind.findNeighbors(current)
        neighbors = [ ]
        values = [ [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1] ]

        values.each do |x, y|
            point = [ current[0]+x, current[1]+y ]
            if point[0] >= 0 && point[1] >= 0
                if point[0] < 28 && point[1] < 29
                    isWall = PathFind.checkIfWall(point)
                    if !isWall
                        neighbors << point
                    end
                end
            end
        end
        return neighbors
    end
    
    def PathFind.getSmallestFScore(fScore, openSet)
        lowPoint = nil
        fScore.each do |point, score|
            if openSet.include?(point)
                if lowPoint === nil
                    lowPoint = [point, score]
                elsif score < lowPoint[1]
                    lowPoint = [point, score]
                end
            end
        end
        return lowPoint[0]
    end

    def PathFind.reconstructPath(cameFrom, start, target)
        point = target
        path = [ point ]
        while point != start
            prevPoint = cameFrom[point]
            path << prevPoint
            point = prevPoint
        end
        return path.reverse
    end

    def PathFind.findBestPath(start, target)
        openSet = [ start ]
        closedSet = [ ]

        cameFrom = { }
        gScore = { } #Cost from start to given point
        gScore[start] = 0
        fScore = { } #Cost from start to target through this point
        fScore[start] = GraphMath.estimateTravelCost( start[0], start[1], target[0], target[1] )
        i = -1
        while !openSet.empty?
            i += 1
            current = PathFind.getSmallestFScore(fScore, openSet)
            if current === target
                return PathFind.reconstructPath(cameFrom, start, target)
            end
            openSet.delete(current)
            closedSet << current
            neighbors = PathFind.findNeighbors(current)

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
        puts "Didn't work as intended."

    end
end