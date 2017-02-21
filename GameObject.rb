require_relative "Container"

class GameObject < Container
	def initialize (name, parent, rel_x=0, rel_y=0, width=0, height=0)
		@rel_x = rel_x
		@rel_y = rel_y
		@parent = parent
		puts @parent
		@x = @parent.x + rel_x
		@y = @parent.y + rel_y
		super name, @x, @y
		@width = width
		@height = height
		@parent.add_child(self)
	end

	def update
		puts "Parent: #{@parent.x}"
		@x = @parent.x + @rel_x
		@y = @parent.y + @rel_y

		@children.each {|key, gameObject| gameObject.update}
	end

	def draw
		@gameObjects.each {|key, gameObject| gameObject.draw}
	end

	def center
		{:x => @x+(@width.to_f/2), :y => @y+(@height.to_f/2)}
	end
end