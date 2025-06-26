# Use Alpine Linux with GCC for a lightweight image
FROM alpine:latest

# Install build tools and runtime dependencies
RUN apk update && apk add --no-cache \
    gcc \
    musl-dev \
    make \
    valgrind \
    gdb

# Set working directory
WORKDIR /app

# Copy source files
COPY main.c main.h Makefile ./

# Build the application
RUN make

# Create a non-root user for security
RUN addgroup -g 1000 appgroup && \
    adduser -D -s /bin/sh -u 1000 -G appgroup appuser

# Change ownership of the application
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Set the default command
CMD ["./main"]
