class CountTodos
  def initialize(repository)
    @repository = repository
  end
  
  def execute
    @repository.count
  end
end
