require_relative '../Constants'
require_relative '../GraphMath'

#Updates appearance of gameField as pieces are selected, move around, or perform actions on each other


def updateField(fieldArray, selectionManager)

		if selectionManager.inMovingMode
			targetRow = selectionManager.targetTraits.yPos
			targetCol = selectionManager.targetTraits.xPos
			targetXPx = selectionManager.targetTraits.x1
			targetYPx = selectionManager.targetTraits.y1
			
			currentRow = selectionManager.currentTraits.yPos
			currentCol = selectionManager.currentTraits.xPos
			currentXPx = selectionManager.currentTraits.x1
			currentYPx = selectionManager.currentTraits.y1
			
			fieldArray[currentRow][currentCol].setPosition(targetCol, targetRow, targetXPx, targetYPx)
			fieldArray[targetRow][targetCol].setPosition(currentCol, currentRow, currentXPx, currentYPx)
			temp = fieldArray[currentRow][currentCol]
			fieldArray[currentRow][currentCol] = fieldArray[targetRow][targetCol]
			fieldArray[targetRow][targetCol] = temp
			
			selectionManager.isCurrentSet = false
			selectionManager.isTargetSet = false
			selectionManager.inMovingMode = false
			selectionManager.hitText.value = ""
			targetRow, targetCol, targetXPx, targetYPx, currentRow, currentCol, currentXPx, currentYPx = nil
			
		elsif selectionManager.inShootingMode && selectionManager.isTargetSet
			targetRow = selectionManager.targetTraits.yPos
			targetCol = selectionManager.targetTraits.xPos
			currentRow = selectionManager.currentTraits.yPos
			currentCol = selectionManager.currentTraits.xPos
			coverModifier = selectionManager.currentTraits.coverMod
			
			fieldArray[currentRow][currentCol].setAmmo(selectionManager.currentTraits.ammo - 1)
			chanceToHit = GraphMath.calcHitChance(currentCol, currentRow, targetCol, targetRow, coverModifier, fieldArray)
			selectionManager.hitText.value = "#{chanceToHit}% chance"
			
			if GraphMath.hitDeterminer(chanceToHit)
				fieldArray[targetRow][targetCol].setHealth(selectionManager.targetTraits.health - 15)
				fieldArray[targetRow][targetCol].flashImage(Constants::EXPLO_IMAGE)
			end
			
			selectionManager.isCurrentSet = false
			selectionManager.isTargetSet = false
			selectionManager.inShootingMode = false
			selectionManager.currentTraits.coverMod = 1
			targetRow, targetCol, currentRow, currentCol, coverModifier, chanceToHit = nil
		end
		return fieldArray
end