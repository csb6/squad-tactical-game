module PathFind
    def PathFind.makePathfindingGrid(fieldArray)
        pathArray = [ ]
        
        y = 0
        r = 0
        fieldArray.each do |row|
            x = 0
            c = 0
            pathArray[y] = [ ]
            row.each do |col|
                if fieldArray[y][x].isOccupiable
                    pathArray[r][c] = fieldArray[y][x]
                    c += 1
                end
                x += 1
            end
            y += 1
            r += 1 #Hopefully at least 1 tile per row is occupiable
        end
    end
    
    def PathFind.findNeighbors(current)
        neighbors = [ ]

        i = 0
        [1, -1].each do |n|
            if (current[0]+n).between?(0, 27)
                neighbors[i] = [ current[0]+n, current[1] ]
                i += 1
            end
            if (current[1]+n).between?(0, 28)
                neighbors[i] = [ current[0], current[1]+n ]
                i += 1
            end
            if (current[0]+n).between?(0, 27) && (current[1]+n).between?(0, 28)
                neighbors[i] = [ current[0]+n, current[1]+n ]
                i += 1
            end
            if (current[0]+n).between?(0, 27) && (current[1]-n).between?(0, 28)
                neighbors[i] = [ current[0]+n, current[1]-n ]
                i += 1
            end
        end
        return neighbors
    end
    
#		def PathFind.findBestPath(currentX, currentY, targetX, targetY, fieldArray)
    def PathFind.findBestPath(currentX, currentY, targetX, targetY)
        start = [currentX, currentY]
        target = [targetX, targetY]
        g = { } #Cost to a position from start position
        f = { } #Estimated cost of going from start to end thru this point
            
        g[start] = 0
        f[start] = PathFind.estimateTravelCost(currentX,currentY,targetX,targetY)
        
        closedSet = [ ] #All values already visited
        openSet = [ start ] #All values not yet visited
        pathSoFar = { }
            
        while openSet.length > 0 #While still unvisited points left
            current = nil
            currentScore = nil
            openSet.each do |vertex| #Loop to find vertex with lowest score
                if current === nil || f[vertex] < currentScore
                    currentScore = f[vertex]
                    current = vertex
                end
            end
            
            if current === target #If goal reached
                path = [ current ]
                pathSoFar.each do |k, vertex|
                    path << vertex
                end
                puts "Path: #{path.reverse}" #Print out results when done
            end
            
            #Move current vertex to list of already visited vertices
            openSet.delete(current)
            closedSet << current
            
            PathFind.findNeighbors(current).each do |neighbor|
                if closedSet.include?(neighbor)
                    next
                end
                temp = g[current] + PathFind.estimateTravelCost(current[0],current[1],target[0],target[1])
                
                if !(openSet.include?(neighbor))
                    openSet << neighbor
                elsif temp >= g[neighbor]
                    next
                end
                
                pathSoFar[neighbor] = current
                g[neighbor] = temp
                f[neighbor] = g[neighbor] + PathFind.estimateTravelCost(neighbor[0],neighbor[1],target[0],target[1])
            end
        end
        
    end
end