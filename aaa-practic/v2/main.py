from infra.cli import TodoCli
from infra.mem_db import MemDB

def main():
    repo = MemDB()
    cli = TodoCli(repo)
    cli.run()

if __name__ == "__main__":
    main()
    