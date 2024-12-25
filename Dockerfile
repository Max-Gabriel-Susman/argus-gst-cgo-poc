# Use an official Golang image as a base
FROM golang:1.21 as builder

# Install build tools for CGo
RUN apt-get update && apt-get install -y build-essential

# Set the working directory
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the application code
COPY . .

# Build the application
RUN go build -o hello .

# Final stage for a lightweight image
FROM debian:bullseye-slim

# Install necessary runtime libraries
RUN apt-get update && apt-get install -y libc6 && rm -rf /var/lib/apt/lists/*

# Copy the built binary from the builder stage
COPY --from=builder /app/hello /usr/local/bin/hello

# Set the entry point
ENTRYPOINT ["/usr/local/bin/hello"]
