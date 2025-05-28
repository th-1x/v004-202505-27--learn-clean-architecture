from i.i_todo import ITd
from ett.todo import Todo

class TdCreate:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self, title: str) -> Todo:
        if not title:
            raise ValueError("Title cannot be empty.")
        
        todo_id = self.repo.next_id()
        todo = Todo(id=todo_id, title=title)
        self.repo.add(todo)
        return todo