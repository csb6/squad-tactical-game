module GraphMath
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
		
		def GraphMath.calcHitChance(currentX, currentY, targetX, targetY, fieldArray)
			distance = GraphMath.distanceFormula(currentX, currentY, targetX, targetY)
			if distance >= 10
				chance = 0
			elsif distance < 2
				chance = 95
			else
				chance = 32*Math.sqrt(-distance+10) #Chance decreases as distance does
				[1, -1].each do |n|
					a = fieldArray[targetX+n][targetY]
					b = fieldArray[targetX][targetY+n]
					c = fieldArray[targetX+n][targetY+n]
					d = fieldArray[targetX-n][targetY+n]
					if a.traits.objectName === "Wall" || b.traits.objectName === "Wall" || c.traits.objectName === "Wall" || d.traits.objectName === "Wall"
						chance *= 0.8
						break
					end
				end
			end
			return chance.round(1)
		end
end
