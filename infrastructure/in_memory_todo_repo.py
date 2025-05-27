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
    
    # ---
    def find_by_id(self, todo_id):
        for todo in self.todos:
            if todo.id == todo_id:
                return todo
        raise ValueError("Todo not found")

    def update(self, updated_todo):
        for i, todo in enumerate(self.todos):
            if todo.id == updated_todo.id:
                self.todos[i] = updated_todo
                return
        raise ValueError("Todo not found")

