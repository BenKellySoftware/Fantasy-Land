require_relative 'Colliders'
require_relative 'GameObject'

class Button < GameObject
	def initialize (name, parent, rel_x, rel_y, width, height, texture, text, callback)
		super name, parent, rel_x, rel_y, width, height
		@collider = BoxCollider.new("collider", self, 0, 0, width, height)
		@callback = callback
		@font = Gosu::Font.new((height.to_f/3).to_i)
		@text = text
		@images = {
			:default => Gosu::Image.new("media/buttons/#{texture}/Default.png"),
			:hover => Gosu::Image.new("media/buttons/#{texture}/Hover.png"),
			:clicked => Gosu::Image.new("media/buttons/#{texture}/Clicked.png")
		}
		@scale_x = @width.to_f/@images[:default].width
		@scale_y = @height.to_f/@images[:default].height
	end

	def pressed?
		#Initially checks in mouse went from up to down position inside object, then checks if mouse is still down each frame
		(@pressed || (!@mouse_down  && @touching)) && $game.button_down?(Gosu::MsLeft)
	end
	
	def clicked?
		#Checks if mouse up and has been pressed, recheck if touching in case mouse left area
		!$game.button_down?(Gosu::MsLeft) && @pressed && @touching
	end

	def update
		super
		@collider.update
		@touching = @collider.point_touching?($game.mouse_x, $game.mouse_y)
		if clicked?
			@callback.call
		end

		#pressed set before mouse_down update for initial click check
		@pressed = pressed?
		@mouse_down = $game.button_down?(Gosu::MsLeft)
	end

	def draw
		@collider.draw
		if @pressed
			selected_image = @images[:clicked]
		elsif @touching && !@mouse_down
			#Only Highlight if mouse isnt already down 
			selected_image = @images[:hover]
		else
			selected_image = @images[:default]
		end
		selected_image.draw(@x,@y,98, @scale_x, @scale_y)
		@font.draw_rel(@text, center[:x], center[:y], 99, 0.5, 0.5, 1, 1, color = 0xff_ffffff, mode = :default)
		@collider.draw
	end
end