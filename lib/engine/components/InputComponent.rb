class InputComponent

    def initialize(tile, selectManager)
        @tile = tile
        @selectManager = selectManager
    end

    def setCurrent
        
    end

    def setTarget
        
    end
end

    class SoldierInputComponent < InputComponent

        def initialize(tile, selectManager)
            super
            @tile.image.bind("1", proc {
                if @selectManager.isBlueTurn
                    @tile.updateLabels

                    if !@selectManager.isCurrentSet
                        setCurrent
                    elsif !@selectManager.isTargetSet && @selectManager.inShootingMode #If looking for a shooting target, make it a target
                        setTarget
                    end
                end
            })
        end

        def setCurrent
            @selectManager.currentTile = @tile
            @selectManager.isCurrentSet = true
        end

        def setTarget #tile to be this tile if it's the turn of the tile's team
            @selectManager.targetTile = @tile
            @selectManager.isTargetSet = true
        end
        
    end

    class BasicInputComponent < InputComponent
        def initialize(tile, selectManager)
            super
            @tile.image.bind("1", proc {
                if @selectManager.isBlueTurn
                    @tile.updateLabels

                    if !@selectManager.isTargetSet && @selectManager.isCurrentSet && !@selectManager.inShootingMode
                        setTarget
                    end
                end
            })
        end

        def setTarget
            distanceToCurrent = GraphMath.distanceFormula(@selectManager.currentTile.xPos, @selectManager.currentTile.yPos, @tile.xPos, @tile.yPos)
			if @tile.isOccupiable &&  distanceToCurrent <= 5
				@selectManager.targetTile = @tile
				@selectManager.isTargetSet = true
				@selectManager.inMovingMode = true
			end
        end
    end