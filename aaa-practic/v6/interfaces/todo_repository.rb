# Ruby doesn't have abstract classes like Python's ABC
# We'll use a module to define the contract
module TodoRepository
  def next_id
    raise NotImplementedError, "#{self.class} must implement #next_id"
  end
  
  def add(todo)
    raise NotImplementedError, "#{self.class} must implement #add"
  end
  
  def list_all
    raise NotImplementedError, "#{self.class} must implement #list_all"
  end
  
  def find_by_id(todo_id)
    raise NotImplementedError, "#{self.class} must implement #find_by_id"
  end
  
  def update(todo)
    raise NotImplementedError, "#{self.class} must implement #update"
  end
  
  def delete(todo_id)
    raise NotImplementedError, "#{self.class} must implement #delete"
  end
  
  def count
    raise NotImplementedError, "#{self.class} must implement #count"
  end
end
