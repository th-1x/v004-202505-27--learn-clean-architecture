# tests/test_fastapi_with_mock.py
from fastapi.testclient import TestClient
from api.fastapi_app import app
from unittest.mock import patch
from entities.todo import Todo
from tests.mock_todo_repo import MockTodoRepo

client = TestClient(app)

# สร้าง Mock Repo ที่จะแทนที่ SQLiteTodoRepo ใน API
mock_repo = MockTodoRepo()

# Patch repo ใน fastapi_app module
@patch("api.fastapi_app.repo", mock_repo)
@patch("api.fastapi_app.create_todo", create_todo := None)
@patch("api.fastapi_app.list_todos", list_todos := None)
@patch("api.fastapi_app.complete_todo", complete_todo := None)
def test_create_list_complete():
    # รีเซ็ต mock repo
    mock_repo.todos.clear()
    mock_repo.next_id_val = 1

    # เรียก POST /todos
    response = client.post("/todos", json={"title": "Test API"})
    assert response.status_code == 200
    todo_data = response.json()
    assert todo_data["title"] == "Test API"
    assert todo_data["completed"] is False

    # เรียก GET /todos
    response = client.get("/todos")
    assert response.status_code == 200
    todos = response.json()
    assert len(todos) == 1

    # เรียก POST /todos/{id}/complete
    todo_id = todo_data["id"]
    response = client.post(f"/todos/{todo_id}/complete")
    assert response.status_code == 200
    completed_todo = response.json()
    assert completed_todo["completed"] is True
