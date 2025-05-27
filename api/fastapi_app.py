from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel

# Pydantic models for API
class TodoIn(BaseModel):
    title: str

class TodoOut(BaseModel):
    id: int
    title: str
    completed: bool

# FastAPI app initialization
app = FastAPI(title="Todo API", description="A simple Todo API using Clean Architecture")

def get_repo():
    from infrastructure.sqlite_todo_repo import SQLiteTodoRepo
    return SQLiteTodoRepo("todos.db")

def get_create_todo(repo=Depends(get_repo)):
    from usecases.create_todo import CreateTodoUseCase
    return CreateTodoUseCase(repo)

def get_list_todos(repo=Depends(get_repo)):
    from usecases.list_todos import ListTodosUseCase
    return ListTodosUseCase(repo)

def get_complete_todo(repo=Depends(get_repo)):
    from usecases.complete_todo import CompleteTodoUseCase
    return CompleteTodoUseCase(repo)

@app.post("/todos", response_model=TodoOut)
def create(todo: TodoIn, usecase = Depends(get_create_todo)):
    new = usecase.execute(todo.title)
    return TodoOut(id=new.id, title=new.title, completed=new.completed)

@app.get("/todos", response_model=list[TodoOut])
def list_all(usecase = Depends(get_list_todos)):
    todos = usecase.execute()
    return [TodoOut(id=t.id, title=t.title, completed=t.completed) for t in todos]

@app.post("/todos/{todo_id}/complete", response_model=TodoOut)
def complete(todo_id: int, usecase = Depends(get_complete_todo)):
    try:
        todo = usecase.execute(todo_id)
        return TodoOut(id=todo.id, title=todo.title, completed=todo.completed)
    except ValueError:
        raise HTTPException(status_code=404, detail="Todo not found")
