from infra.in_mem_db import InMemoryTodoRepository

from infra.cli import TodoCli

def main():
    repo = InMemoryTodoRepository()
    cli = TodoCli(repo)
    cli.run()

if __name__ == "__main__":
    main()