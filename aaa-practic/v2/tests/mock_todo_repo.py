# tests/mock_todo_repo.py
from entities.todo import Todo
from i.todo_repository import TodoRepositoryInterface

class MockTodoRepo(TodoRepositoryInterface):
    def __init__(self):
        self.todos = []
        self.next_id_val = 1

    def next_id(self):
        nid = self.next_id_val
        self.next_id_val += 1
        return nid

    def create(self, todo: Todo):
        self.todos.append(todo)
        return todo  # Make sure this line exists

    def list_all(self):
        return self.todos

