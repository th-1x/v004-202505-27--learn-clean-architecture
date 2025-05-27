# main.py
from infrastructure.in_memory_todo_repo import InMemoryTodoRepo
from infrastructure.cli import TodoCLI

if __name__ == "__main__":
    repo = InMemoryTodoRepo()
    cli = TodoCLI(repo)
    cli.run()
