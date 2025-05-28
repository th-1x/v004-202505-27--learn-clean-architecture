class DeleteTodo
  def initialize(repository)
    @repository = repository
  end
  
  def execute(todo_id)
    @repository.delete(todo_id)
  end
end
