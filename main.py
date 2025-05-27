# main.py
from usecases.create_todo import CreateTodoUseCase
from infrastructure.in_memory_todo_repo import InMemoryTodoRepo

repo = InMemoryTodoRepo()
usecase = CreateTodoUseCase(repo)

todo = usecase.execute("Learn Clean Architecture")
print(f"Created: {todo.id} - {todo.title} - {todo.completed}")
