import unittest
from uc.count import CountTodosUseCase
from tests.mock_td import MockTodoRepo

from ett.todo import Todo

# tests/test_count_todos.py
def test_count_todos():
    repo = MockTodoRepo()
    repo.save(Todo(id=1, title="A", completed=False))
    repo.save(Todo(id=2, title="B", completed=True))

    usecase = CountTodosUseCase(repo)
    assert usecase.execute() == 2
    
# uv run python -m unittest discover tests