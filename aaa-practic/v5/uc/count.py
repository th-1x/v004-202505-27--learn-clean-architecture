from i.i_todo import ITd

# usecases/count_todos.py
class CountTodosUseCase:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self) -> int:
        return self.repo.count()
