

# build:
# 	gcc -c -o cmd/argus-stream-engine-service/pipeline.o pipeline.c
# 	ar rcs cmd/argus-stream-engine-service/libpipeline.a cmd/argus-stream-engine-service/pipeline.o

build: 
	gcc -c -o gst_pipeline.o gst_pipeline.c `pkg-config --cflags gstreamer-1.0`
	ar rcs libgst_pipeline.a gst_pipeline.o


# clean: 
# 	rm cmd/argus-stream-engine-service/pipeline.o cmd/argus-stream-engine-service/libpipeline.a

clean: 
	rm gst_pipeline.o libgst_pipeline.a

run: 
	go run cmd/argus-stream-engine-service/main.go

test: 
	go test ./...