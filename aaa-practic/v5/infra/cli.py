from uc.complete import TdComplete
from uc.create import TdCreate
from uc.list import TdList
from uc.delTd import DeleteTodoUseCase
from uc.count import CountTodosUseCase
from i.i_todo import ITd

class TodoCLI:
    def __init__(self, repo: ITd):
        self.create_todo = TdCreate(repo)
        self.list_todos = TdList(repo)
        self.complete_todo = TdComplete(repo)
        self.delete_todo = DeleteTodoUseCase(repo)
        self.count_todos = CountTodosUseCase(repo)


    def run(self):
        try:
            while True:
                print("\nTodo CLI")
                print("1. Create Todo")
                print("2. List Todos")
                print("3. Complete Todo")
                print("4. Delete Todo")
                print("5. Count Todos")
                print("6. Exit")

                try:
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
                        todo_id = int(input("Enter todo ID to delete: "))
                        self.delete_todo.execute(todo_id)
                        print(f"Todo with ID {todo_id} deleted.")
                    elif choice == '5':
                        count = self.count_todos.execute()
                        print(f"Total todos: {count}")
                    elif choice == '6':
                        print("Exiting...")
                        break

                    else:
                        print("Invalid option, please try again.")
                        
                except ValueError as e:
                    print(f"Invalid input: {e}")
                    
        except KeyboardInterrupt:
            print("\nProgram interrupted. Exiting...")
