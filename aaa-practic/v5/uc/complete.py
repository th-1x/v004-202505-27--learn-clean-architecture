from i.i_todo import ITd
from ett.todo import Todo

class TdComplete:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self, todo_id: int) -> Todo:
        todo = self.repo.find_by_id(todo_id)
        if not todo:
            raise ValueError(f"Todo with ID {todo_id} not found.")
        
        todo.cp = True
        self.repo.update(todo)
        return todo