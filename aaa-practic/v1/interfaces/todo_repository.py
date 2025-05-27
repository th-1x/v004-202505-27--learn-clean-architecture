from abc import ABC, abstractmethod
from entity.todo import Todo

class TodoRepositoryInterface(ABC):
    @abstractmethod
    def next_id(self) -> int:
        """Get the next available ID for a todo item."""
        pass

    @abstractmethod
    def add(self, todo: Todo) -> Todo:
        """Add a new todo item."""
        pass

    @abstractmethod
    def list_all(self) -> list[Todo]:
        """List all todo items."""
        pass

