# Deployment Guide - Ruby Todo CLI v6

This guide covers various deployment scenarios for the Ruby Todo CLI application.

## Quick Start Deployment

### 1. Local Development
```bash
# Clone and setup
git clone <repository>
cd v6
bundle install
ruby main.rb
```

### 2. Docker Development
```bash
# Build and run
./docker.sh build
./docker.sh run
```

### 3. Production Docker
```bash
# Build optimized image
docker build -t ruby-todo-cli:prod .

# Run in production mode
docker run -d --name todo-cli-prod ruby-todo-cli:prod
```

## Deployment Options

### 1. Standalone Docker Container

**Build and Deploy:**
```bash
# Build image
docker build -t ruby-todo-cli:latest .

# Run detached
docker run -d \
  --name ruby-todo-cli \
  --restart unless-stopped \
  ruby-todo-cli:latest

# Access CLI
docker exec -it ruby-todo-cli ruby main.rb
```

**Health Check:**
```bash
# Check container status
docker ps | grep ruby-todo-cli

# View logs
docker logs ruby-todo-cli

# Test functionality
docker exec ruby-todo-cli ruby demo.rb
```

### 2. Docker Compose Deployment

**docker-compose.prod.yml:**
```yaml
version: '3.8'

services:
  todo-cli:
    build: .
    container_name: ruby-todo-cli-prod
    restart: unless-stopped
    environment:
      - RUBY_ENV=production
    volumes:
      # Persistent data (if needed)
      - todo_data:/app/data
    healthcheck:
      test: ["CMD", "ruby", "-v"]
      interval: 30s
      timeout: 10s
      retries: 3

volumes:
  todo_data:
```

**Deploy:**
```bash
# Production deployment
docker-compose -f docker-compose.prod.yml up -d

# Monitor
docker-compose -f docker-compose.prod.yml logs -f

# Scale (if needed)
docker-compose -f docker-compose.prod.yml up -d --scale todo-cli=3
```

### 3. Kubernetes Deployment

**deployment.yaml:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ruby-todo-cli
  labels:
    app: ruby-todo-cli
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ruby-todo-cli
  template:
    metadata:
      labels:
        app: ruby-todo-cli
    spec:
      containers:
      - name: ruby-todo-cli
        image: ruby-todo-cli:latest
        resources:
          limits:
            memory: "128Mi"
            cpu: "100m"
          requests:
            memory: "64Mi"
            cpu: "50m"
        env:
        - name: RUBY_ENV
          value: "production"
---
apiVersion: v1
kind: Service
metadata:
  name: ruby-todo-cli-service
spec:
  selector:
    app: ruby-todo-cli
  ports:
  - port: 3000
    targetPort: 3000
```

**Deploy to Kubernetes:**
```bash
# Apply configuration
kubectl apply -f deployment.yaml

# Check status
kubectl get pods -l app=ruby-todo-cli
kubectl get services

# Access logs
kubectl logs -l app=ruby-todo-cli -f

# Execute commands
kubectl exec -it <pod-name> -- ruby demo.rb
```

### 4. Cloud Deployment

#### AWS ECS
```bash
# Build and push to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com
docker build -t ruby-todo-cli .
docker tag ruby-todo-cli:latest <account>.dkr.ecr.us-east-1.amazonaws.com/ruby-todo-cli:latest
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/ruby-todo-cli:latest

# Create ECS task definition and service
```

#### Google Cloud Run
```bash
# Build and push to Container Registry
gcloud builds submit --tag gcr.io/PROJECT-ID/ruby-todo-cli

# Deploy to Cloud Run
gcloud run deploy --image gcr.io/PROJECT-ID/ruby-todo-cli --platform managed
```

#### Azure Container Instances
```bash
# Build and push to ACR
az acr build --registry myregistry --image ruby-todo-cli .

# Create container instance
az container create \
  --resource-group myResourceGroup \
  --name ruby-todo-cli \
  --image myregistry.azurecr.io/ruby-todo-cli:latest
