from interface.i_td import ITd
from ett.todo import Todo

class Cp:
    def __init__(self, repo: ITd):
        self.repo = repo


    def execute(self, todo_id: int) -> Todo:
        todo = self.repo.find_by_id(todo_id)
        todo.cp = True
        self.repo.update(todo)
        return todo
    