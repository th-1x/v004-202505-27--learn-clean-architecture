from entity.todo import Todo
from interfaces.todo_repository import TodoRepositoryInterface

class AddTodoUseCase:
    def __init__(self, todo_repository):
        self.todo_repository = todo_repository

    def execute(self, title: str) -> Todo:
        """Add a new todo item."""
        next_id = self.todo_repository.next_id()
        todo = Todo(id=next_id, title=title)
        return self.todo_repository.add(todo)