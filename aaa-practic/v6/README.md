# Todo CLI Application - Ruby v6

This is a Ruby implementation of a Todo CLI application following Clean Architecture principles, converted from the Python v5 implementation.

## Architecture

The application follows Clean Architecture with clear separation of concerns:

```
v6/
├── entities/          # Domain entities (Todo)
├── interfaces/        # Repository contracts/interfaces
├── use_cases/         # Business logic layer
├── infrastructure/    # External concerns (CLI, Database)
├── tests/            # Test suite
├── main.rb           # Application entry point
└── Gemfile           # Dependencies
```

## Features

- Create todos
- List all todos
- Complete todos
- Delete todos
- Count todos
- Interactive CLI interface

## Installation

### Option 1: Local Ruby Installation

1. Install Ruby (version 2.7 or higher)
2. Install dependencies:
   ```bash
   bundle install
   ```

### Option 2: Docker (Recommended)

1. Install Docker and Docker Compose
2. Build and run using Docker:
   ```bash
   # Build the image
   ./docker.sh build
   
   # Or use Docker Compose
   docker compose build
   ```

## Usage

### Local Ruby Usage

Run the application:
```bash
ruby main.rb
```

### Docker Usage

```bash
# Interactive CLI
./docker.sh run

# Or with Docker Compose
docker compose up todo-cli
```

This will start an interactive CLI with the following options:
1. Create Todo
2. List Todos
3. Complete Todo
4. Delete Todo
5. Count Todos
6. Exit

### Docker Commands

```bash
# Build image
./docker.sh build

# Run tests
./docker.sh test

# Run demo
./docker.sh demo

# Open shell in container
./docker.sh shell

# Clean up containers and images
./docker.sh clean
```

## Testing

### Local Testing

Run all tests:
```bash
ruby tests/test_use_cases.rb
ruby tests/test_integration.rb
```

Run tests with verbose output:
```bash
ruby tests/test_use_cases.rb -v
```

### Docker Testing

```bash
# Run all tests in container
./docker.sh test

# Or with Docker Compose
docker compose up todo-tests
```

## Architecture Details

### Entities Layer
- `Todo`: Domain entity representing a todo item with id, title, and completion status

### Interfaces Layer
- `TodoRepository`: Contract defining repository operations (add, find, update, delete, etc.)

### Use Cases Layer
- `CreateTodo`: Creates a new todo
- `ListTodos`: Lists all todos
- `CompleteTodo`: Marks a todo as completed
- `DeleteTodo`: Deletes a todo
- `CountTodos`: Returns the count of todos

### Infrastructure Layer
- `MemDb`: In-memory repository implementation
- `TodoCLI`: Command-line interface for user interaction

## Design Principles

1. **Dependency Inversion**: Use cases depend on abstractions (interfaces), not concrete implementations
2. **Single Responsibility**: Each class has one reason to change
3. **Open/Closed**: Easy to extend with new repository implementations
4. **Interface Segregation**: Repository interface only contains necessary methods
5. **Clean Architecture**: Dependencies flow inward toward the domain

## Testing Strategy

- **Unit Tests**: Test each layer independently
- **Mock Repository**: Allows testing use cases without database dependencies
- **Integration Tests**: Verify complete workflows
- **Test Coverage**: All classes and methods are tested

## Conversion Notes

This Ruby implementation maintains the same Clean Architecture principles as the Python v5 version:

- Entity properties use Ruby conventions (`snake_case` methods, `attr_accessor`)
- Interface contracts use Ruby modules instead of Python's ABC
- Error handling uses Ruby's `StandardError` instead of Python's `ValueError`
- Ruby idioms are used throughout (blocks, enumerable methods)

## Example Usage

```ruby
# Initialize repository
repo = MemDb.new

# Create use case
create_todo = CreateTodo.new(repo)

# Create a todo
todo = create_todo.execute("Learn Ruby Clean Architecture")

# List todos
list_todos = ListTodos.new(repo)
todos = list_todos.execute
todos.each { |todo| puts todo }
```
