from interfaces.todo_repository import TodoRepositoryInterface
from entity.todo import Todo

class InMemoryTodoRepository(TodoRepositoryInterface):
    def __init__(self):
        self.todos = []
        self.next_id_counter = 1

    def next_id(self) -> int:
        """Get the next available ID for a todo item."""
        return self.next_id_counter

    def add(self, todo: Todo) -> Todo:
        """Add a new todo item."""
        todo.id = self.next_id_counter
        self.todos.append(todo)
        self.next_id_counter += 1
        return todo

    def list_all(self) -> list[Todo]:
        """List all todo items."""
        return self.todos