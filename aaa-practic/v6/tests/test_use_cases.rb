require 'minitest/autorun'
require_relative '../entities/todo'
require_relative '../infrastructure/mem_db'
require_relative '../use_cases/create_todo'
require_relative '../use_cases/list_todos'
require_relative '../use_cases/complete_todo'
require_relative '../use_cases/delete_todo'
require_relative '../use_cases/count_todos'
require_relative 'mock_todo_repo'

class TestTodoEntity < Minitest::Test
  def test_todo_initialization
    todo = Todo.new(id: 1, title: "Test Todo")
    assert_equal 1, todo.id
    assert_equal "Test Todo", todo.title
    assert_equal false, todo.completed
    refute todo.completed?
  end
  
  def test_todo_initialization_with_completed
    todo = Todo.new(id: 1, title: "Test Todo", completed: true)
    assert todo.completed?
  end
  
  def test_todo_to_s
    todo = Todo.new(id: 1, title: "Test Todo")
    assert_equal "[ ] 1: Test Todo", todo.to_s
    
    todo.completed = true
    assert_equal "[x] 1: Test Todo", todo.to_s
  end
  
  def test_todo_equality
    todo1 = Todo.new(id: 1, title: "Test Todo")
    todo2 = Todo.new(id: 1, title: "Test Todo")
    todo3 = Todo.new(id: 2, title: "Test Todo")
    
    assert_equal todo1, todo2
    refute_equal todo1, todo3
  end
end

class TestMemDb < Minitest::Test
  def setup
    @repo = MemDb.new
  end
  
  def test_next_id_increments
    assert_equal 1, @repo.next_id
    assert_equal 2, @repo.next_id
    assert_equal 3, @repo.next_id
  end
  
  def test_add_and_list_all
    todo = Todo.new(id: 1, title: "Test Todo")
    @repo.add(todo)
    
    todos = @repo.list_all
    assert_equal 1, todos.length
    assert_equal todo, todos.first
  end
  
  def test_find_by_id
    todo = Todo.new(id: 1, title: "Test Todo")
    @repo.add(todo)
    
    found_todo = @repo.find_by_id(1)
    assert_equal todo, found_todo
  end
  
  def test_find_by_id_not_found
    assert_raises(StandardError) { @repo.find_by_id(999) }
  end
  
  def test_update
    todo = Todo.new(id: 1, title: "Test Todo")
    @repo.add(todo)
    
    updated_todo = Todo.new(id: 1, title: "Updated Todo", completed: true)
    @repo.update(updated_todo)
    
    found_todo = @repo.find_by_id(1)
    assert_equal "Updated Todo", found_todo.title
    assert found_todo.completed?
  end
  
  def test_update_not_found
    todo = Todo.new(id: 999, title: "Nonexistent Todo")
    assert_raises(StandardError) { @repo.update(todo) }
  end
  
  def test_delete
    todo = Todo.new(id: 1, title: "Test Todo")
    @repo.add(todo)
    
    @repo.delete(1)
    assert_equal 0, @repo.count
  end
  
  def test_delete_not_found
    assert_raises(StandardError) { @repo.delete(999) }
  end
  
  def test_count
    assert_equal 0, @repo.count
    
    @repo.add(Todo.new(id: 1, title: "Todo 1"))
    assert_equal 1, @repo.count
    
    @repo.add(Todo.new(id: 2, title: "Todo 2"))
    assert_equal 2, @repo.count
  end
end

class TestCreateTodo < Minitest::Test
  def setup
    @repo = MockTodoRepo.new
    @use_case = CreateTodo.new(@repo)
  end
  
  def test_execute_creates_todo
    todo = @use_case.execute("Test Todo")
    
    assert_equal 1, todo.id
    assert_equal "Test Todo", todo.title
    refute todo.completed?
    assert_equal 1, @repo.count
  end
  
  def test_execute_with_whitespace_title
    todo = @use_case.execute("  Test Todo  ")
    assert_equal "Test Todo", todo.title
  end
  
  def test_execute_with_empty_title
    assert_raises(ArgumentError) { @use_case.execute("") }
    assert_raises(ArgumentError) { @use_case.execute("   ") }
    assert_raises(ArgumentError) { @use_case.execute(nil) }
  end
end

class TestListTodos < Minitest::Test
  def setup
    @repo = MockTodoRepo.new
    @use_case = ListTodos.new(@repo)
  end
  
  def test_execute_returns_todos
    todo1 = Todo.new(id: 1, title: "Todo 1")
    todo2 = Todo.new(id: 2, title: "Todo 2")
    @repo.add(todo1)
    @repo.add(todo2)
    
    todos = @use_case.execute
    assert_equal 2, todos.length
    assert_includes todos, todo1
    assert_includes todos, todo2
  end
  
  def test_execute_with_no_todos
    assert_raises(StandardError) { @use_case.execute }
  end
  
  def test_count
    @repo.add(Todo.new(id: 1, title: "Todo 1"))
    @repo.add(Todo.new(id: 2, title: "Todo 2"))
    
    assert_equal 2, @use_case.count
  end
end

class TestCompleteTodo < Minitest::Test
  def setup
    @repo = MockTodoRepo.new
    @use_case = CompleteTodo.new(@repo)
  end
  
  def test_execute_completes_todo
    todo = Todo.new(id: 1, title: "Test Todo")
    @repo.add(todo)
    
    completed_todo = @use_case.execute(1)
    
    assert completed_todo.completed?
    assert_equal todo.id, completed_todo.id
    assert_equal todo.title, completed_todo.title
  end
  
  def test_execute_with_nonexistent_todo
    @repo.make_find_by_id_fail!
    assert_raises(StandardError) { @use_case.execute(999) }
  end
end

class TestDeleteTodo < Minitest::Test
  def setup
    @repo = MockTodoRepo.new
    @use_case = DeleteTodo.new(@repo)
  end
  
  def test_execute_deletes_todo
    todo = Todo.new(id: 1, title: "Test Todo")
    @repo.add(todo)
    
    @use_case.execute(1)
    assert_equal 0, @repo.count
  end
  
  def test_execute_with_nonexistent_todo
    @repo.make_delete_fail!
    assert_raises(StandardError) { @use_case.execute(999) }
  end
end

class TestCountTodos < Minitest::Test
  def setup
    @repo = MockTodoRepo.new
    @use_case = CountTodos.new(@repo)
  end
  
  def test_execute_returns_count
    assert_equal 0, @use_case.execute
    
    @repo.add(Todo.new(id: 1, title: "Todo 1"))
    assert_equal 1, @use_case.execute
    
    @repo.add(Todo.new(id: 2, title: "Todo 2"))
    assert_equal 2, @use_case.execute
  end
end
