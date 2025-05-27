# interfaces/todo_repository.py
from entities.todo import Todo
from abc import ABC, abstractmethod

class TodoRepositoryInterface(ABC):
    @abstractmethod
    def next_id(self) -> int: pass

    @abstractmethod
    def save(self, todo: Todo) -> None: pass

    @abstractmethod
    def list_all(self) -> list[Todo]: pass

    # ---
    @abstractmethod
    def find_by_id(self, todo_id: int) -> Todo: pass

    @abstractmethod
    def update(self, todo: Todo) -> None: pass
