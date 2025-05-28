class Todo
  attr_accessor :id, :title, :completed
  
  def initialize(id:, title:, completed: false)
    @id = id
    @title = title
    @completed = completed
  end
  
  def completed?
    @completed
  end
  
  def to_s
    "[#{completed? ? 'x' : ' '}] #{id}: #{title}"
  end
  
  def ==(other)
    other.is_a?(Todo) && 
      @id == other.id && 
      @title == other.title && 
      @completed == other.completed
  end
end
