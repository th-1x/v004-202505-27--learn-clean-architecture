#!/usr/bin/env ruby

# Test runner script for Todo CLI Ruby implementation

puts "Running Todo CLI Ruby Tests..."
puts "=" * 50

# Run unit and use case tests
puts "\n1. Running Use Case Tests:"
puts "-" * 30
system("ruby tests/test_use_cases.rb -v")

# Run integration tests
puts "\n2. Running Integration Tests:"
puts "-" * 30
system("ruby tests/test_integration.rb -v")

puts "\n" + "=" * 50
puts "All tests completed!"

# Optional: Run syntax check on all Ruby files
puts "\n3. Syntax Check:"
puts "-" * 30

ruby_files = Dir.glob("**/*.rb")
ruby_files.each do |file|
  result = system("ruby -c #{file} > /dev/null 2>&1")
  puts "#{file}: #{result ? 'OK' : 'SYNTAX ERROR'}"
end

puts "\nTest run finished!"
