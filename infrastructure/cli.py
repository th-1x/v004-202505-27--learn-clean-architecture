# infrastructure/cli.py
from usecases.create_todo import CreateTodoUseCase
from usecases.list_todos import ListTodosUseCase
from interfaces.todo_repository import TodoRepositoryInterface

class TodoCLI:
    def __init__(self, repo: TodoRepositoryInterface):
        self.create_todo = CreateTodoUseCase(repo)
        self.list_todos = ListTodosUseCase(repo)

    def run(self):
        while True:
            print("\n1. Add Todo\n2. List Todos\n3. Exit")
            choice = input("Choose: ")
            if choice == "1":
                title = input("Todo title: ")
                todo = self.create_todo.execute(title)
                print(f"✅ Created: {todo.id} - {todo.title}")
            elif choice == "2":
                todos = self.list_todos.execute()
                print("📋 Todos:")
                for t in todos:
                    print(f" - [{ 'x' if t.completed else ' ' }] {t.id}: {t.title}")
            elif choice == "3":
                tid = int(input("Todo ID to complete: "))
                try:
                    todo = self.complete_todo.execute(tid)
                    print(f"✅ Marked complete: {todo.id} - {todo.title}")
                except ValueError:
                    print("❌ Todo not found")
            elif choice == "4":
                break

            else:
                print("❌ Invalid choice.")
