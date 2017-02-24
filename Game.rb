require 'gosu'
require_relative 'Button'

#shows green outline of colliders
ShowColliders = false
Width = 1920
Height = 1080
Ratio = {
	:x => 16,
	:y => 9
}

class Window < Gosu::Window
	def initialize
		super Width, Height
		self.caption = "Fantasy Land"
		load
	end

	def needs_cursor?
		true
	end

	def load
		@containers = {}
		@containers["Turn UI"] = Container.new("Turn UI", 0, 3*Height.to_f/4)
		@gameObjects = {}

		@gameObjects["test"] = Button.new("Test", @containers["Turn UI"], 20, 20, 200, 100, "default", "Close", Proc.new{ $game.close })
		# To Replace with loadable level files
		# @gameObjects[:exit] = Button.new("Close", 120, 20, 100, 100, "default", "Close", $parent, Proc.new{ $game.close })
	end

	def update
		@gameObjects.each {|key, gameObject| gameObject.update}
	end

	def draw
		@gameObjects.each {|key, gameObject| gameObject.draw}
	end
end

$game = Window.new
$game.show