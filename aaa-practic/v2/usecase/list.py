from i.todo_repository import TodoRepositoryInterface

class ListTodosUseCase:
    def __init__(self, todo_repository: TodoRepositoryInterface):
        self.todo_repository = todo_repository

    def execute(self):
        """List all todo items."""
        return self.todo_repository.list_all()