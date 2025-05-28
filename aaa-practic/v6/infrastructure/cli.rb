require_relative '../use_cases/create_todo'
require_relative '../use_cases/list_todos'
require_relative '../use_cases/complete_todo'
require_relative '../use_cases/delete_todo'
require_relative '../use_cases/count_todos'

class TodoCLI
  def initialize(repository)
    @create_todo = CreateTodo.new(repository)
    @list_todos = ListTodos.new(repository)
    @complete_todo = CompleteTodo.new(repository)
    @delete_todo = DeleteTodo.new(repository)
    @count_todos = CountTodos.new(repository)
  end
  
  def run
    loop do
      display_menu
      choice = gets.chomp
      
      case choice
      when '1'
        handle_create_todo
      when '2'
        handle_list_todos
      when '3'
        handle_complete_todo
      when '4'
        handle_delete_todo
      when '5'
        handle_count_todos
      when '6'
        puts "Exiting..."
        break
      else
        puts "Invalid option, please try again."
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  rescue Interrupt
    puts "\nProgram interrupted. Exiting..."
  end
  
  private
  
  def display_menu
    puts "\nTodo CLI"
    puts "1. Create Todo"
    puts "2. List Todos"
    puts "3. Complete Todo"
    puts "4. Delete Todo"
    puts "5. Count Todos"
    puts "6. Exit"
    print "Choose an option: "
  end
  
  def handle_create_todo
    print "Enter todo title: "
    title = gets.chomp
    todo = @create_todo.execute(title)
    puts "Todo created: #{todo}"
  end
  
  def handle_list_todos
    todos = @list_todos.execute
    todos.each { |todo| puts " - #{todo}" }
  end
  
  def handle_complete_todo
    print "Enter todo ID to complete: "
    todo_id = gets.chomp.to_i
    todo = @complete_todo.execute(todo_id)
    puts "Todo completed: #{todo}"
  end
  
  def handle_delete_todo
    print "Enter todo ID to delete: "
    todo_id = gets.chomp.to_i
    @delete_todo.execute(todo_id)
    puts "Todo with ID #{todo_id} deleted."
  end
  
  def handle_count_todos
    count = @count_todos.execute
    puts "Total todos: #{count}"
  end
end