```

## Environment Configuration

### Environment Variables
```bash
# Application environment
RUBY_ENV=production          # Environment mode
LOG_LEVEL=info               # Logging level
APP_VERSION=v6               # Application version

# Container configuration
CONTAINER_NAME=ruby-todo-cli # Container name
RESTART_POLICY=unless-stopped # Restart policy
```

### Configuration Files

**config/production.rb:**
```ruby
# Production configuration
class ProductionConfig
  def self.log_level
    ENV.fetch('LOG_LEVEL', 'info')
  end
  
  def self.environment
    ENV.fetch('RUBY_ENV', 'production')
  end
end
```

## Monitoring and Logging

### Health Checks
```bash
# Container health check
docker exec ruby-todo-cli ruby -c "require_relative 'main'; puts 'OK'"

# Application health check
docker exec ruby-todo-cli ruby -e "
  require_relative 'infrastructure/mem_db'
  repo = MemDb.new
  puts 'Health: OK' if repo.count == 0
"
```

### Logging
```bash
# View container logs
docker logs ruby-todo-cli

# Follow logs
docker logs -f ruby-todo-cli

# Export logs
docker logs ruby-todo-cli > todo-cli.log 2>&1
```

### Metrics Collection
```bash
# Container metrics
docker stats ruby-todo-cli

# System metrics
docker exec ruby-todo-cli ps aux
docker exec ruby-todo-cli free -h
docker exec ruby-todo-cli df -h
```

## Security Considerations

### Container Security
- Run as non-root user (appuser)
- Use minimal base image (Alpine Linux)
- No unnecessary packages installed
- Read-only filesystem (optional)

### Network Security
```bash
# Run with restricted network
docker run --network none ruby-todo-cli

# Run with custom network
docker network create todo-network
docker run --network todo-network ruby-todo-cli
```

### Secrets Management
```bash
# Use Docker secrets
echo "secret_key" | docker secret create todo_secret -
docker service create --secret todo_secret ruby-todo-cli
```

## Backup and Recovery

### Data Backup
```bash
# Backup container data
docker run --rm --volumes-from ruby-todo-cli -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz /app/data

# Restore data
docker run --rm --volumes-from ruby-todo-cli -v $(pwd):/backup alpine tar xzf /backup/backup.tar.gz
```

### Image Backup
```bash
# Save image
docker save ruby-todo-cli:latest | gzip > ruby-todo-cli-backup.tar.gz

# Load image
gunzip -c ruby-todo-cli-backup.tar.gz | docker load
```

## Troubleshooting

### Common Issues

1. **Container won't start:**
   ```bash
   docker logs ruby-todo-cli
   docker exec -it ruby-todo-cli /bin/sh
   ```

2. **Permission issues:**
   ```bash
   docker exec -it ruby-todo-cli ls -la
   docker exec -it ruby-todo-cli whoami
   ```

3. **Network issues:**
   ```bash
   docker network ls
   docker inspect ruby-todo-cli
   ```

4. **Resource issues:**
   ```bash
   docker stats ruby-todo-cli
   docker system df
   ```

### Debug Commands
```bash
# Interactive debugging
./docker.sh shell

# Run specific commands
docker exec ruby-todo-cli ruby -v
docker exec ruby-todo-cli bundle list
docker exec ruby-todo-cli ls -la

# Check Ruby environment
docker exec ruby-todo-cli ruby -e "puts RUBY_VERSION"
docker exec ruby-todo-cli ruby -e "puts Gem.loaded_specs.keys"
```

## Performance Optimization

### Image Optimization
```bash
# Multi-stage build
# Alpine base image
# Minimal dependencies
# Layer caching
```

### Runtime Optimization
```bash
# Set memory limits
docker run -m 128m ruby-todo-cli

# Set CPU limits
docker run --cpus=".5" ruby-todo-cli

# Use read-only filesystem
docker run --read-only ruby-todo-cli
```

### Scaling
```bash
# Horizontal scaling with Docker Compose
docker-compose up -d --scale todo-cli=3

# Load balancing (if adding web interface)
# Use nginx or HAProxy
```
