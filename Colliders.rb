require_relative "GameObject"

class BoxCollider < GameObject
	def initialize (name, parent, rel_x, rel_y, width, height)
		super name, parent, rel_x, rel_y, width, height 
		if ShowColliders
			@images = {
				:mouse_out => Gosu::Image.new("media/colliders/SquareCollider.png"),
				:mouse_in => Gosu::Image.new("media/colliders/SquareColliderSelected.png")
			}
			@scale_x = @width.to_f/@images[:mouse_out].width
			@scale_y = @height.to_f/@images[:mouse_out].height
		end
	end

	def point_touching? (x, y)
		x.between?(@x, @x+@width) && y.between?(@y, @y+@height)
	end

	def box_touching?
	end

	def circle_touching?
	end

	def update
		super
		if ShowColliders
			@selected_image = point_touching?($game.mouse_x, $game.mouse_y)? @images[:mouse_in] : @images[:mouse_out]
		end
	end

	def draw
		if ShowColliders
			@selected_image.draw(@parent.x + @rel_x,@parent.y + @rel_y,99, @scale_x, @scale_y)
		end
	end
end

class CircleCollider < GameObject
	def initialize (rel_x, rel_y, radius, parentradius)
		super 
		@radius = radius
		
		if ShowColliders
			@images = {
				:mouse_out => Gosu::Image.new("media/colliders/CircleCollider.png"),
				:mouse_in => Gosu::Image.new("media/colliders/CircleColliderSelected.png")
			}
			@scale = (@radius*2).to_f/@images[:mouse_out].width
		end
	end

	def point_touching? (x, y)
		Gosu.distance($parent.center[:x], $parent.center[:y], x, y) <= @radius
	end
	
	def box_touching?
		
	end

	def circle_touching?
		
	end

	def update
		@x = @parent.x + @rel_x
		@y = @parent.y + @rel_y

		if ShowColliders
			selected_image = point_touching?($game.mouse_x, $game.mouse_y)? @images[:mouse_in] : @images[:mouse_out]
		end
	end

	def draw
		if ShowColliders
			selected_image.draw(@abs_x,@abs_y,99, @scale, @scale)
		end
	end
end