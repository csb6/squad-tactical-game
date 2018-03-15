#!/usr/bin/env ruby
require 'tk'
require_relative './engine/classes/GameObject'
require_relative './engine/classes/InteractiveObject'

TITLE = "Project 1"
BACKGROUND = "blue"
WIDTH = "900"
HEIGHT = "900"

jim = Soldier.new("Jim",0,50,40,false)

root = TkRoot.new() do
	title TITLE
	background BACKGROUND
	minsize(WIDTH, HEIGHT)
end

			menu = TkFrame.new(root) { grid('row' => 0, 'column' => 0) }
			
						TkButton.new(menu) do
							text "Exit"
							command{root.destroy}
							grid('row' => 0, 'column' => 0)
						end
						

Tk.mainloop