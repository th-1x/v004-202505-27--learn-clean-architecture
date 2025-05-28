require_relative '../interfaces/todo_repository'
require_relative '../entities/todo'

class MockTodoRepo
  include TodoRepository
  
  def initialize
    @todos = []
    @next_id_counter = 1
    @find_by_id_should_fail = false
    @update_should_fail = false
    @delete_should_fail = false
  end
  
  def next_id
    id = @next_id_counter
    @next_id_counter += 1
    id
  end
  
  def add(todo)
    @todos << todo
  end
  
  def list_all
    @todos.dup
  end
  
  def find_by_id(todo_id)
    raise StandardError, "Todo not found" if @find_by_id_should_fail
    
    todo = @todos.find { |t| t.id == todo_id }
    raise StandardError, "Todo not found" unless todo
    todo
  end
  
  def update(updated_todo)
    raise StandardError, "Todo not found" if @update_should_fail
    
    index = @todos.find_index { |t| t.id == updated_todo.id }
    raise StandardError, "Todo not found" unless index
    @todos[index] = updated_todo
  end
  
  def delete(todo_id)
    raise StandardError, "Todo not found" if @delete_should_fail
    
    index = @todos.find_index { |t| t.id == todo_id }
    raise StandardError, "Todo not found" unless index
    @todos.delete_at(index)
  end
  
  def count
    @todos.length
  end
  
  # Test helper methods
  def make_find_by_id_fail!
    @find_by_id_should_fail = true
  end
  
  def make_update_fail!
    @update_should_fail = true
  end
  
  def make_delete_fail!
    @delete_should_fail = true
  end
  
  def reset_failures!
    @find_by_id_should_fail = false
    @update_should_fail = false
    @delete_should_fail = false
  end
end
