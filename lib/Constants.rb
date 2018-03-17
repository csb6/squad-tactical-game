module Constants
	
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
			
	Tk::Tile::Style.configure('InteractObj.TButton', {
		"font" => "helvetica 12",
		"width" => 1})
						
					Tk::Tile::Style.configure('Sand.InteractObj.TButton', {
						#"image" => Constants::SAND_IMAGE
						"text" => "**",
						"foreground" => "tan"})
										
					Tk::Tile::Style.configure('Cannon.InteractObj.TButton', {
						"background" => "green",
						"foreground" => "green",
						"image" => CANNON_IMAGE})
									
					Tk::Tile::Style.configure('Terminal.InteractObj.TButton', {
						"background" => "grey",
						"foreground" => "grey",
						"image" => TERM_IMAGE})
									
					Tk::Tile::Style.configure('Soldier.InteractObj.TButton', {
						"image" => SOLDIER_IMAGE,
						"background" => "tan1", 
						"foreground" => "tan1"})
			
						
	Tk::Tile::Style.configure('StatObj.TLabel', {
		"font" => "helvetica 17", 
		"width" => 4, 
		"justify" => "right"})
		
					Tk::Tile::Style.configure('Wall.StatObj.TLabel', {
						"image" => WALL_IMAGE})
			
end