module GraphMath
	@@D = 1
	@@D2 = 1
	@@P = 0.01 #P is tiebreaker value, should be < (cost for 1 step/max expected path length), so p < 1/5
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
			xDistance = (targetX - currentX).abs
			yDistance = (targetY - currentY).abs
			estimate = @@D * (xDistance + yDistance) + (@@D2 - 2 * @@D) * [xDistance, yDistance].min
			return estimate * (1 + p) #breaks ties
		end
end
