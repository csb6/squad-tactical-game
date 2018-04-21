require_relative '../Constants'
require_relative '../GraphMath'

#Updates appearance of gameField as pieces are selected, move around, or perform actions on each other


def updateField(fieldArray, selectionManager)

		if selectionManager.inMovingMode
			targetRow = selectionManager.targetTraits.yPos
			targetCol = selectionManager.targetTraits.xPos
			currentRow = selectionManager.currentTraits.yPos
			currentCol = selectionManager.currentTraits.xPos
			
			fieldArray[currentRow][currentCol].setTraits(selectionManager.targetTraits)
			fieldArray[targetRow][targetCol].setTraits(selectionManager.currentTraits)
			selectionManager.isCurrentSet = false
			selectionManager.isTargetSet = false
			selectionManager.inMovingMode = false
			selectionManager.hitText.value = ""
			targetRow, targetCol, currentRow, currentCol = nil
			
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