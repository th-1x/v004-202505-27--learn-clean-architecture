from ett.todo import Todo
from interface.i_td import ITd


class MockTodoRepo(ITd):
    def __init__(self):
        self.todos = []
        self.next_id_val = 1

    def next_id(self):
        nid = self.next_id_val
        self.next_id_val += 1
        return nid

    def add(self, todo: Todo):
        self.todos.append(todo)

    def list_all(self):
        return self.todos

    def find_by_id(self, todo_id: int):
        for todo in self.todos:
            if todo.id == todo_id:
                return todo
        raise ValueError("Todo not found")

    def update(self, todo: Todo):
        for i, t in enumerate(self.todos):
            if t.id == todo.id:
                self.todos[i] = todo
                return
        raise ValueError("Todo not found")
