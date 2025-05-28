# Conversion Plan: Python (v5) to Ruby (v6) - Clean Architecture

## Overview
Converting the v5 Python implementation to Ruby while maintaining clean architecture principles.

## Directory Structure for v6 (Ruby)
```
v6/
├── main.rb                    # Entry point
├── entities/
│   └── todo.rb               # Todo entity
├── interfaces/
│   └── todo_repository.rb    # Repository interface/contract
├── infrastructure/
│   ├── mem_db.rb            # In-memory database implementation
│   └── cli.rb               # Command-line interface
├── use_cases/
│   ├── create_todo.rb       # Create todo use case
│   ├── list_todos.rb        # List todos use case
│   ├── complete_todo.rb     # Complete todo use case
│   ├── delete_todo.rb       # Delete todo use case
│   └── count_todos.rb       # Count todos use case
├── tests/
│   ├── mock_todo_repo.rb    # Mock repository for testing
│   └── test_use_cases.rb    # Use case tests
└── Gemfile                  # Ruby dependencies
```

## Key Conversion Mappings

| Python (v5) | Ruby (v6) | Notes |
|-------------|-----------|-------|
| `ett/todo.py` | `entities/todo.rb` | Domain entity |
| `i/i_todo.py` | `interfaces/todo_repository.rb` | Interface/contract |
| `infra/mem_db.py` | `infrastructure/mem_db.rb` | Repository implementation |
| `infra/cli.py` | `infrastructure/cli.rb` | CLI interface |
| `uc/*.py` | `use_cases/*.rb` | Business logic |
| `main.py` | `main.rb` | Application entry point |

## Ruby Implementation Details

### Key Ruby Conventions
- **Naming**: Use `snake_case` for files and methods, `PascalCase` for classes
- **Modules**: Use modules for interfaces instead of abstract base classes
- **Error handling**: Use `StandardError` subclasses instead of `ValueError`
- **Attributes**: Use `attr_accessor`, `attr_reader`, `attr_writer` for properties
- **String handling**: Use `strip` for whitespace removal
- **Collections**: Use Ruby's enumerable methods (`find`, `map`, `select`, etc.)

### Implementation Steps
1. Create v6 directory structure
2. Convert entities - Start with `Todo` class
3. Define interfaces - Create repository contract using Ruby modules
4. Implement infrastructure - Convert memory database and CLI
5. Convert use cases - Transform all business logic classes
6. Create main entry point - Ruby equivalent of main.py
7. Add testing - Convert Python tests to Ruby (MiniTest)
8. Add Gemfile - For any Ruby dependencies

### Dependencies (Gemfile)
```ruby
source 'https://rubygems.org'

gem 'minitest', '~> 5.0'  # For testing
```

## Testing Strategy
- Use MiniTest for unit testing
- Create mock repository for use case testing
- Test each layer independently
- Follow TDD approach - write tests first, then implementation
