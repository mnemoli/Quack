require_relative 'Quack/Room'
require_relative 'Quack/Item'
require_relative 'Quack/Inventory'
require_relative 'Quack/Character'

def runGame!
  start_room = Room.new("This is the nest room.", [Item.new(:egg, "Egg", "A big egg")], {})
  duck_room = Room.new("This is the duck room.", [Item.new(:duck, "Duck",  "A big duck", false)], {south: start_room})
  start_room.directions = {north: duck_room}
	me = Character.new(start_room)

	loop do
		me.current_room.describe
		input = gets.chomp
		me.deal_with_input(input)
		puts
	end
end

runGame!

