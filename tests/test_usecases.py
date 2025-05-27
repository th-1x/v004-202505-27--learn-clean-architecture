# tests/test_usecases.py
import unittest
from infrastructure.in_memory_todo_repo import InMemoryTodoRepo
from usecases.create_todo import CreateTodoUseCase
from usecases.complete_todo import CompleteTodoUseCase

class TestTodoUseCases(unittest.TestCase):
    def test_create_and_complete_todo(self):
        repo = InMemoryTodoRepo()
        create_uc = CreateTodoUseCase(repo)
        complete_uc = CompleteTodoUseCase(repo)

        todo = create_uc.execute("Write test")
        self.assertFalse(todo.completed)

        updated = complete_uc.execute(todo.id)
        self.assertTrue(updated.completed)

if __name__ == "__main__":
    unittest.main()
