require_relative 'Colliders'
require_relative 'GameObject'

class Clickable < GameObject
	def initialize (name, parent, rel_x, rel_y, width, height)
		super name, parent, rel_x, rel_y, width, height
		@collider = BoxCollider.new("collider", self, 0, 0, width, height)
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
			call
		end
		#pressed set before mouse_down update for initial click check
		@pressed = pressed?
		@mouse_down = $game.button_down?(Gosu::MsLeft)
	end
end