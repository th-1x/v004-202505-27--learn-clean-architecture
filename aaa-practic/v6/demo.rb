#!/usr/bin/env ruby

# Demo script for Todo CLI Ruby implementation
require_relative 'infrastructure/mem_db'
require_relative 'use_cases/create_todo'
require_relative 'use_cases/list_todos'
require_relative 'use_cases/complete_todo'
require_relative 'use_cases/delete_todo'
require_relative 'use_cases/count_todos'

puts "Todo CLI Ruby v6 - Demo"
puts "=" * 40

# Initialize repository
repo = MemDb.new

# Initialize use cases
create_todo = CreateTodo.new(repo)
list_todos = ListTodos.new(repo)
complete_todo = CompleteTodo.new(repo)
delete_todo = DeleteTodo.new(repo)
count_todos = CountTodos.new(repo)

puts "\n1. Creating todos..."
todo1 = create_todo.execute("Learn Ruby Clean Architecture")
todo2 = create_todo.execute("Convert Python to Ruby")
todo3 = create_todo.execute("Write comprehensive tests")

puts "Created: #{todo1}"
puts "Created: #{todo2}"
puts "Created: #{todo3}"

puts "\n2. Listing all todos..."
todos = list_todos.execute
todos.each { |todo| puts " - #{todo}" }

puts "\n3. Completing a todo..."
completed_todo = complete_todo.execute(2)
puts "Completed: #{completed_todo}"

puts "\n4. Listing todos after completion..."
todos = list_todos.execute
todos.each { |todo| puts " - #{todo}" }

puts "\n5. Counting todos..."
count = count_todos.execute
puts "Total todos: #{count}"

puts "\n6. Deleting a todo..."
delete_todo.execute(3)
puts "Deleted todo with ID 3"

puts "\n7. Final list..."
todos = list_todos.execute
todos.each { |todo| puts " - #{todo}" }

puts "\n8. Final count..."
count = count_todos.execute
puts "Total todos: #{count}"

puts "\n" + "=" * 40
puts "Demo completed successfully!"
puts "Ruby Clean Architecture implementation is working!"
