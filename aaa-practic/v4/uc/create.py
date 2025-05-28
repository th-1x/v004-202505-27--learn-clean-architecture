from interface.i_td import ITd
from ett.todo import Todo

class TdCreate:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self, title: str) -> Todo:
        todo = Todo(
            id=self.repo.next_id(),
            tt=title,
            cp=False
        )
        self.repo.add(todo)
        return todo