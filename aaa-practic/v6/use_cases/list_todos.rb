require_relative '../entities/todo'

class ListTodos
  def initialize(repository)
    @repository = repository
  end
  
  def execute
    todos = @repository.list_all
    raise StandardError, "No todos found" if todos.empty?
    todos
  end
  
  def count
    @repository.count
  end
end
