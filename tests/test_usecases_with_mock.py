# tests/test_usecases_with_mock.py
import unittest
from usecases.create_todo import CreateTodoUseCase
from usecases.complete_todo import CompleteTodoUseCase
from usecases.list_todos import ListTodosUseCase
from tests.mock_todo_repo import MockTodoRepo

class TestUseCasesWithMock(unittest.TestCase):
    def setUp(self):
        self.repo = MockTodoRepo()
        self.create_uc = CreateTodoUseCase(self.repo)
        self.complete_uc = CompleteTodoUseCase(self.repo)
        self.list_uc = ListTodosUseCase(self.repo)

    def test_create_list_complete(self):
        todo = self.create_uc.execute("Test Mock")
        self.assertFalse(todo.completed)

        todos = self.list_uc.execute()
        self.assertEqual(len(todos), 1)

        updated = self.complete_uc.execute(todo.id)
        self.assertTrue(updated.completed)

if __name__ == "__main__":
    unittest.main()
