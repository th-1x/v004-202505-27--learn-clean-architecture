require_relative 'infrastructure/cli'
require_relative 'infrastructure/mem_db'

def main
  # Initialize in-memory database
  repo = MemDb.new

  # Create CLI interface with the repository
  cli = TodoCLI.new(repo)

  # Run the CLI
  cli.run
end

if __FILE__ == $0
  main
end
