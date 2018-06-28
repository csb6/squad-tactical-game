require_relative 'PathFind'

module FieldUtils

    def FieldUtils.applyCoverMod(selectionManager, field)
        currentPos = selectionManager.currentTile.getCoords
        
        field.setCoverMod(currentPos, 0.8)
        
        selectionManager.coverLabel.value = "Cover: #{field.getTile(currentPos).coverMod}"
        selectionManager.isCurrentSet = false
        selectionManager.inTakeCoverMode = false
        currentRow, currentCol = nil
    end

    def FieldUtils.clearCoverMods(selectionManager, field)
        selectionManager.isBlueTurn = !selectionManager.isBlueTurn
        selectionManager.resetAll
        selectionManager.resetCover = false
        
        if selectionManager.isBlueTurn
            selectionManager.turnLabel.value = "Blue Turn"
        else
            selectionManager.turnLabel.value = "Red Turn "
        end
        
        field.clearCoverMods
    end

    def FieldUtils.manualMove(field, selectionManager)
        targetPos = selectionManager.targetTile.getCoords
        currentPos = selectionManager.currentTile.getCoords
        
        FieldUtils.autoMove(currentPos, targetPos, field, selectionManager)
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inMovingMode = false
        selectionManager.hitText.value = ""
    end

    def FieldUtils.autoMove(start, target, field, selectionManager)
        path = PathFind.findBestPath( start, target, field.getFieldArray )
			
        currentPos = nil
        path.each do |point|
            if currentPos === nil
                currentPos = point
            else
                targetPos = point
                
                nearbyShooter = FieldUtils.findNearbyOW(currentPos, field.overwatch.soldiers)
                if nearbyShooter != nil
                    field.overwatch.remove(nearbyShooter)
                    FieldUtils.shootTarget(nearbyShooter, currentPos, 1, field, selectionManager)
                end
                field.swapPosition(currentPos, targetPos)

                currentPos = targetPos
                sleep(0.2) #0.3 is optimal for normal play
                Tk.update
            end
        end
    end

    def FieldUtils.shootTarget(shooterPos, targetPos, targetMod, field, selectionManager)
        field.setAmmo(shooterPos, -1)
        chanceToHit = GraphMath.calcHitChance(shooterPos[0], shooterPos[1], targetPos[0], targetPos[1], targetMod)
        selectionManager.hitText.value = "#{chanceToHit}% chance"
        
        if GraphMath.hitDeterminer(chanceToHit)
            field.setHealth(targetPos, -15)
            field.flashImage(targetPos, Constants::EXPLO_IMAGE)
            field.deathCheck(targetPos)
        end
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inShootingMode = false
        field.setCoverMod(targetPos, 1)
    end

    def FieldUtils.findNearbyOW(pos, owArray)
        owArray.each do |owTile|
            distance = GraphMath.distanceFormula(pos[0], pos[1], owTile.xPos, owTile.yPos)
            if distance <= 5
                return owTile.getCoords
            end
        end
        return nil
    end
end