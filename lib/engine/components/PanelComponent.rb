class PanelComponent

    def initialize(tile, rootWin)
        @tile = tile
        @rootWin = rootWin
    end

    def initPanel
		@panel = TkToplevel.new(@rootWin) do
			title "Inventory"
			background "grey"
			geometry '500x200-350+250'
		end
    end
    
    def openPanel
        
    end
end

class SoldierPanelComponent < PanelComponent
    def initialize(tile, rootWin)
        super
    end

    def openPanel
        initPanel
        @panel["title"] = @tile.objectName
        description = @tile.description
        
        @descriptionLabel = TkLabel.new(@panel) do
            text "Description:\n#{description}"
            wraplength 350
            grid('row' => 0, 'column' => 0)
        end
        
        weapon = @weapon
        @weaponLabel = TkLabel.new(@panel) do
            text "Weapon:\n#{weapon}"
            grid('row' => 1, 'column' => 0)
        end
    end
end