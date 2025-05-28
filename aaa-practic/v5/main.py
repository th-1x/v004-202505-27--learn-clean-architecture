from infra.cli import TodoCLI
from infra.mem_db import MemDb


def main():
    # Initialize in-memory database
    repo = MemDb()

    # Create CLI interface with the repository
    cli = TodoCLI(repo)

    # Run the CLI
    cli.run()


if __name__ == "__main__":
    main()
