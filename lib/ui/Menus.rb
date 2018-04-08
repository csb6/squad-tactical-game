require 'tk'
require_relative '../Constants'
#File defining the various side panels/menus
def drawUI(selectionManager)
			topMenu = TkFrame.new(Constants::ROOT) { grid('row' => 0, 'column' => 0) }
			      
			            TkButton.new(topMenu) do
			              text "Exit"
			              command do
			              	selectionManager.rootExists = false
			              	root.destroy
			              end
			              grid('row' => 0, 'column' => 0)
			            end
			            
			            TkButton.new(topMenu) do
			            		text "Load Game"
			            		
			            		command do
			            			loadFile = Tk::getOpenFile
			            		end
			            		grid('row' => 0, 'column' => 2)
			            end
			            
			            TkButton.new(topMenu) do
			            		text "Save Game"
			            		
										command do
											saveFile = Tk::getSaveFile
										end
										grid('row' => 0, 'column' => 1)
								 end
								 
			sideMenu = TkFrame.new(Constants::ROOT) do
				padx Constants::SIDEBAR_PADX
				pady Constants::SIDEBAR_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 1, 'sticky' => 'w')
			end
			
								nameLabel = Tk::Tile::Label.new(sideMenu) do #Shows objectName of currently selected object
									textvariable selectionManager.labelText
									grid('row' => 0, 'column' => 0)
								end
								
								attackButton = Tk::Tile::Button.new(sideMenu) do
									text "Attack"
									command do
										selectionManager.inShootingMode = true
									end
									grid('row' => 1, 'column' => 0)
								end
								
								takeCoverButton = Tk::Tile::Button.new(sideMenu) do
									text "Take Cover"
									grid('row' => 2, 'column' => 0)
								end
								
								deselectButton = Tk::Tile::Button.new(sideMenu) do
									text "Deselect Unit"
									command do
										if selectionManager.inMovingMode #Tells manager to stop looking for tile to move to
											selectionManager.inMovingMode = false
											selectionManager.inShootingMode = false
										end
									end
									grid('row' => 3, 'column' => 0)
								end
		
end