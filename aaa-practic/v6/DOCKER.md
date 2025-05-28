# Docker Setup for Ruby Todo CLI v6

This directory contains Docker configuration for containerizing the Ruby Todo CLI application following Clean Architecture principles.

## Files Overview

- `Dockerfile` - Multi-stage Docker image definition
- `docker-compose.yml` - Docker Compose configuration for multiple services
- `docker.sh` - Management script for Docker operations
- `.dockerignore` - Files to exclude from Docker build context

## Quick Start

### Using Docker Compose (Recommended)

1. **Build and run interactively:**
   ```bash
   docker-compose up todo-cli
   ```

2. **Run tests:**
   ```bash
   docker-compose up todo-tests
   ```

3. **Run demo:**
   ```bash
   docker-compose up todo-demo
   ```

### Using Docker Directly

1. **Build the image:**
   ```bash
   docker build -t ruby-todo-cli:latest .
   ```

2. **Run interactively:**
   ```bash
   docker run -it --rm ruby-todo-cli:latest
   ```

3. **Run tests:**
   ```bash
   docker run --rm ruby-todo-cli:latest ruby run_tests.rb
   ```

### Using the Management Script

The `docker.sh` script provides convenient commands:

```bash
# Build the image
./docker.sh build

# Run the CLI interactively
./docker.sh run

# Run all tests
./docker.sh test

# Run demo
./docker.sh demo

# Open a shell in the container
./docker.sh shell

# Clean up containers and images
./docker.sh clean

# Show help
./docker.sh help
```

## Docker Configuration Details

### Dockerfile Features

- **Base Image**: `ruby:3.2-alpine` (lightweight Alpine Linux)
- **System Dependencies**: Build tools for native gem compilation
- **Security**: Non-root user execution
- **Optimization**: Multi-layer caching for faster builds
- **Bundle Configuration**: Frozen gemfile for consistent dependencies

### Docker Compose Services

1. **todo-cli**: Interactive CLI service with TTY support
2. **todo-tests**: Automated test runner service
3. **todo-demo**: Demo script runner service

### Environment Variables

- `RUBY_ENV`: Set to `production` for CLI, `test` for testing

## Development vs Production

### Development Mode
```bash
# Mount local directory for live editing
docker-compose up todo-cli
```

### Production Mode
```bash
# Build optimized image without development dependencies
docker build --target production -t ruby-todo-cli:prod .
```

## Troubleshooting

### Docker Permission Issues
If you get permission errors:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or use:
newgrp docker
```

### Build Issues
```bash
# Clean build cache
docker builder prune

# Rebuild without cache
docker build --no-cache -t ruby-todo-cli:latest .
```

### Container Debugging
```bash
# Open shell in container
./docker.sh shell

# Check logs
docker logs ruby-todo-cli
```

## Security Considerations

- Application runs as non-root user (`appuser`)
- No sensitive data in environment variables
- Minimal attack surface with Alpine Linux
- Dependencies locked with `Gemfile.lock`

## Performance Optimization

- Multi-stage build for smaller final image
- Docker layer caching for faster rebuilds
- `.dockerignore` to exclude unnecessary files
- Bundle configuration for faster gem installation

## Integration with CI/CD

Example GitHub Actions workflow:
```yaml
- name: Build and test Docker image
  run: |
    docker build -t ruby-todo-cli:test .
    docker run --rm ruby-todo-cli:test ruby run_tests.rb
```

## Monitoring and Logging

```bash
# Monitor container resources
docker stats ruby-todo-cli

# View container logs
docker logs -f ruby-todo-cli

# Export logs
docker logs ruby-todo-cli > todo-cli.log
```
