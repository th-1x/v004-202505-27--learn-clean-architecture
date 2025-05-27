from entities.todo import Todo
from i.todo_repository import TodoRepositoryInterface

class CreateTodoUseCase:
    def __init__(self, repository: TodoRepositoryInterface):
        self.repository = repository

    def execute(self, title):
        # Print methods and properties separately
        methods = [attr for attr in dir(self.repository) if callable(getattr(self.repository, attr)) and not attr.startswith('_')]
        props = [attr for attr in dir(self.repository) if not callable(getattr(self.repository, attr)) and not attr.startswith('_')]
        
        print(f"Methods: {methods}")
        print(f"Properties: {props}")

        # Create the entity
        print(f"Creating todo with title: {title}")
        todo = Todo(id=self.repository.next_id(), title=title)  # Add () here
        print(f"Todo created with ID: {todo.id}")
        entity = self.repository.create(todo)
        
        return entity