require_relative '../entities/todo'

class CreateTodo
  def initialize(repository)
    @repository = repository
  end
  
  def execute(title)
    raise ArgumentError, "Title cannot be empty" if title.nil? || title.strip.empty?
    
    todo_id = @repository.next_id
    todo = Todo.new(id: todo_id, title: title.strip)
    @repository.add(todo)
    todo
  end
end
