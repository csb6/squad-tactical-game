module GraphMath
	@@D = 1
	@@P = 0.01 #P is tiebreaker value, should be < (cost for 1 step/max expected path length), so p < 1/5
	@@Barriers = [ ]
	#Math Methods
		def GraphMath.distanceFormula(x1, y1, x2, y2)
			distance = Math.sqrt( (x2-x1)**2 + (y2-y1)**2 )
			return distance.round(1)
		end
		
		
		def GraphMath.hitDeterminer(chanceToHit)
			if rand(100) <= chanceToHit
				return true
			else
				return false
			end
		end
		
		
		def GraphMath.calcHitChance(currentX, currentY, targetX, targetY, coverModifier, fieldArray)
			distance = GraphMath.distanceFormula(currentX, currentY, targetX, targetY)
			if distance >= 10
				chance = 0
			elsif distance < 2
				chance = 95
			else
				chance = 32 * Math.sqrt(-distance+10) #Chance decreases as distance does
				[1, -1].each do |n|
					a = fieldArray[targetY+n][targetX]
					b = fieldArray[targetY][targetX+n]
					c = fieldArray[targetY+n][targetX+n]
					d = fieldArray[targetY-n][targetX+n]
					if a.objectName === "Wall" || b.objectName === "Wall" || c.objectName === "Wall" || d.objectName === "Wall"
						chance *= 0.8
						break
					end
				end
			end
			return (chance * coverModifier).round(1)
		end
		
		
		def GraphMath.estimateTravelCost(currentX, currentY, targetX, targetY)
			estimate = @@D * GraphMath.distanceFormula(currentX,currentY,targetX,targetY)
			return estimate * (1 + @@P)
		end
		
		
		def GraphMath.makePathfindingGrid(fieldArray)
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
		
		def GraphMath.findNeighbors(current)
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
		
#		def GraphMath.findBestPath(currentX, currentY, targetX, targetY, fieldArray)
		def GraphMath.findBestPath(currentX, currentY, targetX, targetY)
			start = [currentX, currentY]
			target = [targetX, targetY]
			g = { } #Cost to a position from start position
			f = { } #Estimated cost of going from start to end thru this point
				
			g[start] = 0
			f[start] = GraphMath.estimateTravelCost(currentX,currentY,targetX,targetY)
			
			closedSet = [ ] #All values already visited
			openSet = [ start ] #All values not yet visited
			pathSoFar = [ ]
				
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
					pathSoFar.each do |vertex|
						path << vertex
					end
					puts "Path: #{path.reverse}" #Print out results when done
				end
				
				#Move current vertex to list of already visited vertices
				openSet.delete(current)
				closedSet << current
				
				GraphMath.findNeighbors(current).each do |neighbor|
					if closedSet.include?(neighbor)
						next
						puts "This failed"
					end
					temp = g[current] + GraphMath.estimateTravelCost(current[0],current[1],target[0],target[1])
					
					if !openSet.include?(neighbor)
						openSet << neighbor
					elsif temp >= g[neighbor]
						next
					end
					
					pathSoFar << current
					g[neighbor] = temp
					f[neighbor] = g[neighbor] + GraphMath.estimateTravelCost(neighbor[0],neighbor[1],target[0],target[1])
				end
			end
			
		end
end
