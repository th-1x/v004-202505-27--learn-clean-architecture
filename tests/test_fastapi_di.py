# tests/test_fastapi_di.py
from fastapi.testclient import TestClient
from api.fastapi_app import app
from tests.mock_todo_repo import MockTodoRepo
from fastapi import Depends

mock_repo = MockTodoRepo()

def override_get_repo():
    return mock_repo

app.dependency_overrides = {}
app.dependency_overrides["get_repo"] = override_get_repo

client = TestClient(app)

def test_create_list_complete():
    mock_repo.todos.clear()
    mock_repo.next_id_val = 1

    response = client.post("/todos", json={"title": "DI Test"})
    assert response.status_code == 200
    todo_data = response.json()
    assert todo_data["title"] == "DI Test"
    assert todo_data["completed"] is False

    response = client.get("/todos")
    assert response.status_code == 200
    todos = response.json()
    assert len(todos) == 1

    todo_id = todo_data["id"]
    response = client.post(f"/todos/{todo_id}/complete")
    assert response.status_code == 200
    assert response.json()["completed"] is True
