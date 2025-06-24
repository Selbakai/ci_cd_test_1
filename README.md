# CI/CD Test Project

This is a simple C project demonstrating CI/CD pipeline with GitHub Actions.

## Features

- Multi-platform builds (Linux, Windows, macOS)
- Automated testing with GitHub Actions
- Memory leak detection with Valgrind
- Professional Makefile for build management

## Building the Project

### Using Makefile (Recommended)

```bash
make           # Build the project
make run       # Build and run
make debug     # Build with debug symbols
make release   # Build optimized release version
make clean     # Clean build artifacts
```

### Manual Compilation

```bash
gcc -Wall -Wextra -std=c99 -o main main.c
./main
```

## CI/CD Pipeline

The project includes a GitHub Actions workflow that:

- ✅ Builds on Ubuntu, Windows, and macOS
- ✅ Runs automated tests
- ✅ Checks for memory leaks (Linux)
- ✅ Validates code compilation across platforms

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── ci.yml          # CI/CD workflow
├── main.c                  # Main source file
├── main.h                  # Header file
├── Makefile               # Build configuration
└── README.md              # This file
```

## Getting Started

1. Clone the repository
2. Run `make` to build
3. Run `make run` to execute
4. Push changes to trigger CI/CD pipeline

## Requirements

- GCC compiler
- Make (optional but recommended)
- Git for version control
