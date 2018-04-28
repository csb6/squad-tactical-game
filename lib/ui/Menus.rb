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
			            		text "Save Game"
										command do
											saveFile = Tk::getSaveFile
										end
										grid('row' => 0, 'column' => 1)
									 end
			            
			            TkButton.new(topMenu) do
		            		text "Load Game"
		            		command do
		            			loadFile = Tk::getOpenFile
		            		end
		            		grid('row' => 0, 'column' => 2)
			            end
								 
								 TkLabel.new(topMenu) do
							 		textvariable selectionManager.turnLabel
							 		grid('row' => 0, 'column' => 3)
								 end
								 
			sideMenu = TkFrame.new(Constants::ROOT) do
				padx Constants::SIDEBAR_PADX
				pady Constants::SIDEBAR_PADY
				background Constants::BACKGROUND
				grid('row' => 1, 'column' => 1, 'sticky' => 'w')
			end
								
								labelPanel = TkFrame.new(sideMenu) do
									pady 5
									background Constants::BACKGROUND
									grid('row' => 0, 'column' => 0)
								end
			
											nameLabel = Tk::Tile::Label.new(labelPanel) do #Shows objectName of currently selected object
												font "TkDefaultFont 14 bold"
												textvariable selectionManager.nameLabel
												grid('row' => 0, 'column' => 0)
											end
											
											healthLabel = Tk::Tile::Label.new(labelPanel)do
												textvariable selectionManager.healthLabel
												grid('row' => 1, 'column' => 0)
											end
											
											ammoLabel = Tk::Tile::Label.new(labelPanel) do
												textvariable selectionManager.ammoLabel
												grid('row' => 2, 'column' => 0)
											end
											
											coverLabel = Tk::Tile::Label.new(labelPanel) do
												textvariable selectionManager.coverLabel
												grid('row' => 3, 'column' => 0)
											end
												
											
											hitLabel = Tk::Tile::Label.new(labelPanel) do
												textvariable selectionManager.hitText
												grid('row' => 4, 'column' => 0)
											end
											
								actionPanel = TkFrame.new(sideMenu) do
									pady 5
									background Constants::BACKGROUND
									grid('row' => 1, 'column' => 0)
								end
								
											attackButton = Tk::Tile::Button.new(actionPanel) do
												text "Attack"
												command do
													if selectionManager.isCurrentSet && selectionManager.currentTraits.isBlueTeam === selectionManager.isBlueTurn
														selectionManager.inShootingMode = true
													end
												end
												grid('row' => 0, 'column' => 0)
											end
											
											takeCoverButton = Tk::Tile::Button.new(actionPanel) do
												text "Take Cover"
												command do
														if selectionManager.isCurrentSet && selectionManager.currentTraits.canShoot
															selectionManager.inTakeCoverMode = true
														end
												end
												grid('row' => 1, 'column' => 0)
											end
											
											equipButton = Tk::Tile::Button.new(actionPanel) do
												text "Unit Inventory"
												command do
													if selectionManager.isCurrentSet && selectionManager.currentTraits.canShoot
														selectionManager.currentTraits.openPanel
														selectionManager.resetAll
													end
												end
												grid('row' => 2, 'column' => 0)
											end
											
											deselectButton = Tk::Tile::Button.new(actionPanel) do
												text "Deselect Unit"
												command do
													selectionManager.resetAll
												end
												grid('row' => 3, 'column' => 0)
											end
											
								
						endTurnButton = Tk::Tile::Button.new(sideMenu) do
							text "End Turn"
							command do
								selectionManager.resetCover = true
							end
							grid('row' => 3, 'column' => 0)
						end
end