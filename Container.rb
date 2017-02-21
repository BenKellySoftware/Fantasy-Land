class Container
	attr_reader :x, :y, :name
	def initialize (name, x=0, y=0)
		@name = name
		@x = x
		@y = y
		@children = {}
	end

	def add_child (object)
		@children[object.name] = object
	end

end