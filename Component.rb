class Container
	attr_reader :abs_x, :abs_y, name
	def initialize (name, abs_x=0, abs_y=0)
		@name = name
		@abs_x = abs_x
		@abs_y = abs_y
		@children = {}
	end

	def add_child (object)
		children[object]
	end
end