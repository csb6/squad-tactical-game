module GraphMath
	@@D = 1
	@@P = 0.001 #P is tiebreaker value, should be < (cost for 1 step/max expected path length), so p < 1/5
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
		
		
		def GraphMath.calcHitChance(currentX, currentY, targetX, targetY, coverModifier)
			distance = GraphMath.distanceFormula(currentX, currentY, targetX, targetY)
			if distance >= 10
				chance = 0
			elsif distance < 2
				chance = 95
			else
				chance = 32 * Math.sqrt(-distance+10) #Chance decreases as distance does
				[1, -1].each do |n|
					a = [targetX+n, targetY]
					b = [targetX, targetY+n]
					c = [targetX+n, targetY+n]
					d = [targetX-n, targetY+n]
					[a,b,c,d].each do |x|
						PathFind.getWalls.each do |wall|
							if wall === x
								chance *= 0.8
								break
							end
						end
					end
				end
			end
			return (chance * coverModifier).round(1)
		end
		
		
		def GraphMath.estimateTravelCost(currentX, currentY, targetX, targetY)
			estimate = @@D * GraphMath.distanceFormula(currentX,currentY,targetX,targetY)
			return estimate * (1 + @@P)
		end
		
end
