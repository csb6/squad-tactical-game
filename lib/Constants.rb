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
	FIELD_PADY = 40
	FIELD_WIDTH = 27
	FIELD_HEIGHT = 32
	
	#Files
	MAC_PATH = "/users/kevinblakley/eclipse-workspace/project-1/lib/ui/"
	WIN_PATH = "\\users\\moose\\git\\project-1\\lib\\ui\\"
	LEVEL_PATH_MAC = "levels/"
	LEVEL_PATH_WIN = "levels\\"
	SPRITE_PATH_MAC = "sprites/"
	SPRITE_PATH_WIN = "sprites\\"
	if RUBY_PLATFORM =~ /darwin/ #Determine platform, change paths based on it
		PATH = MAC_PATH
		LEVELS_PATH = LEVEL_PATH_MAC
		SPRITE_PATH = SPRITE_PATH_MAC
	else
		PATH = WIN_PATH
		LEVELS_PATH = LEVEL_PATH_WIN
		SPRITE_PATH = SPRITE_PATH_WIN
	end
			LEVEL_PATH = PATH + LEVELS_PATH + "island2.csv"
			
			SAND_IMAGE_PATH = PATH + SPRITE_PATH + "sand.png"
			SAND_IMAGE = TkPhotoImage.new(:file => SAND_IMAGE_PATH)
			SAND_TEXT = "**"
			
			B_SOLDIER_IMAGE_PATH = PATH + SPRITE_PATH + "blue-soldier.png"
			B_SOLDIER_IMAGE = TkPhotoImage.new(:file => B_SOLDIER_IMAGE_PATH)
			
			R_SOLDIER_IMAGE_PATH = PATH + SPRITE_PATH + "red-soldier.png"
			R_SOLDIER_IMAGE = TkPhotoImage.new(:file => R_SOLDIER_IMAGE_PATH)
			
			CANNON_IMAGE_PATH = PATH + SPRITE_PATH + "cannon.png"
			CANNON_IMAGE = TkPhotoImage.new(:file => CANNON_IMAGE_PATH)
			
			TERM_IMAGE_PATH = PATH + SPRITE_PATH + "terminal.png"
			TERM_IMAGE = TkPhotoImage.new(:file => TERM_IMAGE_PATH)
			
			WALL_IMAGE_PATH = PATH + SPRITE_PATH + "wall.png"
			WALL_IMAGE = TkPhotoImage.new(:file => WALL_IMAGE_PATH)
end