class ContextComponent

    def initialize(tile, rootWin, selectManager)
        @tile = tile
        @rootWin = rootWin
        @selectManager = selectManager
    end

    def buildButton(xOffset, yOffset, txt, command)
        button = TkcText.new(@rootWin, @tile.x1+xOffset, @tile.y1+yOffset, :text => txt)
        button.bind("1", command)
        return button
    end

    def openContextMenu

        #Configured for 28x29 field
        if (@tile.xPos >= 24 && @tile.yPos >= 2) || (@tile.yPos >= 27 && @tile.xPos >= 4) #Upper left position /
            a = -100; c = -53; e = -7; g = -25
            b = -50; d = -40; f = -7; h = -12
        elsif @tile.xPos < 4 && @tile.yPos >= 27 #Upper right position
            a = 100; c = 53; e = 7; g = -25
            b = -50; d = -40; f = -7; h = -12
        elsif @tile.xPos >= 24 && @tile.yPos < 2 #Bottom left position /
            a = -100; c = -53; e = -7; g = 27
            b = 50; d = 12; f = 7; h = 40
        else #Bottom right position /
            a = 100; c = 53; e = 7; g = 27
            b = 50; d = 12; f = 7; h = 40
        end

        currentRow = @selectManager.currentTile.yPos
        currentCol = @selectManager.currentTile.xPos
        hitChance = GraphMath.calcHitChance(currentCol, currentRow, @tile.xPos, @tile.yPos, @tile.coverMod) #Calc chance of current selected object to hit self

        @contextMenu = TkcRectangle.new(@rootWin, @tile.x1, @tile.y1, @tile.x1+a, @tile.y1+b, :fill => 'grey')
        @contextElements = [ @contextMenu ]

            if @selectManager.currentTile.objectName != @tile.objectName #Viewing another unit

                @hitText = TkcText.new(@rootWin, @tile.x1+c, @tile.y1+d, :text => "HC: #{hitChance}%")
                @contextElements << @hitText

                @attackButton = buildButton(c, g, "Attack", proc {
                    if @selectManager.isCurrentSet && @selectManager.currentTile.isBlueTeam === @selectManager.isBlueTurn
                        @selectManager.inShootingMode = true
                        @tile.inputComponent.setTarget
                        closeContextMenu
                    end
                })
                @contextElements << @attackButton

            else #Viewing current selected unit

                @infoButton = buildButton(c, d, "View Info", proc {
                    @tile.panelComponent.openPanel
                    @selectManager.resetAll
                    closeContextMenu
                })
                @contextElements << @infoButton

                @overwatchButton = buildButton(c, g, "Overwatch", proc {
                    @tile.inOverwatch = true
                    @selectManager.resetAll
                    closeContextMenu
                })
                @contextElements << @overwatchButton

                @coverButton = buildButton(c, h, "Take Cover", proc {
                    @selectManager.inTakeCoverMode = true
                    closeContextMenu
                })
                @contextElements << @coverButton

            end

            @exitButton = buildButton(e, f, "X", proc {
                closeContextMenu
            })
            @contextElements << @exitButton
    end

    def closeContextMenu
        @contextElements.each do |element|
            element.delete
        end
    end
end