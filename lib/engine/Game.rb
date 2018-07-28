require_relative 'util/Constants'
require_relative 'util/GraphMath'
require_relative 'Ai'
require_relative 'GameObject/GameObject'
require_relative 'GameObject/Soldier'
require_relative 'GameObject/StaticObject'
require_relative 'GameObject/OccupiableObject'

#Updates appearance of @window as pieces are selected, move around, or perform actions on each other

class Game

	def initialize(selectionManager, window)
		@selectionManager = selectionManager
		@window = window
		@canvas = TkCanvas.new(@window) do
			width 800 - 102
			height 724
			grid('row' => 0, 'column' => 0)
		end
		@field = Field.new(@selectionManager)
		drawField
		@ai = Ai.new(@field, @selectionManager)
	end

	def updateField
		if @selectionManager.endTurn
			endTurn

		elsif @selectionManager.isBlueTurn
			if @selectionManager.inMovingMode
				@field.overwatch.findAll(false)
				manualMove
				
			elsif @selectionManager.inTakeCoverMode
				setCurrentCoverMod
				
			elsif @selectionManager.inShootingMode && @selectionManager.isTargetSet
				shooterPos = @selectionManager.currentTile.getCoords
				targetPos = @selectionManager.targetTile.getCoords
				targetMod = @selectionManager.targetTile.coverMod
				shootTarget(shooterPos, targetPos, targetMod)
			end

		elsif !@selectionManager.isBlueTurn #Red team is CPU controlled, follows path
			@ai.takeTurn
			@selectionManager.endTurn = true
		end
	end

	def drawField #Assigns styles to buttons, creates class instances w/ buttons' positions
		r = 15
		y = 0
		CSV.foreach(Constants::LEVEL_PATH, :col_sep => "	") do |row|
			if row[0][0] != "#"
				c = 14
				x = 0

				row.each do |letter|
					pos = [x,y]
					case letter
						when 's' #Sand tile
							@field.addTile(pos, Sand.new("Sand", x, y, c, r, @selectionManager, @canvas) )
							
						when 'w' #Wall tile
							@field.addTile(pos, Wall.new("Wall", x, y, c, r, @selectionManager, @canvas) )
							
						when 'rh' #Soldier tile
							@field.addTile(pos, RedSoldier.new(@field.red.getName, @field.red.getGun, x, y, c, r, @selectionManager, @canvas) )
							
						when 'bh'
							@field.addTile(pos, BlueSoldier.new(@field.blue.getName, @field.blue.getGun, x, y, c, r, @selectionManager, @canvas) )
					end
					c += 25
					x += 1
				end
				r += 25
				y += 1
			else
				processedRow = [ ]
				i = 0
				row.each do |point|
					temp = point.delete("#").split(",")
					coord = [ temp[0].to_i, temp[1].to_i ]
					processedRow[i] = coord
					i += 1
				end
				PathFind.setWalls(processedRow)
			end
		end
	end
	
	def setCurrentCoverMod
        currentPos = @selectionManager.currentTile.getCoords
        
        @field.setCoverMod(currentPos, 0.8)
        
        @selectionManager.coverLabel.value = "Cover: #{@field.getTile(currentPos).coverMod}"
        @selectionManager.isCurrentSet = false
        @selectionManager.inTakeCoverMode = false
    end

    def endTurn
        @selectionManager.isBlueTurn = !@selectionManager.isBlueTurn
        @selectionManager.resetAll
        @selectionManager.endTurn = false
        
        if @selectionManager.isBlueTurn
            @selectionManager.turnLabel.value = "Blue Turn"
        else
            @selectionManager.turnLabel.value = "Red Turn "
        end
        
        @field.clearCoverMods
    end

    def manualMove
        targetPos = @selectionManager.targetTile.getCoords
        currentPos = @selectionManager.currentTile.getCoords
        
        autoMove(currentPos, targetPos)
        
        @selectionManager.isCurrentSet = false
        @selectionManager.isTargetSet = false
        @selectionManager.inMovingMode = false
        @selectionManager.hitText.value = ""
    end

    def autoMove(start, target)
        path = PathFind.findBestPath( start, target, @field.getFieldArray )
			
        currentPos = nil
        path.each do |point|
            if currentPos === nil
                currentPos = point
            else
                targetPos = point
                
                nearbyShooter = @field.overwatch.findNearby(currentPos)
                if nearbyShooter != nil
                    @field.overwatch.remove(nearbyShooter)
                    shootTarget(nearbyShooter, currentPos, 1)
                end
                @field.swapPosition(currentPos, targetPos)

                currentPos = targetPos
                sleep(0.2) #0.3 is optimal for normal play
                Tk.update
            end
        end
    end

    def shootTarget(shooterPos, targetPos, targetMod)
        @field.setAmmo(shooterPos, -1)
        chanceToHit = GraphMath.calcHitChance(shooterPos[0], shooterPos[1], targetPos[0], targetPos[1], targetMod)
        @selectionManager.hitText.value = "#{chanceToHit}% chance"
        
        if GraphMath.hitDeterminer(chanceToHit) && @field.getTile(targetPos).health-15 >= 0
            @field.setHealth(targetPos, -15)
            @field.flashImage(targetPos, Constants::EXPLO_IMAGE)
            @field.deathCheck(targetPos)
        end
        
        @selectionManager.isCurrentSet = false
        @selectionManager.isTargetSet = false
        @selectionManager.inShootingMode = false
        @field.setCoverMod(targetPos, 1)
    end

end