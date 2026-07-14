require "test_helper"

class TodoItemsControllerTest < ActionDispatch::IntegrationTest
  test "should show the todo list" do
    get root_url

    assert_response :success
    assert_select "h1", "Keep the list small and the momentum high."
  end

  test "can create a todo item" do
    assert_difference("TodoItem.count", 1) do
      post todo_items_url, params: { todo_item: { title: "Plan the week" } }
    end

    assert_redirected_to root_url
    assert_equal "Plan the week", TodoItem.last.title
  end

  test "can complete and delete a todo item" do
    todo_item = TodoItem.create!(title: "Write tests")

    patch todo_item_url(todo_item), params: { todo_item: { title: todo_item.title, completed: true } }
    assert_redirected_to root_url
    assert_predicate todo_item.reload, :completed?

    assert_difference("TodoItem.count", -1) do
      delete todo_item_url(todo_item)
    end
  end
end