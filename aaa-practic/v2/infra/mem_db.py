from entities.todo import Todo

from i.todo_repository import TodoRepositoryInterface

class MemDB(TodoRepositoryInterface):
    def __init__(self):
        self.todos = []
        self.next_id = 1
        print("In-memory database initialized.")

    def next_id(self) -> int:
        """Get the next available ID for a todo item."""
        print(f"Next ID requested: {self.next_id}")
        return self.next_id

    def create(self, todo: Todo) -> Todo:
        """Add a new todo item."""
        todo.id = self.next_id
        self.todos.append(todo)
        self.next_id += 1
        return todo

    def list_all(self) -> list[Todo]:
        """List all todo items."""
        return self.todos