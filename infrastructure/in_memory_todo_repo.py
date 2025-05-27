# infrastructure/in_memory_todo_repo.py
from interfaces.todo_repository import TodoRepositoryInterface
from entities.todo import Todo

class InMemoryTodoRepo(TodoRepositoryInterface):
    def __init__(self):
        self.todos = []
        self._next_id = 1

    def next_id(self):
        nid = self._next_id
        self._next_id += 1
        return nid

    def save(self, todo: Todo):
        self.todos.append(todo)

    def list_all(self):
        return self.todos
