from usecase.create import CreateTodoUseCase
from usecase.list import ListTodosUseCase

from i.todo_repository import TodoRepositoryInterface

class TodoCli:
    def __init__(self, repo: TodoRepositoryInterface):
        """Initialize the CLI with a Todo repository."""
        self.create_todo = CreateTodoUseCase(repo)
        self.list_todos = ListTodosUseCase(repo)

    def run(self):
        while True:
            print("\nTodo CLI")
            print("1. Add Todo")
            print("2. List Todos")
            print("3. Exit")
            choice = input("Choose an option: ")

            if choice == '1':
                title = input("Enter todo title: ")
                todo = self.create_todo.execute(title)
                print(f"Added Todo: {todo.title} (ID: {todo.id})")
            elif choice == '2':
                todos = self.list_todos.execute()
                if todos:
                    print("\nTodos:")
                    for todo in todos:
                        print(f"{todo.id}: {todo.title}")
                else:
                    print("No todos found.")
            elif choice == '3':
                print("Exiting...")
                break
            else:
                print("Invalid option, please try again.")