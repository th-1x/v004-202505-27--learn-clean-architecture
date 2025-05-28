import unittest
from uc.create import TdCreate
from uc.cp import Cp
from uc.list import TdList
from tests.mock_td import MockTodoRepo

class TestUseCases(unittest.TestCase):
    def setUp(self):
        repo = MockTodoRepo()
        self.create_uc = TdCreate(repo)
        self.list_uc = TdList(repo)
        self.complete_uc = Cp(repo)

    def test_create_todo(self):
        todo = self.create_uc.execute("Write tests")
        self.assertEqual(todo.tt, "Write tests")
        self.assertFalse(todo.cp)
        self.assertEqual(todo.id, 1)

    def test_list_todos(self):
        self.create_uc.execute("Task 1")
        self.create_uc.execute("Task 2")
        todos = self.list_uc.execute()
        self.assertEqual(len(todos), 2)
        self.assertEqual(todos[0].tt, "Task 1")
        self.assertEqual(todos[1].tt, "Task 2")

    def test_complete_todo(self):
        todo = self.create_uc.execute("Complete me")
        updated = self.complete_uc.execute(todo.id)
        self.assertTrue(updated.cp)

        with self.assertRaises(ValueError):
            self.complete_uc.execute(999)  # ID ไม่พบ

if __name__ == "__main__":
    unittest.main()
