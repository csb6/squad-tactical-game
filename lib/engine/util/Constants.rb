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
	WD_PATH = File.join(Dir.getwd, "lib")
	LEVEL_PATH = File.join(WD_PATH, "levels")
	CHARS_PATH = File.join(WD_PATH, "characters")
	SPRITE_PATH = File.join(WD_PATH, "ui", "sprites")

	START_LEVEL_PATH = File.join(LEVEL_PATH, "island0.csv")
	RED_CHAR_PATH = File.join(CHARS_PATH, "red-soldiers.csv")
	BLUE_CHAR_PATH = File.join(CHARS_PATH, "blue-soldiers.csv")
	
	SAND_IMAGE_PATH = File.join(SPRITE_PATH, "sand2.gif")
	SAND_IMAGE = TkPhotoImage.new(:file => SAND_IMAGE_PATH)
	
	B_SOLDIER_IMAGE_PATH = File.join(SPRITE_PATH, "blue-soldier2.gif")
	B_SOLDIER_IMAGE = TkPhotoImage.new(:file => B_SOLDIER_IMAGE_PATH)
	
	R_SOLDIER_IMAGE_PATH = File.join(SPRITE_PATH, "red-soldier2.gif")
	R_SOLDIER_IMAGE = TkPhotoImage.new(:file => R_SOLDIER_IMAGE_PATH)

	DEAD_SOLDIER_IMAGE_PATH = File.join(SPRITE_PATH, "dead-soldier.gif")
	DEAD_SOLDIER_IMAGE = TkPhotoImage.new(:file => DEAD_SOLDIER_IMAGE_PATH)
	
	WALL_IMAGE_PATH = File.join(SPRITE_PATH, "wall2.gif")
	WALL_IMAGE = TkPhotoImage.new(:file => WALL_IMAGE_PATH)
	
	EXPLO_IMAGE_PATH = File.join(SPRITE_PATH, "explosion.gif")
	EXPLO_IMAGE = TkPhotoImage.new(:file => EXPLO_IMAGE_PATH)
end