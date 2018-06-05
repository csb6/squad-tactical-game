require_relative 'PathFind'

module FieldUtils

    def FieldUtils.applyCoverMod(selectionManager, fieldArray)
        currentRow = selectionManager.currentTile.yPos
        currentCol = selectionManager.currentTile.xPos
        
        fieldArray[currentRow][currentCol].coverMod = 0.8
        
        selectionManager.coverLabel.value = "Cover: #{fieldArray[currentRow][currentCol].coverMod}"
        selectionManager.isCurrentSet = false
        selectionManager.inTakeCoverMode = false
        currentRow, currentCol = nil
        return fieldArray
    end

    def FieldUtils.clearCoverMods(selectionManager, fieldArray)
        selectionManager.isBlueTurn = !selectionManager.isBlueTurn
        selectionManager.resetAll
        selectionManager.resetCover = false
        
        if selectionManager.isBlueTurn
            selectionManager.turnLabel.value = "Blue Turn"
        else
            selectionManager.turnLabel.value = "Red Turn "
        end
        
        y = 0
        fieldArray.each do |row|
            x = 0
            row.each do
                if fieldArray[y][x].canShoot
                    if fieldArray[y][x].isBlueTeam === selectionManager.isBlueTurn
                        fieldArray[y][x].coverMod = 1
                    end
                end
                x += 1
            end
            y += 1
        end
    end

    def FieldUtils.move(currentPos, targetPos, currentPx, targetPx, fieldArray) #Moves a GameObject from current position to target position by swapping the tiles at those locations
        fieldArray[ currentPos[1] ][ currentPos[0] ].setPosition(targetPos, targetPx)
        fieldArray[ targetPos[1] ][ targetPos[0] ].setPosition(currentPos, currentPx)
        temp = fieldArray[ currentPos[1] ][ currentPos[0] ]
        fieldArray[ currentPos[1] ][ currentPos[0] ] = fieldArray[ targetPos[1] ][ targetPos[0] ]
        fieldArray[ targetPos[1] ][ targetPos[0] ] = temp
        
        return fieldArray
    end

    def FieldUtils.manualMove(fieldArray, selectionManager)
        targetPos = selectionManager.targetTile.getCoords
        currentPos = selectionManager.currentTile.getCoords
        
        fieldArray = FieldUtils.autoMove(currentPos, targetPos, fieldArray)
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inMovingMode = false
        selectionManager.hitText.value = ""
        return fieldArray
    end

    def FieldUtils.autoMove(start, target, fieldArray)
        path = PathFind.findBestPath( start, target, fieldArray )
			
        currentPos, currentPx, targetPx = nil
        path.each do |point|
            if currentPos === nil
                currentPos = fieldArray[ point[1] ][ point[0] ].getCoords
                currentPx = fieldArray[ point[1] ][ point[0] ].getPxCoords
            else
                targetPos = fieldArray[ point[1] ][ point[0] ].getCoords
                targetPx = fieldArray[ point[1] ][ point[0] ].getPxCoords
                
                fieldArray = FieldUtils.move( currentPos, targetPos, currentPx, targetPx, fieldArray )

                currentPos = targetPos
                currentPx = targetPx
                sleep(0.2) #0.3 is optimal for normal play
                Tk.update
            end
        end
        return fieldArray
    end

    def FieldUtils.shootTarget(fieldArray, selectionManager)
        targetRow = selectionManager.targetTile.yPos
        targetCol = selectionManager.targetTile.xPos
        currentRow = selectionManager.currentTile.yPos
        currentCol = selectionManager.currentTile.xPos
        coverModifier = selectionManager.targetTile.coverMod
        
        fieldArray[currentRow][currentCol].ammo -= 1
        chanceToHit = GraphMath.calcHitChance(currentCol, currentRow, targetCol, targetRow, coverModifier)
        selectionManager.hitText.value = "#{chanceToHit}% chance"
        
        if GraphMath.hitDeterminer(chanceToHit)
            fieldArray[targetRow][targetCol].health -= 15
            fieldArray[targetRow][targetCol].flashImage(Constants::EXPLO_IMAGE)
        end
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inShootingMode = false
        selectionManager.currentTile.coverMod = 1
        return fieldArray
    end

    def FieldUtils.findOWSoldiers(isBlueTeam, fieldArray) #find soldiers in overwatch mode
        owSoldiers = [ ]
        y = 0
        fieldArray.each do |row|
            x = 0
            row.each do |tile|
                if tile.canShoot
                    if tile.inOverwatch && tile.isBlueTeam != isBlueTeam
                        owSoldiers << fieldArray[y][x]
                    end
                end
                x += 1
            end
            y += 1
        end
        return owSoldiers
    end

    def FieldUtils.findNearbyOW(tile, owArray)
        owArray.each do |owTile|
            distance = GraphMath.distanceFormula(tile.xPos, tile.yPos, owTile.xPos, owTile.yPos)
            if distance <= 10
                return owTile
            end
        end
        return nil
    end
end