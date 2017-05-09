class ItemList
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def find(item_name)
    items.find { |item| item == item_name}
  end

  def delete(item)
    items.delete(item)
  end

  def <<(item)
    items << item
  end

  def to_s
    items.join("\n")
  end

  def empty?
    items.empty?
  end
end