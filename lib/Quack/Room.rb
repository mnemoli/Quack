require_relative "ItemList"

class Room
  attr_reader :description, :items
  attr_accessor :directions

  def initialize (description, items, directions)
    @description = description
    @items = ItemList.new(items)
    @directions = directions
  end

  def describe
    puts description
    unless items.empty?
      puts "You see:"
      puts items
    end
  end

  def move (direction)
    if directions[direction.to_sym]
      directions[direction.to_sym]
    else
      puts "Can't move there."
      return self
    end
  end

  def take_item(item_name)
    the_item = items.find(item_name)
    if the_item
      the_item.pick_up(items)
    else
      puts "I don't see that here."
    end
  end

  def find(item_name)
    items.find(item_name)
  end

end