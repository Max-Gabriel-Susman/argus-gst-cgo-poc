

build:
	gcc -c -o cmd/argus-stream-engine-service/pipeline.o pipeline.c
	ar rcs cmd/argus-stream-engine-service/libpipeline.a cmd/argus-stream-engine-service/pipeline.o

clean: 
	rm cmd/argus-stream-engine-service/pipeline.o cmd/argus-stream-engine-service/libpipeline.a

run: 
	go run cmd/argus-stream-engine-service/main.go

test: 
	go test ./...