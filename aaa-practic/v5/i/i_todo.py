from abc import ABC, abstractmethod
from ett.todo import Todo

class ITd(ABC):
    @abstractmethod
    def next_id(self) -> int: pass
    @abstractmethod
    def add(self, todo: Todo) -> None: pass
    @abstractmethod
    def list_all(self) -> list[Todo]: pass
    @abstractmethod
    def find_by_id(self, todo_id: int) -> Todo: pass
    @abstractmethod
    def update(self, todo: Todo) -> None: pass
    @abstractmethod
    def delete(self, todo_id: int) -> None: pass
    @abstractmethod
    def count(self) -> int: pass
        