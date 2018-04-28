require_relative 'engine/classes/SelectionManager'

module Constants
	
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
	MAC_PATH = "/users/kevinblakley/eclipse-workspace/project-1/lib/"
	WIN_PATH = "\\users\\moose\\git\\project-1\\lib\\"
	LEVEL_PATH_MAC = "levels/"
	LEVEL_PATH_WIN = "levels\\"
	CHARS_PATH_MAC = "characters/"
	CHARS_PATH_WIN = "characters\\"
	SPRITE_PATH_MAC = "ui/sprites/"
	SPRITE_PATH_WIN = "ui\\sprites\\"
	if RUBY_PLATFORM =~ /darwin/ #Determine platform, change paths based on it
		PATH = MAC_PATH
		LEVELS_PATH = LEVEL_PATH_MAC
		SPRITE_PATH = SPRITE_PATH_MAC
		CHARS_PATH = CHARS_PATH_MAC
	else
		PATH = WIN_PATH
		LEVELS_PATH = LEVEL_PATH_WIN
		SPRITE_PATH = SPRITE_PATH_WIN
		CHARS_PATH = CHARS_PATH_WIN
	end
			LEVEL_PATH = PATH + LEVELS_PATH + "island0.csv"
			RED_CHAR_PATH = PATH + CHARS_PATH + "red-soldiers.csv"
			BLUE_CHAR_PATH = PATH + CHARS_PATH + "blue-soldiers.csv"
			
			SAND_IMAGE_PATH = PATH + SPRITE_PATH + "sand.png"
			SAND_IMAGE = TkPhotoImage.new(:file => SAND_IMAGE_PATH)
			
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
			
			EXPLO_IMAGE_PATH = PATH + SPRITE_PATH + "explosion.png"
			EXPLO_IMAGE = TkPhotoImage.new(:file => EXPLO_IMAGE_PATH)
end