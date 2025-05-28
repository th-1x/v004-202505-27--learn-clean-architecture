from uc.cp import Cp
from uc.create import TdCreate
from uc.list import TdList
from interface.i_td import ITd

class TdCli:
    def __init__(self, repo: ITd):
        self.create_todo = TdCreate(repo)
        self.list_todos = TdList(repo)
        self.complete_todo = Cp(repo)

    def run(self):
        while True:
            print("\nTodo CLI")
            print("1. Create Todo")
            print("2. List Todos")
            print("3. Complete Todo")
            print("4. Exit")

            choice = input("Choose an option: ")

            if choice == '1':
                title = input("Enter todo title: ")
                todo = self.create_todo.execute(title)
                print(f"Todo created: {todo}")

            elif choice == '2':
                todos = self.list_todos.execute()
                for todo in todos:
                    print(f" - [{ 'x' if todo.cp else ' ' }] {todo.id}: {todo.tt}")

            elif choice == '3':
                todo_id = int(input("Enter todo ID to complete: "))
                todo = self.complete_todo.execute(todo_id)
                print(f"Todo completed: {todo}")

            elif choice == '4':
                print("Exiting...")
                break

            else:
                print("Invalid option, please try again.")