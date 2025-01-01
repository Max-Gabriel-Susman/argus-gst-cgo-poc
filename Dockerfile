# ----------------------------------------
# Stage 1: Build the Go application
# ----------------------------------------
FROM golang:1.20 AS builder

# Install any build dependencies required by CGO (for GStreamer headers, etc.)
# On Debian/Ubuntu-based images, we might do:
RUN apt-get update && apt-get install -y \
    pkg-config \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum first (for caching module downloads)
COPY go.mod go.sum ./
RUN go mod download

# Now copy the rest of the source
COPY . .

# Build the Go binary (static or shared). 
# The CGO_ENABLED=1 is crucial since we rely on CGO for GStreamer calls.
ENV CGO_ENABLED=1
RUN go build -o /go/bin/app ./cmd/main.go

# ----------------------------------------
# Stage 2: Final runtime image
# ----------------------------------------
FROM ubuntu:22.04

# Install GStreamer runtimes (but not necessarily all the dev packages)
RUN apt-get update && apt-get install -y \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a user (optional, for security)
RUN useradd -ms /bin/bash gstuser

# Create a directory to store HLS segments (optional)
RUN mkdir -p /var/www/hls
RUN chown gstuser:gstuser /var/www/hls

# Copy the compiled Go binary from stage 1
COPY --from=builder /go/bin/app /usr/local/bin/app

# Switch to the non-root user
USER gstuser

# Expose any ports if needed (for RTMP or serving HLS with an internal server)
# If you're only pulling RTMP from an external server, you might not need to expose 1935.
EXPOSE 8080

# By default, run the Go app
ENTRYPOINT ["/usr/local/bin/app"]
