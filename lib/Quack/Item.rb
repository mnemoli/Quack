class Item
  attr_reader :name, :description, :pick_up_proc, :can_be_picked_up, :identifier

  def initialize (identifier, name, description, can_be_picked_up = true)
    @name = name
    @description = description
    @can_be_picked_up = can_be_picked_up
    @identifier = identifier
  end

  def pick_up(container)
    if can_be_picked_up == true
      puts "You picked up the #{name}"
      container.delete(self)
      self
    else
      puts "You can't pick up the #{name}"
    end
  end

  def ==(other)
    case other
    when String
      name.casecmp(other).zero?
    when Item
      name.casecmp(other.name).zero?
    else
      this == other
    end
  end

  def to_s
    name
  end
end