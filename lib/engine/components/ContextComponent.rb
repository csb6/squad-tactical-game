class ContextComponent

    def initialize(tile, rootWin, selectManager)
        @tile = tile
        @rootWin = rootWin
        @selectManager = selectManager
    end

    def openContextMenu

        #Configured for 28x29 field
        if (@tile.xPos >= 24 && @tile.yPos >= 2) || (@tile.yPos >= 27 && @tile.xPos >= 4) #Upper left position /
            a = -100; c = -63; e = -7; g = -25
            b = -50; d = -40; f = -7
        elsif @tile.xPos < 4 && @tile.yPos >= 27 #Upper right position /
            a = 100; c = 38; e = 7; g = -25
            b = -50; d = -40; f = -7
        elsif @tile.xPos >= 24 && @tile.yPos < 2 #Bottom left position /
            a = -100; c = -63; e = -7; g = 35
            b = 50; d = 20; f = 7
        else #Bottom right position /
            a = 100; c = 38; e = 7; g = 35
            b = 50; d = 20; f = 7
        end

        currentRow = @selectManager.currentTile.yPos
        currentCol = @selectManager.currentTile.xPos
        hitChance = GraphMath.calcHitChance(currentCol, currentRow, @tile.xPos, @tile.yPos, @tile.coverMod) #Calc chance of current selected object to hit self

        @contextMenu = TkcRectangle.new(@rootWin, @tile.x1, @tile.y1, @tile.x1+a, @tile.y1+b, :fill => 'grey')
            @hitText = TkcText.new(@rootWin, @tile.x1+c, @tile.y1+d, :text => "HC: #{hitChance}%")
            @attackButton = TkcText.new(@rootWin, @tile.x1+c, @tile.y1+g, :text => "Attack")
            @exitButton = TkcText.new(@rootWin, @tile.x1+e, @tile.y1+f, :text => "X")

            @attackButton.bind("1", proc {
                if @selectManager.isCurrentSet && @selectManager.currentTile.isBlueTeam === @selectManager.isBlueTurn
                    @selectManager.inShootingMode = true
                    @tile.setTarget
                    closeContextMenu
                end
            })
            @exitButton.bind("1", proc {
                closeContextMenu
            })
    end

    def closeContextMenu
        @contextMenu.delete
        @attackButton.delete
        @exitButton.delete
        @hitText.delete
    end
end