require_relative 'Clickable'

class Button < Clickable
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

	def call
		@callback.call
	end

	def draw
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