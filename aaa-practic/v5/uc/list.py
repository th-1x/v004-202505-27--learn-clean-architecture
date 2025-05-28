from i.i_todo import ITd
from ett.todo import Todo

class TdList:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self) -> list[Todo]:
        todos = self.repo.list_all()
        if not todos:
            raise ValueError("No todos found.")
        return todos

    def count(self) -> int:
        return self.repo.count()