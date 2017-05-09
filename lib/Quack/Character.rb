require_relative "Inventory"
require_relative "ComboManager"

class Character
    attr_reader :inventory
    attr_accessor :current_room

  def initialize(current_room, inventory_items = [])
    @inventory = Inventory.new(inventory_items)
    @current_room = current_room
  end

  def pick_up_item(item_name)
    the_item = current_room.take_item(item_name)
    if the_item
      inventory << the_item
      the_item
    end
  end

  def use_items(item1, item2)
    #find the items first
    identifier1 = find_item_in_inv_or_room(item1)&.identifier
    identifier2 = find_item_in_inv_or_room(item2)&.identifier
    ComboManager.instance.use(identifier1, identifier2)
  end

  def find_item_in_inv_or_room(item)
    inventory.find(item) || current_room.find(item)
  end

  def deal_with_input(input)

    if input.downcase == "i"
      inventory.display
    elsif /pick up .*/.match?(input)
      item_name = get_topic(input, /pick up (.*)/)
      pick_up_item(item_name)
    elsif /go .*/.match?(input)
      direction_name = get_topic(input, /go (.*)/)
      self.current_room = current_room.move(direction_name)
    elsif /use (.*) with (.*)/.match?(input)
      item1 = get_topic(input, /use (.*) with (.*)/, 0)
      item2 = get_topic(input, /use (.*) with (.*)/, 1)
      use_items(item1, item2)
    elsif input.casecmp('quit').zero?
      exit!
    end

  end

  def get_topic(input, pattern, capture_num = 0)
    input.match(pattern).captures[capture_num]
  end

end