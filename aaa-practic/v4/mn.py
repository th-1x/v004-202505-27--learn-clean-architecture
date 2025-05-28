from infra.cli import TdCli
from infra.mem_db import MemDb

def main():
    # Initialize the in-memory database
    repo = MemDb()
    
    # Create the CLI interface with the repository
    cli = TdCli(repo)
    
    # Run the CLI
    cli.run()
if __name__ == "__main__":
    main()
    