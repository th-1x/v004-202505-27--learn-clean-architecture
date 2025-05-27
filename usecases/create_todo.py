# usecases/create_todo.py
from entities.todo import Todo
from interfaces.todo_repository import TodoRepositoryInterface

class CreateTodoUseCase:
    def __init__(self, repo: TodoRepositoryInterface):
        self.repo = repo

    def execute(self, title: str) -> Todo:
        todo = Todo(id=self.repo.next_id(), title=title)
        self.repo.save(todo)
        return todo
