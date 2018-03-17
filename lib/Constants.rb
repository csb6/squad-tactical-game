module Constants
	
	Tk::Tile::Style.configure("")
	Tk::Tile::Style.configure('Land.TButton', {
		"font" => "helvetica 12", 
		"background" => "tan", 
		"foreground" => "tan", 
		"width" => 1} )
	#Root Window
	TITLE = "Project 1"
	BACKGROUND = "light blue"
	#WIDTH = "1920"
	WIDTH = 1000
	HEIGHT = 900
	#HEIGHT = "1000"
	
  #Game Field
	FIELD_PADX = 80
	FIELD_PADY = 80
	MAC_PATH = "/users/kevinblakley/eclipse-workspace/project-1/lib/ui/"
	WIN_PATH = "\\users\\moose\\git\\project-1\\lib\\ui\\"
			LEVEL_PATH = MAC_PATH + "levels/island0.csv"
			#LEVEL_PATH = WIN_PATH + "levels\\island0.csv"
			
			SOLDIER_IMAGE_PATH = MAC_PATH + "soldier-smallest.png"
			#SOLDIER_IMAGE_PATH = WIN_PATH + "soldier-smallest.png"
			SOLDIER_IMAGE = TkPhotoImage.new(:file => SOLDIER_IMAGE_PATH)
			
			CANNON_IMAGE_PATH = MAC_PATH + "cannon.png"
			#CANNON_IMAGE_PATH = WIN_PATH + "cannon.png"
			CANNON_IMAGE = TkPhotoImage.new(:file => CANNON_IMAGE_PATH)
			
			TERM_IMAGE_PATH = MAC_PATH + "terminal.png"
			#TERM_IMAGE_PATH = WIN_PATH + "terminal.png"
			TERM_IMAGE = TkPhotoImage.new(:file => TERM_IMAGE_PATH)
			
			WALL_IMAGE_PATH = MAC_PATH + "wall.png"
			#WALL_IMAGE_PATH = WIN_PATH + "wall.png"
			WALL_IMAGE = TkPhotoImage.new(:file => WALL_IMAGE_PATH)
end