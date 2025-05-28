#!/bin/bash

# Docker management script for Ruby Todo CLI v6

set -e

# Check if we can access docker without sudo, if not use sg docker
check_docker_access() {
    if ! docker info >/dev/null 2>&1; then
        if getent group docker | grep -q "$USER"; then
            print_warning "Docker group membership detected but not active. Using 'sg docker' for commands..."
            DOCKER_CMD="sg docker -c"
        else
            print_error "No Docker access. Please run: sudo usermod -aG docker $USER"
            print_error "Then log out and log back in, or run: newgrp docker"
            exit 1
        fi
    else
        DOCKER_CMD=""
    fi
}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Help function
show_help() {
    echo "Docker management script for Ruby Todo CLI v6"
    echo
    echo "Usage: $0 [command]"
    echo
    echo "Commands:"
    echo "  build     - Build the Docker image"
    echo "  run       - Run the Todo CLI interactively"
    echo "  test      - Run all tests in container"
    echo "  demo      - Run the demo script"
    echo "  shell     - Open a shell in the container"
    echo "  clean     - Remove containers and images"
    echo "  logs      - Show container logs"
    echo "  help      - Show this help message"
    echo
}

# Build Docker image
build_image() {
    check_docker_access
    print_status "Building Docker image..."
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker build -t ruby-todo-cli:latest ."
    else
        docker build -t ruby-todo-cli:latest .
    fi
    print_success "Docker image built successfully!"
}

# Run interactive CLI
run_cli() {
    check_docker_access
    print_status "Starting Todo CLI..."
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker run -it --rm --name ruby-todo-cli ruby-todo-cli:latest"
    else
        docker run -it --rm \
            --name ruby-todo-cli \
            ruby-todo-cli:latest
    fi
}

# Run tests
run_tests() {
    check_docker_access
    print_status "Running tests in container..."
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker run --rm --name ruby-todo-tests ruby-todo-cli:latest ruby run_tests.rb"
    else
        docker run --rm \
            --name ruby-todo-tests \
            ruby-todo-cli:latest \
            ruby run_tests.rb
    fi
}

# Run demo
run_demo() {
    check_docker_access
    print_status "Running demo in container..."
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker run --rm --name ruby-todo-demo ruby-todo-cli:latest ruby demo.rb"
    else
        docker run --rm \
            --name ruby-todo-demo \
            ruby-todo-cli:latest \
            ruby demo.rb
    fi
}

# Open shell
open_shell() {
    check_docker_access
    print_status "Opening shell in container..."
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker run -it --rm --name ruby-todo-shell ruby-todo-cli:latest /bin/sh"
    else
        docker run -it --rm \
            --name ruby-todo-shell \
            ruby-todo-cli:latest \
            /bin/sh
    fi
}

# Clean up
clean_up() {
    check_docker_access
    print_status "Cleaning up Docker containers and images..."
    
    # Stop and remove containers
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker ps -aq --filter 'name=ruby-todo' | xargs -r docker stop"
        $DOCKER_CMD "docker ps -aq --filter 'name=ruby-todo' | xargs -r docker rm"
        # Remove images
        $DOCKER_CMD "docker images -q ruby-todo-cli | xargs -r docker rmi"
    else
        docker ps -aq --filter "name=ruby-todo" | xargs -r docker stop
        docker ps -aq --filter "name=ruby-todo" | xargs -r docker rm
        # Remove images
        docker images -q ruby-todo-cli | xargs -r docker rmi
    fi
    
    print_success "Cleanup completed!"
}

# Show logs
show_logs() {
    check_docker_access
    print_status "Showing container logs..."
    if [ -n "$DOCKER_CMD" ]; then
        $DOCKER_CMD "docker logs ruby-todo-cli" 2>/dev/null || print_warning "No running container found"
    else
        docker logs ruby-todo-cli 2>/dev/null || print_warning "No running container found"
    fi
}

# Main script logic
case "$1" in
    build)
        build_image
        ;;
    run)
        run_cli
        ;;
    test)
        run_tests
        ;;
    demo)
        run_demo
        ;;
    shell)
        open_shell
        ;;
    clean)
        clean_up
        ;;
    logs)
        show_logs
        ;;
    help|--help|-h)
        show_help
        ;;
    "")
        print_warning "No command specified. Use 'help' to see available commands."
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
