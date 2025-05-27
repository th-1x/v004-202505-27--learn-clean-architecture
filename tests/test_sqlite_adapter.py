# tests/test_sqlite_adapter.py
from infrastructure.sqlite_todo_repo import SQLiteTodoRepo
from entities.todo import Todo

repo = SQLiteTodoRepo(":memory:")  # ใช้ in-memory DB ของ SQLite
todo = Todo(id=1, title="Test", completed=False)
repo.save(todo)

fetched = repo.find_by_id(1)
assert fetched.title == "Test"
