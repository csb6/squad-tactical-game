require_relative 'PathFind'

module FieldUtils

    def FieldUtils.applyCoverMod(selectionManager, field)
        currentPos = selectionManager.currentTile.getCoords
        
        field.setCoverMod(currentPos, 0.8)
        
        selectionManager.coverLabel.value = "Cover: #{field.getTile(currentPos).coverMod}"
        selectionManager.isCurrentSet = false
        selectionManager.inTakeCoverMode = false
        currentRow, currentCol = nil
        return field
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
        return field
    end

    def FieldUtils.manualMove(field, selectionManager)
        targetPos = selectionManager.targetTile.getCoords
        currentPos = selectionManager.currentTile.getCoords
        
        field = FieldUtils.autoMove(currentPos, targetPos, field)
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inMovingMode = false
        selectionManager.hitText.value = ""
        return field
    end

    def FieldUtils.autoMove(start, target, field)
        path = PathFind.findBestPath( start, target, field )
			
        currentPos = nil
        path.each do |point|
            if currentPos === nil
                currentPos = point
            else
                targetPos = point
                
                field.swapPosition(currentPos, targetPos)

                currentPos = targetPos
                sleep(0.2) #0.3 is optimal for normal play
                Tk.update
            end
        end
        return field
    end

    def FieldUtils.shootTarget(field, selectionManager)
        targetRow = selectionManager.targetTile.yPos
        targetCol = selectionManager.targetTile.xPos
        currentRow = selectionManager.currentTile.yPos
        currentCol = selectionManager.currentTile.xPos
        coverModifier = selectionManager.targetTile.coverMod
        
        field.setAmmo([currentCol, currentRow], -1)
        chanceToHit = GraphMath.calcHitChance(currentCol, currentRow, targetCol, targetRow, coverModifier)
        selectionManager.hitText.value = "#{chanceToHit}% chance"
        
        if GraphMath.hitDeterminer(chanceToHit)
            field.setHealth([targetCol, targetRow], -15)
            field.flashImage([targetCol, targetRow], Constants::EXPLO_IMAGE)
        end
        
        selectionManager.isCurrentSet = false
        selectionManager.isTargetSet = false
        selectionManager.inShootingMode = false
        selectionManager.currentTile.coverMod = 1
        return field
    end

    # def FieldUtils.findOWSoldiers(isBlueTeam, field) #find soldiers in overwatch mode
    #     owSoldiers = [ ]
    #     y = 0
    #     field.each do |row|
    #         x = 0
    #         row.each do |tile|
    #             if tile.canShoot
    #                 if tile.inOverwatch && tile.isBlueTeam != isBlueTeam
    #                     owSoldiers << field[y][x]
    #                 end
    #             end
    #             x += 1
    #         end
    #         y += 1
    #     end
    #     return owSoldiers
    # end

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