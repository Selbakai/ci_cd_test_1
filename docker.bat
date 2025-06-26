@echo off
REM Docker helper script for CI/CD Test Project (Windows)

set DOCKER_IMAGE=ci-cd-test
set DOCKER_TAG=latest

if "%1"=="build" goto build
if "%1"=="build-multi" goto build-multi
if "%1"=="run" goto run
if "%1"=="run-multi" goto run-multi
if "%1"=="shell" goto shell
if "%1"=="dev" goto dev
if "%1"=="up" goto up
if "%1"=="down" goto down
if "%1"=="logs" goto logs
if "%1"=="clean" goto clean
if "%1"=="size" goto size
goto usage

:build
echo Building Docker image...
docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .
echo Build complete!
goto end

:build-multi
echo Building multi-stage Docker image...
docker build -f Dockerfile.multistage -t %DOCKER_IMAGE%:multistage .
echo Multi-stage build complete!
goto end

:run
echo Running Docker container...
docker run --rm %DOCKER_IMAGE%:%DOCKER_TAG%
goto end

:run-multi
echo Running multi-stage Docker container...
docker run --rm %DOCKER_IMAGE%:multistage
goto end

:shell
echo Starting interactive shell in container...
docker run --rm -it %DOCKER_IMAGE%:%DOCKER_TAG% sh
goto end

:dev
echo Starting development environment...
docker-compose --profile dev up app-dev
goto end

:up
echo Starting production environment...
docker-compose up -d app
goto end

:down
echo Stopping containers...
docker-compose down
goto end

:logs
echo Showing container logs...
docker-compose logs -f app
goto end

:clean
echo Cleaning up Docker resources...
docker-compose down
docker rmi %DOCKER_IMAGE%:%DOCKER_TAG% %DOCKER_IMAGE%:multistage 2>nul
docker system prune -f
echo Cleanup complete!
goto end

:size
echo Docker image sizes:
docker images | findstr %DOCKER_IMAGE%
goto end

:usage
echo Usage: %0 {build^|build-multi^|run^|run-multi^|shell^|dev^|up^|down^|logs^|clean^|size}
echo.
echo Commands:
echo   build       - Build basic Docker image
echo   build-multi - Build multi-stage Docker image
echo   run         - Run the basic container
echo   run-multi   - Run the multi-stage container
echo   shell       - Start interactive shell in container
echo   dev         - Start development environment
echo   up          - Start production environment
echo   down        - Stop containers
echo   logs        - Show container logs
echo   clean       - Clean up Docker resources
echo   size        - Show Docker image sizes

:end
