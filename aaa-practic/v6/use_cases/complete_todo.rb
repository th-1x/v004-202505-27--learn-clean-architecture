require_relative '../entities/todo'

class CompleteTodo
  def initialize(repository)
    @repository = repository
  end
  
  def execute(todo_id)
    todo = @repository.find_by_id(todo_id)
    raise StandardError, "Todo with ID #{todo_id} not found" unless todo
    
    todo.completed = true
    @repository.update(todo)
    todo
  end
end
