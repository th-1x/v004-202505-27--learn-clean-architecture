require 'minitest/autorun'
require_relative '../infrastructure/mem_db'
require_relative '../infrastructure/cli'
require_relative '../entities/todo'

class TestIntegration < Minitest::Test
  def setup
    @repo = MemDb.new
    @cli = TodoCLI.new(@repo)
  end
  
  def test_complete_workflow
    # Test repository directly
    todo = Todo.new(id: @repo.next_id, title: "Test Integration Todo")
    @repo.add(todo)
    
    assert_equal 1, @repo.count
    
    found_todo = @repo.find_by_id(1)
    assert_equal "Test Integration Todo", found_todo.title
    refute found_todo.completed?
    
    # Complete the todo
    found_todo.completed = true
    @repo.update(found_todo)
    
    updated_todo = @repo.find_by_id(1)
    assert updated_todo.completed?
    
    # Delete the todo
    @repo.delete(1)
    assert_equal 0, @repo.count
  end
  
  def test_cli_initialization
    assert_instance_of TodoCLI, @cli
    assert_instance_of MemDb, @repo
  end
end
