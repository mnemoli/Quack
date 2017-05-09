require_relative "ItemList"

class Inventory < ItemList

  def to_s
    if items.empty?
      "You have:\nNothing"
    else
      "You have:\n#{super}"
    end
  end

end