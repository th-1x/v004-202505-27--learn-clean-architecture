from interface.i_td import ITd
from ett.todo import Todo

class MemDb(ITd):
    def __init__(self):
        self.todos = []
        self._next_id = 1


    def next_id(self):
        nid = self._next_id
        self._next_id += 1
        return nid
    

    def add(self, todo: Todo):
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
    


