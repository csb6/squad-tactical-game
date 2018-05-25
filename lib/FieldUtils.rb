require_relative 'PathFind'

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

    def FieldUtils.manualMove(fieldArray, selectionManager)
        targetPos = [ selectionManager.targetTraits.xPos, selectionManager.targetTraits.yPos ]
        targetPx = [ selectionManager.targetTraits.x1, selectionManager.targetTraits.y1 ]
        currentPos = [ selectionManager.currentTraits.xPos, selectionManager.currentTraits.yPos ]
        currentPx = [ selectionManager.currentTraits.x1, selectionManager.currentTraits.y1 ]
        
        fieldArray = FieldUtils.move( currentPos, targetPos, currentPx, targetPx, fieldArray )
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inMovingMode = false
        selectionManager.hitText.value = ""
        return fieldArray
    end

    def FieldUtils.autoMove(fieldArray, selectionManager)
        path = PathFind.findBestPath( [10,2], [25,27], fieldArray )
			
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
        selectionManager.resetCover = true
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