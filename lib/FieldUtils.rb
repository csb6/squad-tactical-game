require_relative 'PathFind'

module FieldUtils

    def FieldUtils.applyCoverMod(selectionManager, fieldArray)
        currentRow = selectionManager.currentTraits.yPos
        currentCol = selectionManager.currentTraits.xPos
        
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
        targetPos = [ selectionManager.targetTraits.xPos, selectionManager.targetTraits.yPos ]
        currentPos = [ selectionManager.currentTraits.xPos, selectionManager.currentTraits.yPos ]
        
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
                currentPos = [ fieldArray[ point[1] ][ point[0] ].xPos, fieldArray[ point[1] ][ point[0] ].yPos ]
                currentPx = [ fieldArray[ point[1] ][ point[0] ].x1, fieldArray[ point[1] ][ point[0] ].y1 ]
            else
                targetPos = [ fieldArray[ point[1] ][ point[0] ].xPos, fieldArray[ point[1] ][ point[0] ].yPos ]
                targetPx = [ fieldArray[ point[1] ][ point[0] ].x1, fieldArray[ point[1] ][ point[0] ].y1 ]
                
                fieldArray = FieldUtils.move( currentPos, targetPos, currentPx, targetPx, fieldArray )
                currentPos = targetPos
                currentPx = targetPx
                temp = nil
                Tk.update
                sleep(0.3)
            end
        end
        return fieldArray
    end

    def FieldUtils.shootTarget(fieldArray, selectionManager)
        targetRow = selectionManager.targetTraits.yPos
        targetCol = selectionManager.targetTraits.xPos
        currentRow = selectionManager.currentTraits.yPos
        currentCol = selectionManager.currentTraits.xPos
        coverModifier = selectionManager.targetTraits.coverMod
        
        fieldArray[currentRow][currentCol].ammo = selectionManager.currentTraits.ammo - 1
        chanceToHit = GraphMath.calcHitChance(currentCol, currentRow, targetCol, targetRow, coverModifier)
        selectionManager.hitText.value = "#{chanceToHit}% chance"
        
        if GraphMath.hitDeterminer(chanceToHit)
            fieldArray[targetRow][targetCol].health = selectionManager.targetTraits.health - 15
            fieldArray[targetRow][targetCol].flashImage(Constants::EXPLO_IMAGE)
        end
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inShootingMode = false
        selectionManager.currentTraits.coverMod = 1
        return fieldArray
    end

end