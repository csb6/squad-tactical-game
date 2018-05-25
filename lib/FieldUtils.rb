module FieldUtils
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
                if fieldArray[y][x].canShoot && fieldArray[y][x].isBlueTeam === selectionManager.isBlueTurn
                    fieldArray[y][x].coverMod = 1
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
end