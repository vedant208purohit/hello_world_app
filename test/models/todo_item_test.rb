require "test_helper"

class TodoItemTest < ActiveSupport::TestCase
  test "title is required" do
    todo_item = TodoItem.new

    assert_not todo_item.valid?
    assert_includes todo_item.errors[:title], "can't be blank"
  end
end