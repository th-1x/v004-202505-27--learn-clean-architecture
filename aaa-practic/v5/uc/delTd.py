from i.i_todo import ITd

# usecases/delete_todo.py
class DeleteTodoUseCase:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self, todo_id: int) -> None:
        self.repo.delete(todo_id)
