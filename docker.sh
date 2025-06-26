#!/bin/bash

# Docker helper script for CI/CD Test Project

set -e

DOCKER_IMAGE="ci-cd-test"
DOCKER_TAG="latest"

case "$1" in
    build)
        echo "Building Docker image..."
        docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
        echo "Build complete!"
        ;;
    
    build-multi)
        echo "Building multi-stage Docker image..."
        docker build -f Dockerfile.multistage -t $DOCKER_IMAGE:multistage .
        echo "Multi-stage build complete!"
        ;;
    
    run)
        echo "Running Docker container..."
        docker run --rm $DOCKER_IMAGE:$DOCKER_TAG
        ;;
    
    run-multi)
        echo "Running multi-stage Docker container..."
        docker run --rm $DOCKER_IMAGE:multistage
        ;;
    
    shell)
        echo "Starting interactive shell in container..."
        docker run --rm -it $DOCKER_IMAGE:$DOCKER_TAG sh
        ;;
    
    dev)
        echo "Starting development environment..."
        docker-compose --profile dev up app-dev
        ;;
    
    up)
        echo "Starting production environment..."
        docker-compose up -d app
        ;;
    
    down)
        echo "Stopping containers..."
        docker-compose down
        ;;
    
    logs)
        echo "Showing container logs..."
        docker-compose logs -f app
        ;;
    
    clean)
        echo "Cleaning up Docker resources..."
        docker-compose down
        docker rmi $DOCKER_IMAGE:$DOCKER_TAG $DOCKER_IMAGE:multistage 2>/dev/null || true
        docker system prune -f
        echo "Cleanup complete!"
        ;;
    
    size)
        echo "Docker image sizes:"
        docker images | grep $DOCKER_IMAGE
        ;;
    
    *)
        echo "Usage: $0 {build|build-multi|run|run-multi|shell|dev|up|down|logs|clean|size}"
        echo ""
        echo "Commands:"
        echo "  build       - Build basic Docker image"
        echo "  build-multi - Build multi-stage Docker image"
        echo "  run         - Run the basic container"
        echo "  run-multi   - Run the multi-stage container"
        echo "  shell       - Start interactive shell in container"
        echo "  dev         - Start development environment"
        echo "  up          - Start production environment"
        echo "  down        - Stop containers"
        echo "  logs        - Show container logs"
        echo "  clean       - Clean up Docker resources"
        echo "  size        - Show Docker image sizes"
        exit 1
        ;;
esac
