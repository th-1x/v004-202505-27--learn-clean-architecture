# main.py
from infrastructure.in_memory_todo_repo import InMemoryTodoRepo
from infrastructure.sqlite_todo_repo import SQLiteTodoRepo

from infrastructure.cli import TodoCLI

if __name__ == "__main__":
    # repo = InMemoryTodoRepo()
    repo = SQLiteTodoRepo("todos.db")  # เปลี่ยนจาก InMemoryRepo

    cli = TodoCLI(repo)
    cli.run()
