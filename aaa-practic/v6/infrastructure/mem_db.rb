require_relative '../interfaces/todo_repository'
require_relative '../entities/todo'

class MemDb
  include TodoRepository
  
  def initialize
    @todos = []
    @next_id_counter = 1
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
    todo = @todos.find { |t| t.id == todo_id }
    raise StandardError, "Todo not found" unless todo
    todo
  end
  
  def update(updated_todo)
    index = @todos.find_index { |t| t.id == updated_todo.id }
    raise StandardError, "Todo not found" unless index
    @todos[index] = updated_todo
  end
  
  def delete(todo_id)
    index = @todos.find_index { |t| t.id == todo_id }
    raise StandardError, "Todo not found" unless index
    @todos.delete_at(index)
  end
  
  def count
    @todos.length
  end
end
