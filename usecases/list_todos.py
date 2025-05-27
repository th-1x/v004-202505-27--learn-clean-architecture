# usecases/list_todos.py
from interfaces.todo_repository import TodoRepositoryInterface

class ListTodosUseCase:
    def __init__(self, repo: TodoRepositoryInterface):
        self.repo = repo

    def execute(self):
        return self.repo.list_all()
