from abc import ABC, abstractmethod
from entities.todo import Todo

class TodoRepositoryInterface(ABC):
    @abstractmethod
    def next_id(self) -> int:
        """Get the next available ID for a todo item."""
        pass

    @abstractmethod
    def create(self, todo: Todo) -> Todo:
        """Add a new todo item."""
        pass

    @abstractmethod
    def list_all(self) -> list[Todo]:
        """List all todo items."""
        pass

