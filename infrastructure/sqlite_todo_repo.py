# infrastructure/sqlite_todo_repo.py
import sqlite3
from interfaces.todo_repository import TodoRepositoryInterface
from entities.todo import Todo

class SQLiteTodoRepo(TodoRepositoryInterface):
    def __init__(self, db_path="todos.db"):
        self.conn = sqlite3.connect(db_path)
        self._create_table()

    def _create_table(self):
        self.conn.execute('''
            CREATE TABLE IF NOT EXISTS todos (
                id INTEGER PRIMARY KEY,
                title TEXT NOT NULL,
                completed BOOLEAN NOT NULL
            )
        ''')
        self.conn.commit()

    def next_id(self):
        cursor = self.conn.execute("SELECT MAX(id) FROM todos")
        row = cursor.fetchone()
        return (row[0] or 0) + 1

    def save(self, todo: Todo):
        self.conn.execute(
            "INSERT INTO todos (id, title, completed) VALUES (?, ?, ?)",
            (todo.id, todo.title, todo.completed)
        )
        self.conn.commit()

    def list_all(self):
        cursor = self.conn.execute("SELECT id, title, completed FROM todos")
        return [Todo(id=row[0], title=row[1], completed=bool(row[2])) for row in cursor.fetchall()]

    def find_by_id(self, todo_id):
        cursor = self.conn.execute("SELECT id, title, completed FROM todos WHERE id=?", (todo_id,))
        row = cursor.fetchone()
        if not row:
            raise ValueError("Todo not found")
        return Todo(id=row[0], title=row[1], completed=bool(row[2]))

    def update(self, todo: Todo):
        self.conn.execute(
            "UPDATE todos SET title=?, completed=? WHERE id=?",
            (todo.title, todo.completed, todo.id)
        )
        self.conn.commit()
