import unittest
from usecase.create import CreateTodoUseCase
from usecase.list import ListTodosUseCase
from tests.mock_todo_repo import MockTodoRepo

class TestUseCases(unittest.TestCase):
    def setUp(self):
        self.repo = MockTodoRepo()
        self.create_uc = CreateTodoUseCase(self.repo)
        self.list_uc = ListTodosUseCase(self.repo)

    def test_create_todo(self):
        todo = self.create_uc.execute("Write tests")
        self.assertEqual(todo.title, "Write tests")
        self.assertFalse(todo.completed)
        self.assertEqual(todo.id, 1)

    def test_list_todos(self):
        self.create_uc.execute("Task 1")
        self.create_uc.execute("Task 2")
        todos = self.list_uc.execute()
        self.assertEqual(len(todos), 2)
        self.assertEqual(todos[0].title, "Task 1")
        self.assertEqual(todos[1].title, "Task 2")


if __name__ == "__main__":
    unittest.main()
