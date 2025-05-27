# usecases/complete_todo.py
from interfaces.todo_repository import TodoRepositoryInterface

class CompleteTodoUseCase:
    def __init__(self, repo: TodoRepositoryInterface):
        self.repo = repo
        self.complete_todo = CompleteTodoUseCase(repo)

    def execute(self, todo_id: int):
        todo = self.repo.find_by_id(todo_id)
        todo.completed = True
        self.repo.update(todo)
        return todo
