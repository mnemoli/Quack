require "test/unit"
require_relative "../lib/Quack/Room"
require_relative "../lib/Quack/Item"
require_relative "../lib/Quack/Character"

class TestGame < Test::Unit::TestCase

  def test_room
    room_description = "This is a new room."
    room_objects = []
    room_directions = {}
    room = Room.new(room_description, room_objects, room_directions)

    assert_equal(room.description, room_description)
    assert_equal(room.items.items, room_objects)
    assert_equal(room.directions, room_directions)
  end

  def test_object
    object_name = "Duck"
    object_desc = "Rubber duck"
    object_ident = :duck
    room_object = Item.new(object_ident, object_name, object_desc)

    assert_equal(room_object.name, object_name)
    assert_equal(room_object.description, object_desc)
  end

  def test_character
    room = create_empty_room
    inv_items = [make_duck_item]
    me = Character.new(room, inv_items)

    assert_equal(me.inventory.items, inv_items)
    assert_equal(me.current_room, room)
  end

  def test_room_move
    room_one = create_empty_room("Room 1")
    room_two = create_empty_room("Room 2")

    room_one.directions = {north: room_two}
    room_two.directions = {south: room_one}

    assert_equal(room_one.move("north"), room_two)
    assert_equal(room_two.move("south"), room_one)
    assert_equal(room_one.move("up"), room_one)
  end

  def test_pick_up
    room_object = make_duck_item
    room = Room.new("Room 1", [room_object], {})
    me = Character.new(room, [room_object])

    item = me.pick_up_item("duck")

    assert_equal(room_object, item)
    assert(room.items.empty?)
    assert(!me.inventory.empty?)
  end

  def create_empty_room(room_name = "Room 1")
    Room.new(room_name, [], {})
  end

  def make_duck_item
    Item.new(:duck, "Duck", "Rubber duck")
  end

end