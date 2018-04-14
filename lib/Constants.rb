require_relative 'engine/classes/SelectionManager'

module Constants
	
	#Math Methods
	def Constants.distanceFormula(x1, y1, x2, y2)
		distance = Math.sqrt( (x2-x1)**2 + (y2-y1)**2 )
#		puts distance
		return distance.round(1)
	end
	
	#Root Window
	TITLE = "Project 1"
	BACKGROUND = "light blue"
	#WIDTH = "1920"
	ROOT_WIDTH = 1000
	ROOT_HEIGHT = 900
	#HEIGHT = "1000"
	ROOT = TkRoot.new() do
	  title Constants::TITLE
	  background Constants::BACKGROUND
	  minsize(Constants::ROOT_WIDTH, Constants::ROOT_HEIGHT)
	  resizable true, true
	end
	
	#Side Menu
	SIDEBAR_PADX = 30
	SIDEBAR_PADY = 20
	
  #Game Field
	FIELD_PADX = 40
	FIELD_PADY = 80
	FIELD_WIDTH = 27
	FIELD_HEIGHT = 32
	
	#Files
	MAC_PATH = "/users/kevinblakley/eclipse-workspace/project-1/lib/ui/"
	WIN_PATH = "\\users\\moose\\git\\project-1\\lib\\ui\\"
	LEVEL_PATH_MAC = "levels/"
	LEVEL_PATH_WIN = "levels\\"
	if RUBY_PLATFORM =~ /darwin/ #Determine platform, change paths based on it
		PATH = MAC_PATH
		LEVELS_PATH = LEVEL_PATH_MAC
	else
		PATH = WIN_PATH
		LEVELS_PATH = LEVEL_PATH_WIN
	end
			LEVEL_PATH = PATH + LEVELS_PATH + "island2.csv"
			
			SAND_IMAGE_PATH = PATH + "sand.png"
			SAND_IMAGE = TkPhotoImage.new(:file => SAND_IMAGE_PATH)
			SAND_TEXT = "**"
			
			B_SOLDIER_IMAGE_PATH = PATH + "blue-soldier-smallest.png"
			B_SOLDIER_IMAGE = TkPhotoImage.new(:file => B_SOLDIER_IMAGE_PATH)
			
			R_SOLDIER_IMAGE_PATH = PATH + "red-soldier-smallest.png"
			R_SOLDIER_IMAGE = TkPhotoImage.new(:file => R_SOLDIER_IMAGE_PATH)
			
			CANNON_IMAGE_PATH = PATH + "cannon.png"
			CANNON_IMAGE = TkPhotoImage.new(:file => CANNON_IMAGE_PATH)
			
			TERM_IMAGE_PATH = PATH + "terminal.png"
			TERM_IMAGE = TkPhotoImage.new(:file => TERM_IMAGE_PATH)
			
			WALL_IMAGE_PATH = PATH + "wall.png"
#			WALL_IMAGE_PATH = PATH + "double-small-wall.png"
			WALL_IMAGE = TkPhotoImage.new(:file => WALL_IMAGE_PATH)
	
	Tk::Tile::Style.configure('Field.TButton', {
		"font" => "helvetica 12",
		"width" => 1
	})
					
		Tk::Tile::Style.configure('InteractObj.Field.TButton')
											
						Tk::Tile::Style.configure('Cannon.InteractObj.Field.TButton', {
							"image" => CANNON_IMAGE,
							"background" => "green"})
										
						Tk::Tile::Style.configure('Terminal.InteractObj.Field.TButton', {
							"image" => TERM_IMAGE,
							"background" => "grey"})
										
						Tk::Tile::Style.configure('Soldier.InteractObj.Field.TButton', {
							"background" => "tan1"})
									
									Tk::Tile::Style.configure('Blue.Soldier.InteractObj.Field.TButton', {
										"image" => B_SOLDIER_IMAGE
									})
									
									Tk::Tile::Style.configure('Red.Soldier.InteractObj.Field.TButton', {
										"image" => R_SOLDIER_IMAGE
									})
		
		Tk::Tile::Style.configure('OccupObj.Field.TButton')
						
						Tk::Tile::Style.configure('Sand.OccupObj.Field.TButton', {
						#"text" => SAND_TEXT,
						"image" => SAND_IMAGE,
						"background" => "tan"})
							
		Tk::Tile::Style.configure('StatObj.Field.TButton', {
			"state" => "disabled"})
			
						Tk::Tile::Style.configure('Wall.StatObj.Field.TButton', {
							"image" => WALL_IMAGE,
							"background" => "grey"})
			
end